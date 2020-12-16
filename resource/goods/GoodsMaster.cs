﻿using enums;
using enums.track;
using GalaSoft.MvvmLight.Messaging;
using module.area;
using module.goods;
using module.msg;
using module.rf;
using module.track;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Threading;

namespace resource.goods
{
    public class GoodsMaster
    {
        #region[构造/初始化]

        public GoodsMaster()
        {
            _go = new object();
            _so = new object();
            GoodsList = new List<Goods>();
            StockList = new List<Stock>();
            StockSumList = new List<StockSum>();
            mMsg = new MsgAction();
        }

        public void Start()
        {
            Refresh();
        }

        public void Refresh(bool refr_1 = true, bool refr_2 = true, bool refr_3 = true)
        {

            if (refr_1)
            {
                GoodsList.Clear();
                GoodsList.AddRange(PubMaster.Mod.GoodSql.QueryGoodsList());
            }

            if (refr_2)
            {
                StockList.Clear();
                StockList.AddRange(PubMaster.Mod.GoodSql.QueryStockList());
            }

            if (refr_3)
            {
                StockSumList.Clear();
                StockSumList.AddRange(PubMaster.Mod.GoodSql.QueryStockSumList());
            }
        }

        public void Stop()
        {

        }
        #endregion

        #region[字段]
        private readonly object _go, _so;
        private List<Goods> GoodsList { set; get; }
        private List<Stock> StockList { set; get; }
        private List<StockSum> StockSumList { set; get; }
        private MsgAction mMsg;
        #endregion

        #region[获取对象]

        #region[品种]
        public List<Goods> GetGoodsList()
        {
            return GoodsList;
        }

        public Goods GetGoods(uint id)
        {
            return GoodsList.Find(c => c.id == id);
        }
        #endregion

        #region[库存]

        public Stock GetStock(int id)
        {
            return StockList.Find(c => c.id == id);
        }

        public List<Stock> GetStocks(uint traid)
        {
            return StockList.FindAll(c => c.track_id == traid);
        }

        public List<StockSum> GetStockSums()
        {
            SortSumList();
            return StockSumList;
        }

        public List<StockSum> GetStockSums(int areaid)
        {
            if (areaid == 0) return StockSumList;
            return StockSumList.FindAll(c => c.area == areaid).ToList() ;
        }

        #endregion

        #endregion

        #region[获取/判断属性]

        #region[品种]
        public string GetGoodsName(uint Goods_id)
        {
            return GoodsList.Find(c => c.id == Goods_id)?.name ?? "";
        }

        #endregion

        #region[库存]

        public uint GetTrackStock(uint trackid)
        {
            return StockSumList.Find(c => c.track_id == trackid)?.stack ?? 0;
        }

        public bool AddTrackStocks(uint tileid, uint trackid, uint goodsid, byte pieces, DateTime? produceTime, byte stockqty, string memo)
        {
            if(Monitor.TryEnter(_so, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    for (int i = 0; i < stockqty; i++)
                    {
                        AddStock(tileid, trackid, goodsid, pieces, produceTime);
                    }

                    CheckStockTop(trackid);
                    CheckTrackSum(trackid);
                    PubMaster.Track.UpdateStockStatus(trackid, TrackStockStatusE.有砖, memo);
                    return true;
                }
                finally
                {
                    Monitor.Exit(_so);
                }
            }
            return false;
        }

        public List<Goods> GetGoodsList(uint filterarea)
        {
            if (filterarea == 0) return GetGoodsList();
            return GoodsList.FindAll(c => c.area_id == filterarea);
        }

        public List<Goods> GetStockOutGoodsList(uint filterarea)
        {
            List<uint> goodsids = StockList.FindAll(c => c.area == filterarea 
                && (c.TrackType == TrackTypeE.储砖_出 || c.TrackType == TrackTypeE.储砖_出入)).Select(t => t.goods_id).ToList();

            return GoodsList.FindAll(c => c.area_id == filterarea && goodsids.Contains(c.id));
        }

        public List<StockGoodPack> GetStockOutGoodsInsList()
        {
            List<StockGoodPack> list = new List<StockGoodPack>();
            foreach(Stock stock in StockList.FindAll(c => c.TrackType == TrackTypeE.储砖_出 || c.TrackType == TrackTypeE.储砖_出入))
            {
                if(!list.Exists(c=>c.Area == stock.area && c.GoodsId == stock.goods_id))
                {
                    list.Add(new StockGoodPack()
                    {
                        Area = stock.area,
                        GoodsId = stock.goods_id
                    }) ;
                }
            }
            return list;
        }

        public uint GetTrackTopStockId(uint trackid)
        {
            uint stockid = StockList.Find(c => c.track_id == trackid && c.PosType == StockPosE.顶部)?.id ?? 0;
            if (stockid == 0)
            {
                stockid = CheckStockTop(trackid);
            }
            return stockid;
        }

