﻿using enums;
using enums.track;
using enums.warning;
using GalaSoft.MvvmLight.Messaging;
using module.device;
using module.goods;
using module.msg;
using module.tiletrack;
using module.track;
using resource;
using System;
using System.Collections.Generic;
using System.Threading;
using task.task;
using tool.appconfig;
using tool.mlog;
using tool.timer;

namespace task.device
{
    public class TileLifterMaster
    {
        #region[字段]
        private MsgAction mMsg;
        private object _objmsg;
        private List<TileLifterTask> DevList { set; get; }
        private readonly object _obj;
        private const byte Site_1 = 1, Site_2 = 2;
        private Thread _mRefresh;
        private bool Refreshing = true;
        private MTimer mTimer;
        private Log mlog;
        #endregion

        #region[属性]

        #endregion

        #region[构造/启动/停止/重连]

        public TileLifterMaster()
        {
            mlog = (Log)new LogFactory().GetLog("TileLifter", false);
            mTimer = new MTimer();
            _objmsg = new object();
            mMsg = new MsgAction();
            _obj = new object();
            DevList = new List<TileLifterTask>();
            Messenger.Default.Register<SocketMsgMod>(this, MsgToken.TileLifterMsgUpdate, TileLifterMsgUpdate);
        }

        public void Start()
        {
            List<Device> tilelifters = PubMaster.Device.GetTileLifters();
            foreach (Device dev in tilelifters)
            {
                TileLifterTask task = new TileLifterTask();
                task.Device = dev;
                task.Config_Light = GlobalWcsDataConfig.AlertLightConfig.GetDevLight(dev.id);

                //task.AreaId = PubMaster.Area.GetAreaId(dev.id);
                task.Start();
                DevList.Add(task);
            }

            if (_mRefresh == null || !_mRefresh.IsAlive || _mRefresh.ThreadState == ThreadState.Aborted)
            {
                _mRefresh = new Thread(Refresh)
                {
                    IsBackground = true
                };
            }

            _mRefresh.Start();

        }