        public Stock GetTrackTopStock(uint trackid)
        {
            Stock stock = StockList.Find(c => c.track_id == trackid && c.PosType == StockPosE.顶部);
            if (stock == null)
            {
                stock = CheckGetStockTop(trackid);
            }
            return stock;
        }

        public bool HaveStockInTrack(uint trackid, uint goodsid, out uint stockid)
        {
            stockid = StockList.Find(c => c.track_id == trackid && c.goods_id == goodsid)?.id ?? 0;
            return stockid != 0;
        }

        public bool ExistStockInTrack(uint trackid)
        {
            return StockList.Exists(c => c.track_id == trackid);
        }
        
        public bool ExistStockInTrack(uint trackid, uint goodid)
        {
            return StockList.Exists(c => c.track_id == trackid && c.goods_id == goodid);
        }

        public bool ExistStockInTrackByGid(uint goodid)
        {
            return StockList.Exists(c => c.goods_id == goodid &&
                (c.TrackType == TrackTypeE.储砖_入 || c.TrackType == TrackTypeE.储砖_出 || c.TrackType == TrackTypeE.储砖_出入));
        }

        #endregion

        #endregion

        #region[增删改]

        #region[品种]
        public bool AddGoods(Goods good, out string result)
        {
            if (GoodsList.Exists(c => c.area_id == good.area_id
                                    && c.width == good.width
                                    && c.length == good.length
                                    && (c.color.Equals(good.color) || c.name.Equals(good.name))))
            {
                result = "已经存在一样的规格的信息了！";
                return false;
            }

            if (!Monitor.TryEnter(_go, TimeSpan.FromSeconds(2)))
            {
                result = "";
                return false;
            }

            try
            {
                uint goodid = PubMaster.Dic.GenerateID(DicTag.NewGoodId);
                good.id = goodid;
                good.GoodCarrierType = PubMaster.Area.GetCarrierType(good.area_id);
                PubMaster.Mod.GoodSql.AddGoods(good);
                GoodsList.Add(good);
                SendMsg(good, ActionTypeE.Add);
                result = "";
                return true;
            }
            finally
            {
                Monitor.Exit(_go);
            }
        }

        public void UpdateStockProTime(uint id, DateTime? produceTime)
        {
            if (!Monitor.TryEnter(_so, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    Stock stock = StockList.Find(c => c.id == id);
                    if (stock != null)
                    {
                        stock.produce_time = produceTime;
                        PubMaster.Mod.GoodSql.EditStock(stock, StockUpE.ProduceTime);
                    }
                }
                finally { Monitor.Exit(_so); }
            }
        }

        public bool ChangeStockGood(uint trackid, uint goodid, bool changedate, DateTime? newdate)
        {
            if (Monitor.TryEnter(_so, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    List<Stock> stocks = StockList.FindAll(c => c.track_id == trackid);
                    foreach (Stock stock in stocks)
                    {
                        if (changedate && newdate != null)
                        {
                            stock.produce_time = newdate;
                        }
                        stock.goods_id = goodid;
                        PubMaster.Mod.GoodSql.EditStock(stock, StockUpE.Goods);
                    }

                    StockSumChangeGood(trackid, goodid);
                    SortSumList();
                    return true;
                }
                finally { Monitor.Exit(_so); }
            }
            return false;
        }

        private void StockSumChangeGood(uint trackid, uint goodid)
        {
            StockSum sum = StockSumList.Find(c => c.track_id == trackid);
            if (sum != null)
            {
                sum.goods_id = goodid;
                sum.produce_time = GetEarliestTime(trackid);
                SendSumMsg(sum, ActionTypeE.Update);
            }
        }

        private DateTime? GetEarliestTime(uint trackid)
        {
            Stock stock = StockList.Find(c => c.track_id == trackid && c.PosType == StockPosE.顶部);
            if (stock != null)
            {
                return stock.produce_time;
            }
            DateTime? earytime = null;
            List<Stock> list = StockList.FindAll(c => c.track_id == trackid);
            foreach (Stock item in list)
            {
                if(earytime == null)
                {
                    earytime = item.produce_time;
                }

                if(earytime is DateTime areat && item.produce_time is DateTime stime)
                {
                    if(stime.CompareTo(areat) < 0)
                    {
                        earytime = stime;
                    }
                }
            }

            return earytime;
        }

        public bool EditGood(Goods good, out string result)
        {
            if (!Monitor.TryEnter(_go, TimeSpan.FromSeconds(2)))
            {
                result = "";
                return false;
            }
            try
            {
                Goods g = GoodsList.Find(c => c.id == good.id);
                if (g != null)
                {
                    g.name = good.name;
                    g.color = good.color;
                    g.width = good.width;
                    g.length = good.length;
                    g.oversize = good.oversize;
                    g.memo = good.memo;
                    g.stack = good.stack;
                    g.pieces = good.pieces;
                    g.carriertype = good.carriertype;
                    g.updatetime = DateTime.Now;
                    PubMaster.Mod.GoodSql.EditGoods(g);
                    SendMsg(g, ActionTypeE.Update);
                    result = "";
                    return true;
                }
            }
            finally { Monitor.Exit(_go); }

            result = "找不到该品种信息：" + good.name;
            return false;
        }

        public bool DeleteGood(uint goodid, out string result)
        {
            if (PubMaster.Device.ExistDevByGid(goodid))
            {
                result = "砖机配置了该规格！";
                return false;
            }

            if (PubMaster.Goods.ExistStockInTrackByGid(goodid))
            {
                result = "储砖库存内有该规格";
                return false;
            }

            if (!Monitor.TryEnter(_go, TimeSpan.FromSeconds(2)))
            {
                result = "";
                return false;
            }
            try
            {
                Goods gs = GetGoods(goodid);
                if (gs != null)
                {
                    DeleteStockByGid(goodid);
                    Thread.Sleep(500);

                    PubMaster.Mod.GoodSql.DeleteGoods(gs);
                    GoodsList.Remove(gs);
                    SendMsg(gs, ActionTypeE.Delete);
                    result = "删除成功：" + gs.name;
                    return true;
                }
            }
            finally { Monitor.Exit(_go); }

            result = "删除失败！";
            return false;
        }

        #endregion

        #region[库存]

        /// <summary>
        /// 添加库存
        /// </summary>
        /// <param name="trackid"></param>
        /// <param name="goodid"></param>
        /// <param name="transid"></param>
        public uint AddStock(uint tile_id, uint trackid, uint goodid, byte fullqty, DateTime? producetime = null)
        {
            if(Monitor.TryEnter(_go, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    uint newid = PubMaster.Dic.GenerateID(DicTag.NewStockId);
                    byte stack = PubMaster.Goods.GetGoodStack(goodid);
                    ushort allpieces = (ushort)(stack * fullqty);
                    Track track = PubMaster.Track.GetTrack(trackid);
                    Stock stock = new Stock()
                    {
                        id = newid,
                        track_id = trackid,
                        goods_id = goodid,
                        produce_time = producetime ?? DateTime.Now,
                        stack = stack,
                        pieces = allpieces, //总片数
                        tilelifter_id = tile_id,
                        area = track.area,
                        track_type = track.type
                    };

                    UpdateTrackPos(stock);
                    StockList.Add(stock);
                    PubMaster.Mod.GoodSql.AddStock(stock);
                    return newid;
                }
                finally
                {
                    Monitor.Exit(_go);
                }
            }
            return 0;
        }

        public bool DeleteStock(uint stockid, out string rs)
        {
            Stock stock = StockList.Find(c => c.id == stockid);
            if(stock == null)
            {
                rs = "找不到库存记录";
                return false;
            }

            StockList.Remove(stock);
            PubMaster.Mod.GoodSql.DeleteStock(stock);
            StockSumChange(stock, 0);
            if(stock.PosType == StockPosE.顶部)
            {
                CheckStockTop(stock.track_id);
            }
            rs = "";
            return true;
        }

        public void DeleteStockByGid(uint goodid)
        {
            List<Stock> stocks = StockList.FindAll(c => c.goods_id == goodid);
            if (stocks == null || stocks.Count == 0)
            {
                return;
            }

            foreach (Stock s in stocks)
            {
                StockList.Remove(s);
                PubMaster.Mod.GoodSql.DeleteStock(s);
                StockSumChange(s, 0);
            }
        }

        private byte GetGoodStack(uint goodid)
        {
            return GoodsList.Find(c => c.id == goodid)?.stack ?? 1;
        }

        //检查并更新轨道库存为空
        public void RemoveStock(uint trackid)
        {
            StockList.RemoveAll(c => c.track_id == trackid);
            PubMaster.Mod.GoodSql.DeleteStock(trackid);
        }

        /// <summary>
        /// 倒库/库存信息调整
        /// </summary>
        /// <param name="taketrackid"></param>
        public bool ShiftStock(uint taketrackid, uint givetrackid)
        {
            if(Monitor.TryEnter(_so, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    if (!PubMaster.Track.IsBrotherTrack(taketrackid, givetrackid)) return false;

                    //if (PubMaster.Track.IsTrackFull(givetrackid)
                    //    && PubMaster.Track.IsTrackEmtpy(taketrackid))
                    //{
                    //    return true;
                    //}

                    Track givetrack = PubMaster.Track.GetTrack(givetrackid);
                    Track taketrack = PubMaster.Track.GetTrack(taketrackid);
                    if (givetrack != null && taketrack != null
                        && givetrack.StockStatus == TrackStockStatusE.空砖
                        //&& taketrack.StockStatus == TrackStockStatusE.满砖
                        )
                    {
                        List<Stock> stocks = StockList.FindAll(c => c.track_id == taketrack.id);
                        foreach (Stock stock in stocks)
                        {
                            stock.track_id = givetrack.id;
                            stock.area = givetrack.area;
                            stock.track_type = givetrack.type;
                            PubMaster.Mod.GoodSql.EditStock(stock, StockUpE.Track);
                        }

                        PubMaster.Track.ShiftTrack(taketrack.id, givetrack.id);
                        UpdateShiftStockSum(taketrackid, givetrackid, givetrack.type);
                        return true;
                    }
                }
                finally
                {
                    Monitor.Exit(_so);
                }
            }
            return false;
        }