        public void GetAllTileLifter()
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                return;
            }
            try
            {
                foreach (TileLifterTask task in DevList)
                {
                    MsgSend(task, task.DevStatus);
                }
            }
            finally { Monitor.Exit(_obj); }
        }

        public void Stop()
        {
            Refreshing = false;
            _mRefresh?.Abort();

            foreach (TileLifterTask task in DevList)
            {
                task.Stop();
            }
        }

        public void ReStart()
        {

        }
        /// <summary>
        /// 只要发送了内容，就会有反馈则不再发送查询内容
        /// </summary>
        private bool refreshsend = false;
        private void Refresh()
        {
            while (Refreshing)
            {
                if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(1)))
                {
                    try
                    {
                        foreach (TileLifterTask task in DevList)
                        {
                            try
                            {
                                refreshsend = false;

                                if (task.Type != DeviceTypeE.下砖机) continue;
                                if (task.DevStatus.Goods1 == 0 || task.DevStatus.Goods2 == 0) continue;

                                int count = PubMaster.Dic.GetDtlIntCode("TileLifterShiftCount");
                                switch (task.DevStatus.ShiftStatus)
                                {
                                    case TileShiftStatusE.复位:
                                        #region [复位]
                                        if (task.Device.do_shift)
                                        {
                                            task.DoShift(TileShiftStatusE.转产中, count);
                                            refreshsend = true;
                                            break;
                                        }

                                        if (!task.Device.do_shift)
                                        {
                                            if (task.DevStatus.ShiftAccept)
                                            {
                                                task.DoShift(TileShiftStatusE.复位);
                                                refreshsend = true;
                                            }

                                            if (task.Device.LeftGoods != task.DevStatus.Goods1 ||
                                                task.Device.RightGoods != task.DevStatus.Goods2)
                                            {
                                                PubMaster.Device.SetTileLifterGoods(task.ID, task.DevStatus.Goods1, task.DevStatus.Goods2);
                                            }
                                            break;
                                        }
                                        #endregion
                                        break;
                                    case TileShiftStatusE.转产中:
                                        #region [转产中]
                                        if (task.Device.do_shift)
                                        {
                                            if (!task.DevStatus.ShiftAccept)
                                            {
                                                task.DoShift(TileShiftStatusE.转产中, count);
                                                refreshsend = true;
                                                break;
                                            }
                                        }

                                        if (!task.Device.do_shift)
                                        {
                                            if (task.DevStatus.ShiftAccept)
                                            {
                                                task.DoShift(TileShiftStatusE.复位);
                                                refreshsend = true;
                                                break;
                                            }
                                        }
                                        #endregion
                                        break;
                                    case TileShiftStatusE.完成:
                                        #region [完成]
                                        if (task.Device.do_shift && task.DevStatus.ShiftAccept &&
                                            task.Device.LeftGoods != task.DevStatus.Goods1 &&
                                            task.Device.RightGoods != task.DevStatus.Goods2 &&
                                            task.DevStatus.Goods1 == task.DevStatus.Goods2)
                                        {
                                            task.DoShift(TileShiftStatusE.复位);
                                            refreshsend = true;

                                            task.Device.do_shift = false;
                                            PubMaster.Device.SetTileLifterGoods(task.ID, task.DevStatus.Goods1, task.DevStatus.Goods2);
                                            break;
                                        }
                                        #endregion
                                        break;
                                    default:
                                        break;
                                }


                                #region[报警灯逻辑]

                                if (task.Config_Light != null && task.Config_Light.HaveLight)
                                {
                                    bool havewarn = false;
                                    //自管砖机本身的报警信息
                                    if (task.Config_Light.OnlyMyself)
                                    {
                                        havewarn = PubMaster.Warn.HaveDevWarn(task.ID, task.Config_Light.WarnLevel);
                                    }
                                    //自管区域的报警信息
                                    else if (task.Config_Light.OnlyArea)
                                    {
                                        havewarn = PubMaster.Warn.HaveAreaWarn(task.AreaId, task.Config_Light.WarnLevel);
                                    }
                                    //自管区域线路的报警信息
                                    //else if (task.Config_Light.OnlyLine)
                                    //{
                                    //    havewarn = PubMaster.Warn.HaveAreaLineWarn(task.AreaId, task.Line, task.Config_Light.WarnLevel);
                                    //}

                                    ///有报警，灯关 则 开灯
                                    if (havewarn)
                                    {
                                        if (task.LightOff)
                                        {
                                            task.DoLight(TileLightShiftE.灯开);
                                            refreshsend = true;
                                        }
                                    }
                                    //无报警，灯开 则 关灯
                                    else
                                    {
                                        if (task.LightOn)
                                        {
                                            task.DoLight(TileLightShiftE.灯关);
                                            refreshsend = true;
                                        }
                                    }
                                }

                                #endregion
                            }catch(Exception e)
                            {

                            }
                            finally
                            {
                                if (task.IsEnable && !refreshsend)
                                {
                                    task.DoQuery();
                                }
                            }
                        }
                    }
                    finally { Monitor.Exit(_obj); }
                }
                Thread.Sleep(1000);
            }
        }

        public void DoInv(uint devid,bool isone, DevLifterInvolE type)
        {
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(1)))
            {
                try
                {
                    if (isone)
                    {
                        DevList.Find(c => c.ID == devid)?.Do1Invo(type);
                    }
                    else
                    {
                        DevList.Find(c => c.ID == devid)?.Do2Invo(type);
                    }
                }
                finally { Monitor.Exit(_obj); }
            }
        }

        /// <summary>
        /// 发送给砖机离开工位
        /// 1.如果兄弟砖机需要，则不离开
        /// 2.如果兄弟砖机离开，则全部离开
        /// </summary>
        /// <param name="tilelifter_id"></param>
        /// <param name="leavetrackid"></param>
        /// <returns></returns>
        internal bool DoInvLeave(uint tilelifter_id, uint leavetrackid)
        {
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(1)))
            {
                try
                {
                    TileLifterTask task = DevList.Find(c => c.ID == tilelifter_id);
                    if (task != null)
                    {
                        TileLifterTask bro;
                        //离开砖机并且同时离开兄弟砖机
                        if (task.HaveBrother)
                        {
                            bro = DevList.Find(c => c.ID == task.BrotherId);
                        }
                        else
                        {
                            bro = DevList.Find(c => c.BrotherId == task.ID);
                        }

                        if (task.LeftTrackId == leavetrackid)
                        {
                            if (task.HaveBrother)
                            {
                                if (task.IsInvo_1)
                                {
                                    task.Do1Invo(DevLifterInvolE.离开);
                                }

                                if (bro.IsInvo_1)
                                {
                                    bro.Do1Invo(DevLifterInvolE.离开);
                                }

                                if (!task.IsInvo_1 && !bro.IsInvo_1)
                                {
                                    return true;
                                }
                            }
                            else
                            {
                                if (bro != null && bro.IsNeed_1)
                                {
                                    return true;
                                }

                                if (task.IsInvo_1)
                                {
                                    task.Do1Invo(DevLifterInvolE.离开);
                                }
                                else
                                {
                                    return true;
                                }
                            }
                        }


                        if(task.RigthTrackId == leavetrackid)
                        {
                            if (task.HaveBrother)
                            {
                                if (task.IsInvo_2)
                                {
                                    task.Do2Invo(DevLifterInvolE.离开);
                                }

                                if (bro.IsInvo_2)
                                {
                                    bro.Do2Invo(DevLifterInvolE.离开);
                                }

                                if (!task.IsInvo_2 && !bro.IsInvo_2)
                                {
                                    return true;
                                }
                            }
                            else
                            {
                                if (bro != null && bro.IsNeed_2)
                                {
                                    return true;
                                }

                                if (task.IsInvo_2)
                                {
                                    task.Do2Invo(DevLifterInvolE.离开);
                                }
                                else
                                {
                                    return true;
                                }
                            }
                        }
                    }
                }
                finally { Monitor.Exit(_obj); }
            }
            return false;
        }

        internal bool IsTrackEmtpy(uint tileid, uint trackid)
        {
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    TileLifterTask task = DevList.Find(c => c.ID == tileid);
                    if (task != null)
                    {
                        if(task.LeftTrackId == trackid && task.IsEmpty_1)
                        {
                            return true;
                        }

                        if(task.RigthTrackId == trackid && task.IsEmpty_2)
                        {
                            return true;
                        }
                    }
                }
                finally { Monitor.Exit(_obj); }
            }
            return false;
        }

        public void StartStopTileLifter(uint tileid, bool isstart)
        {
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    TileLifterTask task = DevList.Find(c => c.ID == tileid);
                    if (task != null)
                    {
                        if (isstart)
                        {
                            if (!task.IsEnable)
                            {
                                task.SetEnable(isstart);
                            }
                            task.Start();
                        }
                        else
                        {
                            if (task.IsEnable)
                            {
                                task.SetEnable(isstart);
                            }
                            task.Stop();
                            PubMaster.Warn.RemoveDevWarn((ushort)task.ID);
                        }
                    }
                }
                finally { Monitor.Exit(_obj); }
            }

        }

        //public void DoSetMode(uint tilelifter_id)
        //{
        //    if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(1)))
        //    {
        //        try
        //        {
        //            DevList.Find(c => c.ID == tilelifter_id)?.Do(type);
        //        }
        //        finally { Monitor.Exit(_obj); }
        //    }
        //}

        public void UpdateTileInStrategry(uint id, StrategyInE instrategy)
        {
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(1)))
            {
                try
                {
                    TileLifterTask task =  DevList.Find(c => c.ID == id);
                    if (task != null)
                    {
                        task.InStrategy = instrategy;
                        MsgSend(task, task.DevStatus);
                    }
                }
                finally { Monitor.Exit(_obj); }
            }
        }

        public void UpdateTileOutStrategry(uint id, StrategyOutE outstrategy, DevWorkTypeE worktype)
        {
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(1)))
            {
                try
                {
                    TileLifterTask task =  DevList.Find(c => c.ID == id);
                    if (task != null)
                    {
                        task.OutStrategy = outstrategy;
                        task.WorkType = worktype;
                        MsgSend(task, task.DevStatus);
                    }
                }
                finally { Monitor.Exit(_obj); }
            }
        }
        
        #endregion

        #region[获取信息]

        #endregion

        #region[数据更新]

        private void TileLifterMsgUpdate(SocketMsgMod mod)
        {
            if (mod != null)
            {
                if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
                {
                    try
                    {
                        TileLifterTask task = DevList.Find(c => c.ID == mod.ID);
                        if (task != null)
                        {
                            task.ConnStatus = mod.ConnStatus;
                            if (mod.Device is DevTileLifter tilelifter)
                            {
                                task.DevStatus = tilelifter;
                                CheckDev(task); 
                                
                                if(tilelifter.IsUpdate 
                                    || mTimer.IsTimeOutAndReset(TimerTag.DevRefreshTimeOut, tilelifter.ID, 10)) 
                                    MsgSend(task, tilelifter);
                            }
                            CheckConn(task);
                        }
                    }
                    catch(Exception e)
                    {
                        mlog.Error(true, e.Message, e);
                    }
                    finally
                    {
                        Monitor.Exit(_obj);
                    }
                }
            }
        }

        private void CheckConn(TileLifterTask task)
        {
            switch (task.ConnStatus)
            {
                case SocketConnectStatusE.连接成功:
                case SocketConnectStatusE.通信正常:
                    PubMaster.Warn.RemoveDevWarn(WarningTypeE.DeviceOffline, (ushort)task.ID);
                    break;
                case SocketConnectStatusE.连接中:
                case SocketConnectStatusE.连接断开:
                case SocketConnectStatusE.主动断开:
                    if(task.IsEnable) PubMaster.Warn.AddDevWarn(WarningTypeE.DeviceOffline, (ushort)task.ID);
                    break;
            }

            if (task.MConChange)
            {
                MsgSend(task, task.DevStatus);
            }
        }

        #endregion

        #region[检查状态/生成交易]

        /// <summary>
        /// 检查上下砖机状态
        /// 1.需求信号
        /// 2.满砖/空砖信号
        /// 3.持续5秒有信号-生成交易
        /// </summary>
        /// <param name="task"></param>
        private void CheckDev(TileLifterTask task)
        {
            task.SetInTaskStatus(task.IsNeed_1 || task.IsNeed_2);

            if (!task.IsWorking) return;

            //if (task.DevStatus != null && task.DevStatus.OperateMode == DevOperateModeE.手动模式) return;

            #region[检查基础信息]

            if (task.GoodsId == 0)
            {
                return;
            }

            if (task.LeftTrackId == 0)
            {
                return;
            }

            if (PubTask.Trans.HaveInTileTrack(task.LeftTrackId) ||
                PubTask.Trans.HaveInTileTrack(task.RigthTrackId))
            {
                return;
            }

            // 写死算了，真的麻烦
            if (task.Type == DeviceTypeE.下砖机 && PubTask.Trans.IsLifterOnly(task.ID))
            {
                return;
            }

            #endregion

            #region[工位1有需求]
            if (task.IsNeed_1)
            {
                #region[下砖机-满砖]

                if (task.Type == DeviceTypeE.下砖机)
                {
                    if (task.IsEmpty_1 && task.IsInvo_1)
                    {
                        Thread.Sleep(1000);
                        task.Do1Invo(DevLifterInvolE.离开);
                    }

                    if (task.IsLoad_1 && PubMaster.Dic.IsAreaTaskOnoff(task.AreaId, DicAreaTaskE.下砖))
                    {
                        #region[介入]
                        if (!task.IsInvo_1)
                        {
                            Thread.Sleep(1000);
                            task.Do1Invo(DevLifterInvolE.介入);
                            return;
                        }
                        #endregion

                        if (CheckBrotherIsReady(task, false, true))
                        {
                            #region[生成入库交易]

                            uint gid = task.GoodsId;
                            if (task.Device.do_shift)
                            {
                                if (!task.DevStatus.ShiftAccept || task.DevStatus.ShiftStatus == TileShiftStatusE.复位)
                                {
                                    return;
                                }

                                if (task.Device.LeftGoods == task.DevStatus.Goods1)
                                {
                                    if (task.Device.old_goodid != 0) gid = task.Device.old_goodid;
                                }
                            }

                            bool iseffect = CheckInStrategy(task, gid, task.GoodsId, task.Device.old_goodid);

                            if (!iseffect // && mTimer.IsOver(TimerTag.DownTileLifterHaveGoods, task.ID, Site_1, 3)
                                )
                            {
                                switch (task.WorkType)
                                {
                                    case DevWorkTypeE.规格作业:
                                        TileAddInTransTask(task.AreaId, task.ID, task.LeftTrackId, gid, task.FullQty);
                                        break;
                                    case DevWorkTypeE.轨道作业:

                                        break;
                                }

                                #region[旧-逻辑]
                                ////[已有库存]
                                //if (!PubMaster.Goods.HaveStockInTrack(task.LeftTrackId, task.GoodsId, out uint stockid))
                                //{
                                //    ////[生成库存]
                                //    stockid = PubMaster.Goods.AddStock(task.ID, task.LeftTrackId, task.GoodsId, task.FullQty);
                                //    if (stockid > 0)
                                //    {
                                //        PubMaster.Track.UpdateStockStatus(task.LeftTrackId, TrackStockStatusE.有砖, "下砖");
                                //        PubMaster.Goods.AddStockInLog(stockid);
                                //    }
                                //}

                                ////分配放货点
                                //if (stockid != 0 && PubMaster.Goods.AllocateGiveTrack(task.AreaId, task.ID, task.GoodsId, out List<uint> traids))
                                //{
                                //    uint givetrackid = 0;
                                //    foreach (uint traid in traids)
                                //    {
                                //        if (!PubTask.Trans.IsTraInTransWithLock(traid))
                                //        {
                                //            givetrackid = traid;
                                //            break;
                                //        }
                                //    }

                                //    if (givetrackid != 0)
                                //    {
                                //        PubMaster.Track.UpdateRecentGood(givetrackid, task.GoodsId);
                                //        PubMaster.Track.UpdateRecentTile(givetrackid, task.ID);
                                //        //生成入库交易
                                //        PubTask.Trans.AddTrans(task.AreaId, task.ID, TransTypeE.入库, task.GoodsId, stockid, task.LeftTrackId, givetrackid);
                                //    }

                                //    PubMaster.Warn.RemoveDevWarn(WarningTypeE.DownTileHaveNotTrackToStore, (ushort)task.ID);
                                //}
                                //else if(stockid != 0)
                                //{
                                //    PubMaster.Warn.AddDevWarn(WarningTypeE.DownTileHaveNotTrackToStore, (ushort)task.ID);
                                //}
                                #endregion

                            }

                            #endregion
                        }
                    }
                }

                #endregion

                #region[上砖机-空砖]
                else if (task.Type == DeviceTypeE.上砖机 && task.IsEmpty_1)
                {
                    if (!PubMaster.Dic.IsAreaTaskOnoff(task.AreaId, DicAreaTaskE.上砖)) return;
                    
                    #region[介入]
                    if (!task.IsInvo_1)
                    {
                        Thread.Sleep(1000);
                        task.Do1Invo(DevLifterInvolE.介入);
                        return;
                    }
                    #endregion

                    #region[生成出库交易]

                    bool iseffect = CheckOutStrategy(task);

                    if (!iseffect 
                        //&& mTimer.IsOver(TimerTag.UpTileLifterEmpty, task.ID, Site_1, 5)
                        )
                    {
                        #region[清空轨道上砖轨道库存]
                        PubMaster.Goods.ClearTrackEmtpy(task.LeftTrackId);
                        #endregion

                        switch (task.WorkType)
                        {
                            case DevWorkTypeE.规格作业:
                                TileAddOutTransTask(task.AreaId, task.ID, task.LeftTrackId, task.GoodsId);
                                break;
                            case DevWorkTypeE.轨道作业:
                                TileAddTrackOutTransTask(task.AreaId, task.ID, task.LeftTrackId, task.GoodsId);
                                break;
                        }

                        #region[旧-逻辑]
                        //bool isallocate = false;
                        ////1.查看是否有需要重新派发取货的空轨道
                        //if (PubMaster.Track.HaveTrackInGoodButNotStock(task.AreaId, task.ID, task.GoodsId, out List<uint> trackids))
                        //{
                        //    foreach (uint trackid in trackids)
                        //    {
                        //        if (!PubTask.Trans.HaveInTileTrack(trackid))
                        //        {
                        //            uint stockid = PubMaster.Goods.GetTrackTopStockId(trackid);

                        //            //有库存但是不是砖机需要的品种
                        //            if (stockid != 0 && !PubMaster.Goods.IsStockWithGood(stockid, task.GoodsId))
                        //            {
                        //                PubMaster.Track.UpdateRecentTile(trackid, 0);
                        //                PubMaster.Track.UpdateRecentGood(trackid, 0);
                        //                return;
                        //            }

                        //            //生成出库交易
                        //            PubTask.Trans.AddTrans(task.AreaId, task.ID, TransTypeE.出库, task.GoodsId, stockid, trackid, task.LeftTrackId);
                        //            PubMaster.Goods.AddStockOutLog(stockid, task.LeftTrackId, task.ID);
                        //            PubMaster.Warn.RemoveDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)task.ID);
                        //            isallocate = true;
                        //            break;
                        //        }
                        //    }
                        //}

                        ////分配库存
                        //if (!isallocate && PubMaster.Goods.GetStock(task.AreaId, task.ID, task.GoodsId, out List<Stock> allocatestocks))
                        //{
                        //    foreach (Stock stock in allocatestocks)
                        //    {
                        //        if (!PubTask.Trans.IsStockInTrans(stock.id, stock.track_id))
                        //        {
                        //            PubMaster.Track.UpdateRecentGood(stock.track_id, task.GoodsId);
                        //            PubMaster.Track.UpdateRecentTile(stock.track_id, task.ID);
                        //            //生成出库交易
                        //            PubTask.Trans.AddTrans(task.AreaId, task.ID, TransTypeE.出库, task.GoodsId, stock.id, stock.track_id, task.LeftTrackId);

                        //            PubMaster.Goods.AddStockOutLog(stock.id, task.LeftTrackId, task.ID);
                        //            break;
                        //        }
                        //    }
                        //    PubMaster.Warn.RemoveDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)task.ID);
                        //}
                        //else if(!isallocate)
                        //{
                        //    PubMaster.Warn.AddDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)task.ID);
                        //}
                        #endregion
                    }
                    #endregion
                }
                #endregion
            }
            else
            {
                bool isOK = false;
                switch (task.Type)
                {
                    case DeviceTypeE.上砖机:
                        isOK = !PubTask.Carrier.HaveInTrackAndLoad(task.LeftTrackId);
                        break;
                    case DeviceTypeE.下砖机:
                        isOK = !PubTask.Carrier.HaveInTrack(task.LeftTrackId);
                        break;
                    default:
                        break;
                }
                //没有需求但是介入状态 同时:轨道没有车/有车无货
                if (task.IsInvo_1 && isOK
                    && mTimer.IsOver(TimerTag.TileInvoNotNeed, task.ID, Site_1, 15, 10))
                {
                    if (task.HaveBrother)
                    {
                        Thread.Sleep(1000);
                        task.Do1Invo(DevLifterInvolE.离开);
                    }
                    else
                    {
                        TileLifterTask bro = DevList.Find(c => c.BrotherId == task.ID);
                        if (bro == null || (bro != null && !bro.IsNeed_1))
                        {
                            Thread.Sleep(1000);
                            task.Do1Invo(DevLifterInvolE.离开);
                        }
                    }
                }
            }
            #endregion

            #region[工位2有需求]
            if (task.IsNeed_2 && task.IsTwoTrack)
            {
                if (task.RigthTrackId == 0) return;

                #region[下砖机-满砖]
                if (task.Type == DeviceTypeE.下砖机)
                {
                    if (task.IsEmpty_2)
                    {
                        if (task.IsInvo_2)
                        {
                            Thread.Sleep(1000);
                            task.Do2Invo(DevLifterInvolE.离开);
                        }
                        return;
                    }

                    if (!PubMaster.Dic.IsAreaTaskOnoff(task.AreaId, DicAreaTaskE.下砖)) return;

                    #region[介入]
                    if (!task.IsInvo_2)
                    {
                        Thread.Sleep(1000);
                        task.Do2Invo(DevLifterInvolE.介入);
                        return;
                    }
                    #endregion

                    if (!CheckBrotherIsReady(task, false, false))
                    {
                        return;
                    }

                    #region[生成入库交易]

                    uint gid = task.GoodsId;
                    if (task.Device.do_shift)
                    {
                        if (!task.DevStatus.ShiftAccept || task.DevStatus.ShiftStatus == TileShiftStatusE.复位)
                        {
                            return;
                        }

                        if (task.Device.RightGoods == task.DevStatus.Goods2)
                        {
                            if (task.Device.old_goodid != 0) gid = task.Device.old_goodid;
                        }
                    }

                    bool iseffect = CheckInStrategy(task, gid, task.GoodsId, task.Device.old_goodid);

                    if (!iseffect 
                        //&& mTimer.IsOver(TimerTag.DownTileLifterHaveGoods, task.ID, Site_2, 3)
                        )
                    {
                        switch (task.WorkType)
                        {
                            case DevWorkTypeE.规格作业:
                                TileAddInTransTask(task.AreaId, task.ID, task.RigthTrackId, gid, task.FullQty);
                                break;
                            case DevWorkTypeE.轨道作业:

                                break;
                        }

                        #region[旧-逻辑]
                        ////[已有库存]
                        //if (!PubMaster.Goods.HaveStockInTrack(task.RigthTrackId, task.GoodsId, out uint stockid))
                        //{
                        //    ////[生成库存]
                        //    stockid = PubMaster.Goods.AddStock(task.ID, task.RigthTrackId, task.GoodsId, task.FullQty);
                        //    if (stockid > 0)
                        //    {
                        //        PubMaster.Track.UpdateStockStatus(task.RigthTrackId, TrackStockStatusE.有砖, "下砖");
                        //        PubMaster.Goods.AddStockInLog(stockid);
                        //    }
                        //}

                        ////分配放货点
                        //if (stockid != 0 && PubMaster.Goods.AllocateGiveTrack(task.AreaId, task.ID, task.GoodsId, out List<uint> traids))
                        //{
                        //    uint givetrackid = 0;
                        //    foreach (uint traid in traids)
                        //    {
                        //        if (!PubTask.Trans.IsTraInTransWithLock(traid))
                        //        {
                        //            givetrackid = traid;
                        //            break;
                        //        }
                        //    }
                        //    if (givetrackid != 0)
                        //    {
                        //        PubMaster.Track.UpdateRecentGood(givetrackid, task.GoodsId);
                        //        PubMaster.Track.UpdateRecentTile(givetrackid, task.ID);
                        //        //生成入库交易
                        //        PubTask.Trans.AddTrans(task.AreaId, task.ID, TransTypeE.入库, task.GoodsId, stockid, task.RigthTrackId, givetrackid);
                        //    }

                        //    PubMaster.Warn.RemoveDevWarn(WarningTypeE.DownTileHaveNotTrackToStore, (ushort)task.ID);
                        //}
                        //else if(stockid != 0)
                        //{
                        //    PubMaster.Warn.AddDevWarn(WarningTypeE.DownTileHaveNotTrackToStore, (ushort)task.ID);
                        //}
                        #endregion
                    }
                    #endregion
                }
                #endregion

                #region[上砖机-空砖]
                else if (task.Type == DeviceTypeE.上砖机 && task.IsEmpty_2)
                {
                    if (!PubMaster.Dic.IsAreaTaskOnoff(task.AreaId, DicAreaTaskE.上砖)) return;
                    #region[介入]
                    if (!task.IsInvo_2)
                    {
                        Thread.Sleep(1000);
                        task.Do2Invo(DevLifterInvolE.介入);
                        return;
                    }
                    #endregion

                    #region[生成出库交易]

                    bool iseffect = CheckOutStrategy(task);

                    if (!iseffect 
                        //&& mTimer.IsOver(TimerTag.UpTileLifterEmpty, task.ID, Site_2, 3)
                        )
                    {
                        #region[清空轨道上砖轨道库存]
                        PubMaster.Goods.ClearTrackEmtpy(task.RigthTrackId);
                        #endregion

                        switch (task.WorkType)
                        {
                            case DevWorkTypeE.规格作业:
                                TileAddOutTransTask(task.AreaId, task.ID, task.RigthTrackId, task.GoodsId);
                                break;
                            case DevWorkTypeE.轨道作业:
                                TileAddTrackOutTransTask(task.AreaId, task.ID, task.RigthTrackId, task.GoodsId);
                                break;
                        }

                        #region[旧-逻辑]

                        //bool isallocate = false;
                        ////1.查看是否有需要重新派发取货的空轨道
                        //if (PubMaster.Track.HaveTrackInGoodButNotStock(task.AreaId, task.ID, task.GoodsId, out List<uint> trackids))
                        //{
                        //    foreach (uint trackid in trackids)
                        //    {
                        //        if (!PubTask.Trans.HaveInTileTrack(trackid))
                        //        {
                        //            uint stockid = PubMaster.Goods.GetTrackTopStockId(trackid);
                        //            //有库存但是不是砖机需要的品种
                        //            if (stockid != 0 && !PubMaster.Goods.IsStockWithGood(stockid, task.GoodsId))
                        //            {
                        //                PubMaster.Track.UpdateRecentTile(trackid, 0);
                        //                PubMaster.Track.UpdateRecentGood(trackid, 0);
                        //                return;
                        //            }
                        //            //生成出库交易
                        //            PubTask.Trans.AddTrans(task.AreaId, task.ID, TransTypeE.出库, task.GoodsId, stockid, trackid, task.RigthTrackId);
                        //            PubMaster.Goods.AddStockOutLog(stockid, task.RigthTrackId, task.ID);
                        //            PubMaster.Warn.RemoveDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)task.ID);
                        //            isallocate = true;
                        //            break;
                        //        }
                        //    }
                        //}
                        ////分配库存
                        //if (!isallocate && PubMaster.Goods.GetStock(task.AreaId, task.ID, task.GoodsId, out List<Stock> allocatestocks))
                        //{
                        //    foreach (Stock stock in allocatestocks)
                        //    {
                        //        if (!PubTask.Trans.IsStockInTrans(stock.id, stock.track_id))
                        //        {
                        //            PubMaster.Track.UpdateRecentGood(stock.track_id, task.GoodsId);
                        //            PubMaster.Track.UpdateRecentTile(stock.track_id, task.ID);
                        //            //生成出库交易
                        //            PubTask.Trans.AddTrans(task.AreaId, task.ID, TransTypeE.出库, task.GoodsId, stock.id, stock.track_id, task.RigthTrackId);
                        //            PubMaster.Goods.AddStockOutLog(stock.id, task.RigthTrackId, task.ID);
                        //            break;
                        //        }
                        //    }
                        //    PubMaster.Warn.RemoveDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)task.ID);
                        //}
                        //else if (!isallocate)
                        //{
                        //    PubMaster.Warn.AddDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)task.ID);
                        //}

                        #endregion

                    }
                    #endregion
                }
                #endregion
            }
            else if (task.IsInvo_2)
            {
                bool isOK = false;
                if (task.RigthTrackId == 0)
                {
                    isOK = true;
                }
                else
                {
                    switch (task.Type)
                    {
                        case DeviceTypeE.上砖机:
                            isOK = !PubTask.Carrier.HaveInTrackAndLoad(task.RigthTrackId);
                            break;
                        case DeviceTypeE.下砖机:
                            isOK = !PubTask.Carrier.HaveInTrack(task.RigthTrackId);
                            break;
                        default:
                            break;
                    }
                }
                //没有需求但是介入状态 同时:轨道没有车/有车无货
                if (task.RigthTrackId == 0
                    || (isOK && mTimer.IsOver(TimerTag.TileInvoNotNeed, task.ID, Site_2, 15, 10)))
                {
                    if (task.HaveBrother)
                    {
                        Thread.Sleep(1000);
                        task.Do2Invo(DevLifterInvolE.离开);
                    }
                    else
                    {
                        TileLifterTask bro = DevList.Find(c => c.BrotherId == task.ID);
                        if (bro == null || (bro != null && !bro.IsNeed_2))
                        {
                            Thread.Sleep(1000);
                            task.Do2Invo(DevLifterInvolE.离开);
                        }
                    }
                }
            }
            #endregion
        }

        /// <summary>
        /// 添加入库任务
        /// </summary>
        /// <param name="areaid">区域ID</param>
        /// <param name="tileid">砖机ID</param>
        /// <param name="tiletrackid">砖机轨道ID</param>
        /// <param name="goodid">砖机规格</param>
        /// <param name="fullqty">砖机满砖数量</param>
        private void TileAddInTransTask(uint areaid, uint tileid, uint tiletrackid, uint goodid, byte fullqty)
        {
            //[已有库存]
            if (!PubMaster.Goods.HaveStockInTrack(tiletrackid, goodid, out uint stockid))
            {
                ////[生成库存]
                stockid = PubMaster.Goods.AddStock(tileid, tiletrackid, goodid, fullqty);
                if (stockid > 0)
                {
                    PubMaster.Track.UpdateStockStatus(tiletrackid, TrackStockStatusE.有砖, "下砖");
                    PubMaster.Goods.AddStockInLog(stockid);
                }
            }

            //分配放货点
            if (stockid != 0 && PubMaster.Goods.AllocateGiveTrack(areaid, tileid, goodid, out List<uint> traids))
            {
                uint givetrackid = 0;
                foreach (uint traid in traids)
                {
                    if (!PubTask.Trans.IsTraInTransWithLock(traid))
                    {
                        givetrackid = traid;
                        break;
                    }
                }

                if (givetrackid != 0)
                {
                    PubMaster.Track.UpdateRecentGood(givetrackid, goodid);
                    PubMaster.Track.UpdateRecentTile(givetrackid, tileid);
                    //生成入库交易
                    PubTask.Trans.AddTrans(areaid, tileid, TransTypeE.入库, goodid, stockid, tiletrackid, givetrackid);
                }

                PubMaster.Warn.RemoveDevWarn(WarningTypeE.DownTileHaveNotTrackToStore, (ushort)tileid);
            }
            else if (stockid != 0)
            {
                PubMaster.Warn.AddDevWarn(WarningTypeE.DownTileHaveNotTrackToStore, (ushort)tileid);
            }
        }
        
        /// <summary>
        /// 添加出库任务
        /// </summary>
        /// <param name="areaid">区域ID</param>
        /// <param name="tileid">砖机ID</param>
        /// <param name="tiletrackid">砖机轨道ID</param>
        /// <param name="goodid">砖机规格</param>
        private void TileAddOutTransTask(uint areaid, uint tileid, uint tiletrackid, uint goodid)
        {
            bool isallocate = false;
            //1.查看是否有需要重新派发取货的空轨道
            if (PubMaster.Track.HaveTrackInGoodButNotStock(areaid, tileid, goodid, out List<uint> trackids))
            {
                foreach (uint trackid in trackids)
                {
                    if (!PubTask.Trans.HaveInTileTrack(trackid))
                    {
                        uint stockid = PubMaster.Goods.GetTrackTopStockId(trackid);

                        //有库存但是不是砖机需要的品种
                        if (stockid != 0 && !PubMaster.Goods.IsStockWithGood(stockid, goodid))
                        {
                            PubMaster.Track.UpdateRecentTile(trackid, 0);
                            PubMaster.Track.UpdateRecentGood(trackid, 0);
                            return;
                        }

                        //生成出库交易
                        PubTask.Trans.AddTrans(areaid, tileid, TransTypeE.出库, goodid, stockid, trackid, tiletrackid);
                        PubMaster.Goods.AddStockOutLog(stockid, tiletrackid, tileid);
                        PubMaster.Warn.RemoveDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)tileid);
                        isallocate = true;
                        break;
                    }
                }
            }

            //分配库存
            if (!isallocate && PubMaster.Goods.GetStock(areaid, tileid, goodid, out List<Stock> allocatestocks))
            {
                foreach (Stock stock in allocatestocks)
                {
                    if (!PubTask.Trans.IsStockInTrans(stock.id, stock.track_id))
                    {
                        PubMaster.Track.UpdateRecentGood(stock.track_id, goodid);
                        PubMaster.Track.UpdateRecentTile(stock.track_id, tileid);
                        //生成出库交易
                        PubTask.Trans.AddTrans(areaid, tileid, TransTypeE.出库, goodid, stock.id, stock.track_id, tiletrackid);

                        PubMaster.Goods.AddStockOutLog(stock.id, tiletrackid, tileid);
                        break;
                    }
                }
                PubMaster.Warn.RemoveDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)tileid);
            }
            else if (!isallocate)
            {
                PubMaster.Warn.AddDevWarn(WarningTypeE.UpTileHaveNotStockToOut, (ushort)tileid);
            }
        }

        /// <summary>
        /// 添加上砖机按轨道的出库任务
        /// </summary>
        /// <param name="areaid"></param>
        /// <param name="tileid"></param>
        /// <param name="tiletrackid"></param>
        private void TileAddTrackOutTransTask(uint areaid, uint tileid, uint tiletrackid, uint tilegoodid)
        {
            bool isallocate = false;
            List<TileTrack> tracks = PubMaster.TileTrack.GetTileTrack2Out(tileid);
            foreach (TileTrack tt in tracks)
            {
                Track track = PubMaster.Track.GetTrack(tt.track_id);
                if (track.TrackStatus != TrackStatusE.启用 
                    || track.StockStatus == TrackStockStatusE.空砖)
                {
                    PubMaster.TileTrack.DeleteTileTrack(tt);
                    continue;
                }

                Stock stock = PubMaster.Goods.GetTrackTopStock(tt.track_id);
                uint goodid = 0;
                uint stockid = 0;
                if (stock != null)
                {
                    stockid = stock.id;
                    goodid = stock.goods_id;

                    PubMaster.Track.UpdateRecentGood(stock.track_id, goodid);
                }
                else
                {
                    goodid = track.recent_goodid;
                    if(goodid == 0)
                    {
                        goodid = tilegoodid;
                    }
                }

                //生成出库交易
                PubTask.Trans.AddTrans(areaid, tileid, TransTypeE.出库, goodid, stockid, tt.track_id, tiletrackid);
                PubMaster.Goods.AddStockOutLog(stockid, tiletrackid, tileid);
                PubMaster.Warn.RemoveDevWarn(WarningTypeE.UpTileHaveNoTrackToOut, (ushort)tileid);
                isallocate = true;
                break;
            }

            if (!isallocate)
            {
                PubMaster.Warn.AddDevWarn(WarningTypeE.UpTileHaveNoTrackToOut, (ushort)tileid);
            }
        }

        internal List<TileLifterTask> GetDevTileLifters()
        {
            return DevList;
        }

        private bool IsTileLoadAndNeed(uint tileid, uint track, bool isload, bool isneed)
        {
            TileLifterTask tile = DevList.Find(c => c.ID == tileid);
            if (tile != null)
            {
                if(tile.LeftTrackId == track)
                {
                    return (isload ? tile.IsLoad_1 : tile.IsEmpty_1) && (isneed ? tile.IsNeed_1 : !tile.IsNeed_1);
                }

                if(tile.RigthTrackId == track)
                {
                    return (isload ? tile.IsLoad_2 : tile.IsEmpty_2) && (isneed ? tile.IsNeed_2 : !tile.IsNeed_2);
                }
            }

            return false;
        }

        public bool IsHaveLoadNoNeed(uint tileid, uint track)
        {
            return IsTileLoadAndNeed(tileid, track, true, false);
        }

        public bool IsHaveEmptyNoNeed(uint tileid, uint track)
        {
            return IsTileLoadAndNeed(tileid, track, false, false);
        }

        public bool IsHaveLoadNeed(uint tileid, uint track)
        {
            return IsTileLoadAndNeed(tileid, track, true, true);
        }

        public bool IsHaveEmptyNeed(uint tileid, uint track)
        {
            return IsTileLoadAndNeed(tileid, track, false, true);
        }

        internal byte getTileFullQty(uint devid, uint goodid)
        {
            TileLifterTask tile = DevList.Find(c => c.ID == devid);
            if (tile != null && tile.FullQty > 0)
            {
                return tile.FullQty;
            }
            return PubMaster.Goods.GetGoodsPieces(goodid);
        }


        /// <summary>
        /// 检查入库策略
        /// </summary>
        /// <param name="task"></param>
        /// <returns></returns>
        private bool CheckInStrategy(TileLifterTask task, uint goodsId, uint nowgId = 0, uint oldgId = 0)
        {
            bool iseffect = false;

            switch (task.InStrategy)
            {

                case StrategyInE.无:
                    iseffect = true;
                    PubMaster.Warn.AddDevWarn(WarningTypeE.TileNoneStrategy, (ushort)task.ID);
                    break;
                case StrategyInE.同机同轨://同一砖机同时只派发一个任务【间接限制了会下不同轨道】
                    iseffect = PubTask.Trans.HaveInLifter(task.ID);
                    break;
                case StrategyInE.同轨同轨://双下砖机，同时只作业一台砖机作业【间接限制了会下不同轨道】
                    iseffect = PubTask.Trans.HaveInTileTrack(task.LeftTrackId, task.RigthTrackId);
                    break;
                case StrategyInE.优先下砖:
                    break;
                case StrategyInE.同规同轨:
                    // 获取所有同策略砖机
                    List<uint> tileids = new List<uint>();
                    foreach (TileLifterTask item in DevList.FindAll(c => c.InStrategy == StrategyInE.同规同轨
                                && c.ID != task.ID
                                && (c.GoodsId == goodsId 
                                    || c.Device.old_goodid == goodsId
                                    || (nowgId > 0 && (c.GoodsId == nowgId || c.Device.old_goodid == nowgId))
                                    || (oldgId > 0 && (c.GoodsId == oldgId || c.Device.old_goodid == oldgId)))
                                ))
                    {
                        tileids.Add(item.ID);
                    }

                    iseffect = PubTask.Trans.HaveInTiles(task.AreaId, goodsId, TransTypeE.入库, tileids);
                    break;
            }
            return iseffect;
        }

        /// <summary>
        /// 检查入库策略
        /// </summary>
        /// <param name="task"></param>
        /// <returns></returns>
        private bool CheckOutStrategy(TileLifterTask task)
        {
            bool iseffect = false;

            switch (task.OutStrategy)
            {
                case StrategyOutE.无:
                    iseffect = true;
                    break;
                case StrategyOutE.同机同轨:
                    iseffect = PubTask.Trans.HaveInLifter(task.ID);
                    break;
                case StrategyOutE.同规同轨:
                    iseffect = PubTask.Trans.HaveInGoods(task.AreaId, task.GoodsId, TransTypeE.出库);
                    break;
                case StrategyOutE.优先上砖:
                    break;
                default:
                    break;
            }
            return iseffect;
        }

        /// <summary>
        /// 检查兄弟砖机是否满砖状态
        /// </summary>
        /// <param name="task"></param>
        /// <returns></returns>
        private bool CheckBrotherIsReady(TileLifterTask task, bool checkfull, bool checkleft)
        {
            //没有干预设备
            if (!task.HaveBrother) return true;

            TileLifterTask brotask = DevList.Find(c => c.ID == task.BrotherId);
            if (brotask == null) return false;
            if (checkleft)
            {
                if (brotask.IsNeed_1) return false;
                if(!brotask.IsInvo_1 && (checkfull ? brotask.IsLoad_1 : brotask.IsEmpty_1))
                {
                    Thread.Sleep(1000);
                    brotask.Do1Invo(DevLifterInvolE.介入);
                }
                return brotask.IsInvo_1 && (checkfull ? brotask.IsLoad_1 : brotask.IsEmpty_1);
            }

            if (!brotask.IsInvo_2 && (checkfull ? brotask.IsLoad_2 : brotask.IsEmpty_2))
            {
                if (brotask.IsNeed_2) return false;
                Thread.Sleep(1000);
                brotask.Do2Invo(DevLifterInvolE.介入);
            }
            return brotask.IsInvo_2 && (checkfull ? brotask.IsLoad_2 : brotask.IsEmpty_2);
        }

        #endregion

        #region[发送信息]
        private void MsgSend(TileLifterTask task, DevTileLifter tilelifter)
        {
            if(Monitor.TryEnter(_objmsg, TimeSpan.FromSeconds(5)))
            {
                try
                {
                    mMsg.ID = task.ID;
                    mMsg.Name = task.Device.name;
                    mMsg.o1 = tilelifter;
                    mMsg.o2 = task.ConnStatus;
                    mMsg.o3 = task.GoodsId;
                    mMsg.o4 = task.InStrategy;
                    mMsg.o5 = task.OutStrategy;
                    mMsg.o6 = task.IsWorking;
                    mMsg.o7 = task.WorkType;
                    Messenger.Default.Send(mMsg, MsgToken.TileLifterStatusUpdate);
                }
                finally
                {
                    Monitor.Exit(_objmsg);
                }
            }
        }
        
        #endregion 

        #region[判断状态]
        private bool CheckTileLifterStatus(TileLifterTask task, out string result)
        {
            if (task == null)
            {
                result = "找不到设备信息";
                return false;
            }

            if (task.ConnStatus != SocketConnectStatusE.通信正常)
            {
                result = "设备未连接";
                return false;
            }

            result = "";
            return true;
        }

        /// <summary>
        /// 判断下砖机是否可以取货
        /// </summary>
        /// <param name="tilelifter_id"></param>
        /// <param name="taketrackid"></param>
        /// <param name="result"></param>
        /// <returns></returns>
        internal bool IsTakeReady(uint tilelifter_id, uint taketrackid, out string result)
        {
            result = "";
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                return false;
            }
            try
            {
                TileLifterTask task = DevList.Find(c => c.ID == tilelifter_id);
                if(!CheckTileLifterStatus(task, out result))
                {
                    return false;
                }

                if(!CheckBrotherIsReady(task, false, task.LeftTrackId == taketrackid))
                {
                    return false;
                }

                if(task.LeftTrackId == taketrackid)
                {
                    return task.IsNeed_1 && task.IsLoad_1 && task.IsInvo_1;
                }
                
                if(task.RigthTrackId == taketrackid)
                {
                    return task.IsNeed_2 && task.IsLoad_2 && task.IsInvo_2;
                }

            }
            finally { Monitor.Exit(_obj); }
            return false;
        }
        
        /// <summary>
        /// 判断上砖机是否可以放砖
        /// </summary>
        /// <param name="tilelifter_id"></param>
        /// <param name="givetrackid"></param>
        /// <param name="result"></param>
        /// <returns></returns>
        internal bool IsGiveReady(uint tilelifter_id, uint givetrackid, out string result)
        {
            result = "";
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                return false;
            }
            try
            {
                TileLifterTask task = DevList.Find(c => c.ID == tilelifter_id);
                if(!CheckTileLifterStatus(task, out result))
                {
                    return false;
                }

                if(task.LeftTrackId == givetrackid)
                {
                    return task.IsNeed_1 && task.IsEmpty_1 && task.IsInvo_1;
                }
                
                if(task.RigthTrackId == givetrackid)
                {
                    return task.IsNeed_2 && task.IsEmpty_2 && task.IsInvo_2;
                }

            }
            finally { Monitor.Exit(_obj); }
            return false;
        }

        #endregion

        #region[更新规格信息]
        public void UpdateTileLifterGoods(uint devid, uint goodid)
        {
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(3)))
            {
                try
                {
                    TileLifterTask task = DevList.Find(c => c.ID == devid);
                    if (task != null)
                    {
                        task.Device.goods_id = goodid;
                        MsgSend(task, task.DevStatus);
                    }
                }
                finally { Monitor.Exit(_obj); }
            }
        }

        #endregion

        public void UpdateWorking(uint devId, bool working, byte worktype)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                return;
            }
            try
            {
                TileLifterTask task = DevList.Find(c => c.ID == devId);
                if (task != null)
                {
                    task.IsWorking = working;
                    if(worktype!=255)
                        task.WorkType = (DevWorkTypeE)worktype;
                    MsgSend(task, task.DevStatus);
                }
            }
            finally { Monitor.Exit(_obj); }

        }
    }
}