        public ushort GetTrackStockCount(uint id)
        {
            return (ushort)StockList.Count(c => c.track_id == id);
        }

        /// <summary>
        /// 根据上砖机,品种，分配库存
        /// 1.优先分配，非满砖轨道
        /// 2.在满砖轨道中，分配时间最早的轨道
        /// </summary>
        /// <param name="tilelifterid"></param>
        /// <param name="goodsid"></param>
        /// <param name="stockid"></param>
        /// <param name="taketrackid"></param>
        /// <returns></returns>
        public bool GetStock(uint areaid, uint tilelifterid, uint goodsid, out List<Stock> allocatstocks)
        {
            allocatstocks = new List<Stock>();

            //1.找到上砖机配置的轨道
            List<AreaDeviceTrack> devtrack = PubMaster.Area.GetAreaDevTraList(areaid, tilelifterid);

            //2.根据优先级查看非空且是需求的品种的轨道
            List<Stock> stocks = StockList.FindAll(c => c.goods_id == goodsid 
                                                    && c.PosType == StockPosE.顶部 
                                                    &&  devtrack.Exists(d => d.track_id == c.track_id));
            
            if(stocks.Count == 0)
            {
                //找不到库存
                return false;
            }

            stocks.Sort((x, y) => x.pos.CompareTo(y.pos));
            //foreach (Stock stock in stocks)
            //{
            //    //优先取非满的轨道
            //    if (stock.pos > 1 && PubMaster.Track.IsTrackHaveStock(stock.track_id)
            //        && PubMaster.Track.IsTrackEnable(stock.track_id))
            //    {
            //        allocatstocks.Add(stock);
            //    }
            //}

            //全部都是满砖，则找时间最早的库存
            stocks.Sort(
                (x, y) => 
                {
                    if(x.produce_time is DateTime xtime && y.produce_time is DateTime ytime)
                    {
                        return xtime.CompareTo(ytime);
                    }
                    return 0;
                }
            );

            foreach (Stock stock1 in stocks)
            {
                if (PubMaster.Track.IsTrackEnable(stock1.track_id))
                {
                    allocatstocks.Add(stock1);
                }
            }
            
            return allocatstocks.Count>0;
        }

        /// <summary>
        /// 根据上砖机,品种，分配库存
        /// 1.优先分配，非满砖轨道
        /// 2.在满砖轨道中，分配时间最早的轨道
        /// </summary>
        /// <param name="tilelifterid"></param>
        /// <param name="goodsid"></param>
        /// <param name="stockid"></param>
        /// <param name="taketrackid"></param>
        /// <returns></returns>
        public List<Stock> GetStock(uint areaid, uint tilelifterid, uint goodsid)
        {
            //1.找到上砖机配置的轨道
            List<AreaDeviceTrack> devtrack = PubMaster.Area.GetAreaDevTraList(areaid, tilelifterid);

            //2.根据优先级查看非空且是需求的品种的轨道
            List<Stock> stocks = StockList.FindAll(c => c.goods_id == goodsid 
                                                    && c.PosType == StockPosE.顶部 
                                                    &&  devtrack.Exists(d => d.track_id == c.track_id));
            
            if(stocks.Count == 0)
            {
                return new List<Stock>();
            }

            stocks.Sort((x, y) => x.pos.CompareTo(y.pos));
            //foreach (Stock stock in stocks)
            //{
            //    //优先取非满的轨道
            //    if (stock.pos > 1 && PubMaster.Track.IsTrackHaveStock(stock.track_id)
            //        && PubMaster.Track.IsTrackEnable(stock.track_id))
            //    {
            //        return new List<Stock>() { stock };
            //    }
            //}

            //全部都是满砖，则找时间最早的库存
            stocks.Sort(
                (x, y) => 
                {
                    if(x.produce_time is DateTime xtime && y.produce_time is DateTime ytime)
                    {
                        return xtime.CompareTo(ytime);
                    }
                    return 0;
                }
            );
            
            return stocks.FindAll(c=> PubMaster.Track.IsTrackEnable(c.track_id));
        }


        /// <summary>
        /// 转移库存
        /// </summary>
        /// <param name="stock_id"></param>
        /// <param name="to_track_id"></param>
        public void MoveStock(uint stock_id, uint to_track_id)
        {
            Stock stock = StockList.Find(c => c.id == stock_id);
            if(stock != null && stock.track_id != to_track_id)
            {
                uint from_track_id = stock.track_id;

                bool istostore = PubMaster.Track.IsStoreTrack(to_track_id);
                bool isfromstore = PubMaster.Track.IsStoreTrack(from_track_id);

                StockSumChange(stock, to_track_id);
                Track totrack = PubMaster.Track.GetTrack(to_track_id);
                stock.track_id = to_track_id;
                stock.area = totrack.area;
                stock.track_type = totrack.type;
                #region[更新储砖轨道]

                if (istostore)
                {
                    UpdateTrackPos(stock);
                    PubMaster.Mod.GoodSql.EditStock(stock, StockUpE.Pos);
                }

                if (isfromstore)
                {
                    CheckStockTop(from_track_id);

                    if (PubMaster.Track.IsTrackFull(from_track_id))
                    {
                        PubMaster.Track.UpdateStockStatus(from_track_id, TrackStockStatusE.有砖, "");
                    }
                }

                #endregion

                PubMaster.Mod.GoodSql.EditStock(stock, StockUpE.Track);

                PubMaster.Track.UpdateStockStatus(to_track_id, TrackStockStatusE.有砖, "");

                //由设备检查轨道没砖后才制空轨道
                //if(!ExistStockInTrack(from_track_id) 
                //    && !PubMaster.Track.IsStoreTrack(from_track_id))
                //{
                //    PubMaster.Track.UpdateStockStatus(from_track_id, TrackStockStatusE.空砖);
                //}

            }
        }

        /// <summary>
        /// 更新库存的Pos
        /// </summary>
        /// <param name="stock"></param>
        public void UpdateTrackPos(Stock stock)
        {
            short storecount = (short)StockList.Count(c =>c.track_id == stock.track_id && c.id != stock.id);
            stock.pos = storecount;
            stock.PosType = StockPosE.其他;

            if (storecount == 0)
            {
                stock.PosType = StockPosE.顶部;
            }
        }

        /// <summary>
        /// 添加下砖记录
        /// </summary>
        /// <param name="stockid"></param>
        public void AddStockInLog(uint stockid)
        {
            Stock stock = StockList.Find(c => c.id == stockid);
            if(stock != null)
            {
                PubMaster.Mod.GoodSql.AddStockInLog(stock);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="give_track_id"></param>
        /// <returns></returns>
        public bool IsTrackReachMinStackCount(uint goodid, uint trackid)
        {
            Goods goods = GetGoods(goodid);
            if (goods != null){

                return goods.minstack <= StockList.Count(c => c.track_id == trackid);
            }
            return true;
        }


        /// <summary>
        /// 生成上砖记录
        /// </summary>
        /// <param name="stockid"></param>
        /// <param name="iD"></param>
        /// <param name="leftTrackId"></param>
        public void AddStockOutLog(uint stockid, uint trackid, uint tileid)
        {

            Stock stock = StockList.Find(c => c.id == stockid);
            if (stock != null)
            {
                PubMaster.Mod.GoodSql.AddStockOutLog(stock, trackid, tileid);
            }
        }

        /// <summary>
        /// 判断轨道是否没有库存
        /// </summary>
        /// <param name="trackid"></param>
        /// <returns></returns>
        public bool IsTrackStockEmpty(uint trackid)
        {
            return !StockList.Exists(c => c.track_id == trackid);
        }

        /// <summary>
        /// 检查是否有Top,并且更新为顶部
        /// </summary>
        /// <param name="trackid"></param>
        public uint CheckStockTop(uint trackid)
        {
            if(!StockList.Exists(c=>c.track_id == trackid && c.PosType == StockPosE.顶部))
            {
                List<Stock> stocks = StockList.FindAll(c => c.track_id == trackid);
                if (stocks.Count > 0)
                {
                    stocks.Sort((x, y) => x.pos.CompareTo(y.pos));
                    SetStockTop(stocks[0]);
                    return stocks[0].id;
                }
            }
            return 0;
        }

        public Stock CheckGetStockTop(uint trackid)
        {
            if (!StockList.Exists(c => c.track_id == trackid && c.PosType == StockPosE.顶部))
            {
                List<Stock> stocks = StockList.FindAll(c => c.track_id == trackid);
                if (stocks.Count > 0)
                {
                    stocks.Sort((x, y) => x.pos.CompareTo(y.pos));
                    SetStockTop(stocks[0]);
                    return stocks[0];
                }
            }
            return StockList.Find(c => c.track_id == trackid && c.PosType == StockPosE.顶部);
        }

        public void SetStockTop(Stock stock)
        {
            if (stock == null) return;
            stock.PosType = StockPosE.顶部;
            PubMaster.Mod.GoodSql.EditStock(stock, StockUpE.PosType);
        }


        #endregion

        #region[库存统计]
        private void StockSumChange(Stock stock, uint totrackid)
        {
            bool isadd;
            bool istostore = PubMaster.Track.IsStoreTrack(totrackid);
            bool isfromstore = PubMaster.Track.IsStoreTrack(stock.track_id);
            if (istostore || isfromstore)
            {
                isadd = istostore;
                StockSum sum;
                if (istostore)
                {
                    sum = StockSumList.Find(c => c.track_id == totrackid);
                }
                else
                {
                    sum = StockSumList.Find(c => c.track_id == stock.track_id);
                }

                if(sum != null)
                {
                    if (isadd)
                    {
                        sum.count += 1;
                        sum.stack += stock.stack;
                        sum.pieces += stock.pieces;
                    }
                    else
                    {
                        sum.count -= 1;
                        sum.stack -= stock.stack;
                        sum.pieces -= stock.pieces;
                    }

                    if (sum.count == 0)
                    {
                        StockSumList.Remove(sum);
                        SendSumMsg(sum, ActionTypeE.Delete);
                    }
                    else
                    {
                        if (isfromstore)
                        {
                            sum.produce_time = GetEarliestTime(sum.track_id);
                        }
                        SendSumMsg(sum, ActionTypeE.Update);
                    }
                }

                if (sum == null && isadd)
                {
                    Track track = PubMaster.Track.GetTrack(totrackid);
                    sum = new StockSum()
                    {
                        count = 1,
                        goods_id = stock.goods_id,
                        track_id = totrackid,
                        pieces = stock.pieces,
                        stack = stock.stack,
                        produce_time = stock.produce_time,
                        area = track.area,
                        track_type = track.type
                    };
                    StockSumList.Add(sum);
                    SendSumMsg(sum, ActionTypeE.Add);
                    SortSumList();
                }
            }
        }

        public bool IsStockWithGood(uint stockid, uint goodsId)
        {
            return StockList.Exists(c => c.id == stockid && c.goods_id == goodsId);
        }

        private void UpdateShiftStockSum(uint taketrackid, uint givetrackid, byte type)
        {
            List<StockSum> takesums = StockSumList.FindAll(c => c.track_id == taketrackid);

            foreach (StockSum sum in takesums)
            {
                SendSumMsg(sum, ActionTypeE.Delete);
                sum.track_id = givetrackid;
                sum.track_type = type;
                SendSumMsg(sum, ActionTypeE.Add);
            }
        }
        public uint GetStockTileId(uint stock_id)
        {
            return StockList.Find(c => c.id == stock_id && c.tilelifter_id != 0)?.tilelifter_id ?? 0;
        }

        public CarrierTypeE GetGoodsCarrierType(uint goods_id)
        {
            return GoodsList.Find(c => c.id == goods_id).GoodCarrierType;
        }

        private void RemoveTrackSum(uint trackid)
        {
            StockSum sum = StockSumList.Find(c => c.track_id == trackid);
            if (sum != null)
            {
                StockSumList.Remove(sum);
                SendSumMsg(sum, ActionTypeE.Delete);
            }
        }

        private void SendSumMsg(StockSum sum , ActionTypeE type)
        {
            mMsg.o1 = sum;
            mMsg.o2 = type;
            Messenger.Default.Send(mMsg, MsgToken.StockSumeUpdate);
        }


        public void CheckTrackSum(uint trackId)
        {
            StockSum sum = StockSumList.Find(c => c.track_id == trackId);

            uint goodsid = StockList.Find(c => c.track_id == trackId && c.goods_id != 0)?.goods_id ?? 0;

            if (sum == null)
            {
                Track track = PubMaster.Track.GetTrack(trackId);
                sum = new StockSum()
                {
                    track_id = trackId,
                    goods_id = goodsid,
                    produce_time = StockList.Find(c=>trackId == c.track_id).produce_time,
                    area = track.area,
                    track_type = track.type
                };
                StockSumList.Add(sum);
                SortSumList();
            }
            if (goodsid > 0)
            {
                Goods goods = GoodsList.Find(c => c.id == goodsid);
                if (goods != null)
                {
                    sum.count = (uint)StockList.Count(c => c.track_id == trackId);
                    sum.stack = sum.count * goods.stack;
                    sum.pieces = sum.stack * goods.pieces;
                    SendSumMsg(sum, ActionTypeE.Update);
                }
            }
        }
        #endregion

        #region[排序]
        private void SortSumList()
        {
            StockSumList.Sort((x, y) =>
            {
                if(x.area == y.area)
                {
                    if(x.goods_id == y.goods_id)
                    {
                        return x.CompareProduceTime(y.produce_time);
                    }
                    else
                    {
                        return x.goods_id.CompareTo(y.goods_id);
                    }
                }
                return x.area.CompareTo(y.area);
            });
        }
        #endregion

        #endregion

        #region[任务逻辑]

        #region[分配轨道]

        /// <summary>
        /// 分配储砖轨道：根据区域/下砖设备/品种
        /// </summary>
        /// <param name="areaid">下砖区域</param>
        /// <param name="devid">分配设备</param>
        /// <param name="goodsid">品种</param>
        /// <param name="givetrackid">分配轨道</param>
        /// <returns></returns>
        public bool AllocateGiveTrack(uint areaid, uint devid, uint goodsid, out List<uint> traids)
        {
            List<AreaDeviceTrack> list = PubMaster.Area.GetAreaDevTraList(areaid, devid);
            traids = new List<uint>();

            ////1.查看是否有最近下砖规格轨道
            //List<Track> recentusetracks = PubMaster.Track.GetRecentGoodTracks(list, goodsid);
            //foreach (Track track in recentusetracks)
            //{
            //    if(track.StockStatus == TrackStockStatusE.满砖
            //        || track.TrackStatus == TrackStatusE.倒库中
            //        || track.TrackStatus == TrackStatusE.停用)
            //    {
            //        PubMaster.Track.UpdateRecentTile(track.id, 0);
            //        PubMaster.Track.UpdateRecentGood(track.id, 0);
            //        continue;
            //    }

            //    if (PubMaster.Goods.HaveStockInTrack(track.id, goodsid, out uint stockid))
            //    {
            //        traids.Add(track.id);
            //    }
            //    else
            //    {
            //        PubMaster.Track.UpdateRecentGood(track.id, 0);
            //    }
            //}

            List<uint> emptylist = new List<uint>();
            List<TrackStoreCount> trackstores = new List<TrackStoreCount>();
            uint storecount = 0;
            foreach (AreaDeviceTrack adt in list)
            {
                //是否是储砖轨道
                if (!PubMaster.Track.IsStoreGiveTrack(adt.track_id)) continue;

                //轨道是否启用
                if (!PubMaster.Track.IsTrackEnable(adt.track_id)) continue;

                //轨道满否
                if (PubMaster.Track.IsTrackFull(adt.track_id)) continue;

                //[可以放任何品种] 空轨道，轨道没有库存
                if (PubMaster.Track.IsEmtpy(adt.track_id)
                    && IsTrackStockEmpty(adt.track_id)
                    && IsTrackOkForGoods(adt.track_id, goodsid))
                {
                    emptylist.Add(adt.track_id);
                }

                //是否已存同品种并且未满
                if (IsTrackFineToStore(adt.track_id, goodsid,out storecount))
                {
                    //traids.Add(adt.track_id);
                    trackstores.Add(new TrackStoreCount()
                    {
                        trackid = adt.track_id,
                        storecount = storecount
                    });
                }
            }

            if (trackstores.Count > 0)
            {
                trackstores.Sort((x, y) => y.storecount.CompareTo(x.storecount));
                foreach (TrackStoreCount item in trackstores)
                {
                    traids.Add(item.trackid);
                }
            }

            traids.AddRange(emptylist);
            return traids.Count > 0;
        }

        /// <summary>
        /// 判断轨道
        /// 1.已存同品种
        /// 2.轨道为到达满砖数量
        /// </summary>
        /// <param name="trackid"></param>
        /// <param name="goodsid"></param>
        /// <returns></returns>
        private bool IsTrackFineToStore(uint trackid, uint goodsid, out uint storecount)
        {
            bool isok = StockList.Exists(c => c.track_id == trackid && c.goods_id == goodsid);
            if (isok)
            {
                int maxstore = PubMaster.Track.GetTrackMaxStore(trackid);
                storecount = StockSumList.Find(c => c.track_id == trackid)?.count ?? 0;
                if (storecount < maxstore)
                {
                    return true;
                }
            }
            storecount = 0;
            return false;
        }

        #endregion

        #region[轨道能否放该规格砖]

        public bool IsTrackOkForGoods(uint trackid, uint goodsid)
        {
            Goods goods = GoodsList.Find(c => c.id == goodsid);
            if (goods == null) return false;

            Track track = PubMaster.Track.GetTrack(trackid);
            if (track == null) return false;

            bool isleftok = true, isrightok = true;

            #region[判断轨道能不能放砖]

            if (track.left_track_id == 0)
            {
                if (CheckTrackAndGood(track.width, goods.width, track.left_distance))
                {
                    return false;
                }
            }

            if (track.right_track_id == 0)
            {
                if (CheckTrackAndGood(track.width, goods.width, track.right_distance))
                {
                    return false;
                }
            }

            #endregion

            #region[判断隔壁轨道是否碰撞]

            Track ltrack = PubMaster.Track.GetTrack(track.left_track_id);
            Track rtrack = PubMaster.Track.GetTrack(track.right_track_id);

            if(ltrack != null)
            {
                //判断左兄弟轨道
                Goods leftgoods = GetTrackGoods(ltrack.id);
                if(leftgoods == null && ltrack.StockStatus == TrackStockStatusE.有砖)
                {
                    leftgoods = PubMaster.Goods.GetGoods(ltrack.recent_goodid);
                }
                if(leftgoods != null)
                {
                    isleftok = IsGoodsDistanceOk(ltrack, leftgoods, track, goods);
                }
            }

            if(rtrack != null)
            {
                Goods rightgoods = GetTrackGoods(rtrack.id);
                if (rightgoods == null && rtrack.StockStatus == TrackStockStatusE.有砖)
                {
                    rightgoods = PubMaster.Goods.GetGoods(rtrack.recent_goodid);
                }
                if (rightgoods != null)
                {
                    isrightok = IsGoodsDistanceOk(track, goods, rtrack, rightgoods);
                }
            }
            #endregion

            return isleftok && isrightok;
        }

        private bool CheckTrackAndGood(ushort trackwidth, ushort goodwidth, ushort trackdistance)
        {
            //(trackdistance - (goodwidth - trackwidth) / 2)
            return trackdistance-((goodwidth - trackwidth)/2) < 100;
        }

        public byte GetGoodsPieces(uint goodid)
        {
            return (byte)(GoodsList.Find(c => c.id == goodid)?.pieces ?? 0);
        }

        /// <summary>
        /// 获取轨道库存最大规格
        /// </summary>
        /// <param name="trackid"></param>
        /// <returns></returns>
        private Goods GetTrackGoods(uint trackid)
        {
            uint goodsid = StockList.Find(c => c.track_id == trackid)?.goods_id ?? 0;
            if(goodsid != 0)
            {
                //是否存在不同规格的库存在同一个轨道
                if(StockList.Exists(c=>c.track_id == trackid && c.goods_id != goodsid))
                {
                    var goodsids = StockList.FindAll(c => c.track_id == trackid)
                        .GroupBy(x =>new { x.goods_id })
                        .Select(t=>t.Key.goods_id);
                    foreach (var goodid in goodsids)
                    {
                        if(CampareGoodWidth(goodsid, goodid))
                        {
                            goodsid = goodid;
                        }
                    }
                }
                return GoodsList.Find(c => c.id == goodsid);
            }
            return null;
        }

        private bool CampareGoodWidth(uint one, uint two)
        {
            Goods goodonw = GoodsList.Find(c => c.id == one);
            Goods goodtwo = GoodsList.Find(c => c.id == two);
            if(goodonw !=null && goodtwo != null)
            {
                return goodonw.width < goodtwo.width;
            }
            return false;
        }

        /// <summary>
        /// 判断轨道
        /// </summary>
        /// <param name="track"></param>
        /// <param name="putgood"></param>
        /// <param name="havegood"></param>
        /// <returns></returns>
        public bool IsGoodsDistanceOk(Track lefttrack, Goods leftgoods, Track righttrack, Goods rightgoods)
        {
            int ld = Math.Abs(leftgoods.width - lefttrack.width) / 2;
            int rd = Math.Abs(rightgoods.width - righttrack.width) / 2;

            if(lefttrack.right_distance == righttrack.left_distance)
            {
                return (righttrack.left_distance - ld - rd) >= 150;
            }
            int distance = lefttrack.right_distance < righttrack.left_distance ? lefttrack.right_distance : righttrack.left_distance;
            return (distance - ld - rd) >= 150;
        }

        public uint GetTrackStockId(uint trackid)
        {
            return StockList.Find(c => c.track_id == trackid)?.id ?? 0;
        }

        #endregion

        #endregion

        #region[发送信息]

        private void SendMsg(Goods goods, ActionTypeE type)
        {
            MsgAction msg = new MsgAction()
            {
                o1 = goods,
                o2 = type
            };

            Messenger.Default.Send(msg, MsgToken.GoodsUpdate);
        }

        /// <summary>
        /// 空砖信号后，情况轨道库存
        /// </summary>
        /// <param name="take_track_id"></param>
        public void ClearTrackEmtpy(uint take_track_id)
        {
            List<Stock> stocks = StockList.FindAll(c => c.track_id == take_track_id);
            if (stocks.Count > 0)
            {
                PubMaster.Mod.GoodSql.DeleteStock(take_track_id);
                StockList.RemoveAll(c => c.track_id == take_track_id);
                RemoveTrackSum(take_track_id);
            }
        }

        public uint GetGoodsId(uint id)
        {
            return StockList.Find(c => c.track_id == id)?.goods_id ?? 0;
        }

        public bool IsGoodsOverSize(uint goods_id)
        {
            return GoodsList.Find(c => c.id == goods_id)?.oversize ?? true;
        }

        #endregion
    }
}
