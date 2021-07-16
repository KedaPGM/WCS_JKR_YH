﻿using enums;
using enums.track;
using enums.warning;
using GalaSoft.MvvmLight.Messaging;
using module.area;
using module.msg;
using module.rf;
using module.track;
using System;
using System.Collections.Generic;
using System.Linq;
using tool.mlog;

namespace resource.track
{
    public class TrackMaster
    {
        #region[构造/初始化]

        private Log mLog;

        public TrackMaster()
        {
            mLog = (Log)new LogFactory().GetLog("Site", false);
            TrackList = new List<Track>();
        }

        public void Start()
        {
            Refresh();
        }

        public void Refresh(bool refr_1 = true, bool refr_2 = true, bool refr_3 = true)
        {
            if (refr_1)
            {
                TrackList.Clear();
                TrackList.AddRange(PubMaster.Mod.TraSql.QueryTrackList());
            }
        }

        public object GetTrackNameByCode(ushort trackcode)
        {
            return TrackList.Find(c => c.IsInTrack(trackcode))?.name ?? "";
        }

        public void Stop()
        {

        }
        #endregion

        #region[字段]

        private List<Track> TrackList { set; get; }

        #endregion

        #region[获取对象]

        public List<Track> GetTrackList()
        {
            return TrackList;
        }

        public List<Track> GetTrackList(List<TrackTypeE> types)
        {
            return TrackList.FindAll(c => types.Contains(c.Type));
        }

        public List<Track> GetTrackList(uint areaid)
        {
            return TrackList.FindAll(c => c.area == areaid);
        }

        public Track GetTrack(uint trackid)
        {
            return TrackList.Find(c => c.id == trackid);
        }

        public Track GetTrackByCode(ushort trackcode)
        {
            return TrackList.Find(c => c.IsInTrack(trackcode));
        }

        public List<Track> GetTracksInTypes(List<TrackTypeE> types)
        {
            return TrackList.FindAll(c => types.Contains(c.Type));
        }
        #endregion

        #region[获取属性]

        public string GetTrackName(uint trackid)
        {
            return TrackList.Find(c => c.id == trackid)?.name ?? "";
        }

        public uint GetTrackId(ushort site)
        {
            if (site == 0) return 0;
            return GetTrackByCode(site)?.id ?? 0;
        }

        public bool IsTrackWithCode(uint take_track_id, ushort taketrackcode)
        {
            return TrackList.Exists(c => c.id == take_track_id && c.IsInTrack(taketrackcode));
        }

        public bool IsTrackInArea(uint filterareaid, uint track_id)
        {
            return TrackList.Exists(c => c.id == track_id && c.area == filterareaid);
        }

        public uint GetBrotherTrackId(uint trackid)
        {
            return TrackList.Find(c => c.id == trackid)?.brother_track_id ?? 0;
        }

        internal bool IsStoreTrack(uint track_id)
        {
            return TrackList.Exists(c => c.id == track_id
                                        && (c.Type == TrackTypeE.储砖_入
                                        || c.Type == TrackTypeE.储砖_出
                                        || c.Type == TrackTypeE.储砖_出入));
        }

        internal bool IsStoreGiveTrack(uint track_id)
        {
            return TrackList.Exists(c => c.id == track_id
                                           && (c.Type == TrackTypeE.储砖_入
                                           || c.Type == TrackTypeE.储砖_出入));
        }

        public List<Track> GetFerryTracks(uint ferryid)
        {
            List<AreaDeviceTrack> deviceTrack = PubMaster.Area.GetDevTrackList(ferryid);
            return TrackList.FindAll(c => deviceTrack.Exists(d => d.track_id == c.id));
        }

        internal int GetTrackMaxStore(uint trackid)
        {
            return TrackList.Find(c => c.id == trackid)?.max_store ?? 0;
        }

        /// <summary>
        /// 根据order的差值查找对应的轨道id
        /// </summary>
        /// <param name="track_id"></param>
        /// <param name="difference"></param>
        /// <param name="isAdd"></param>
        /// <returns></returns>
        public uint GetTrackIdByDifference(uint track_id, int difference, bool isAdd = true)
        {
            Track t = TrackList.Find(c => c.id == track_id);
            int newOrder = 0;
            if (isAdd)
            {
                newOrder = t.order + difference;
            }
            else
            {
                newOrder = (t.order - difference) < 1 ? 1 : (t.order - difference);
            }
            return TrackList.Find(c => c.order == newOrder      //c.area == t.area && 
                && (c.Type == TrackTypeE.储砖_入 || c.Type == TrackTypeE.储砖_出 || c.Type == TrackTypeE.储砖_出入))?.id ?? 0;
        }

        public List<uint> SortTrackIdsWithOrder(List<uint> trackids, uint tid, short order)
        {
            List<Track> tracks = TrackList.FindAll(c => c.id != tid && trackids.Contains(c.id));
            if (tracks.Count > 0)
            {
                tracks.Sort((x, y) =>
                {
                    int xorder = Math.Abs(x.order - order);
                    int yorder = Math.Abs(y.order - order);
                    return xorder.CompareTo(yorder);
                });
            }
            return tracks.Select(c => c.id).ToList();
        }

        /// <summary>
        /// 获取最小储砖轨道order
        /// </summary>
        /// <returns></returns>
        public int GetMinOrder(ushort area, DeviceTypeE dt)
        {
            switch (dt)
            {
                case DeviceTypeE.上摆渡:
                    return TrackList.FindAll(c => c.area == area
                            && c.InType(TrackTypeE.储砖_出入, TrackTypeE.上砖轨道, TrackTypeE.储砖_出)).Min(c => c.order);

                case DeviceTypeE.下摆渡:
                    return TrackList.FindAll(c => c.area == area
                            && c.InType(TrackTypeE.储砖_出入, TrackTypeE.下砖轨道, TrackTypeE.储砖_入)).Min(c => c.order);

                default:
                    return 0;
            }
        }

        /// <summary>
        /// 获取最大储砖轨道order
        /// </summary>
        /// <returns></returns>
        public int GetMaxOrder(ushort area, DeviceTypeE dt)
        {
            switch (dt)
            {
                case DeviceTypeE.上摆渡:
                    return TrackList.FindAll(c => c.area == area
                            && c.InType(TrackTypeE.储砖_出入, TrackTypeE.上砖轨道, TrackTypeE.储砖_出)).Max(c => c.order);

                case DeviceTypeE.下摆渡:
                    return TrackList.FindAll(c => c.area == area
                            && c.InType(TrackTypeE.储砖_出入, TrackTypeE.下砖轨道, TrackTypeE.储砖_入)).Max(c => c.order);

                default:
                    return 0;
            }
        }

        /// <summary>
        /// 根据order查找对应的储砖轨道ID
        /// </summary>
        /// <returns></returns>
        public uint GetTrackIDByOrder(ushort area, int order)
        {
            return TrackList.Find(c => c.area == area && c.order == order &&
            (c.Type == TrackTypeE.储砖_入 || c.Type == TrackTypeE.储砖_出 || c.Type == TrackTypeE.储砖_出入))?.id ?? 0;
        }

        internal ushort GetTrackArea(ushort trackid)
        {
            return (ushort)(GetTrack(trackid)?.area ?? 0);
        }

        /// <summary>
        /// 获取轨道位置相对顺序
        /// </summary>
        /// <param name="trackid"></param>
        /// <returns></returns>
        public short GetTrackOrder(uint trackid)
        {
            return TrackList.Find(c => c.id == trackid)?.order ?? 0;
        }

        public bool IsUpAreaTrack(uint traid)
        {
            return TrackList.Exists(c => c.id == traid &&
                (c.Type == TrackTypeE.上砖轨道 || c.Type == TrackTypeE.储砖_出 || c.Type == TrackTypeE.储砖_出入 || c.Type == TrackTypeE.摆渡车_出));
        }
        public bool IsDownAreaTrack(uint traid)
        {
            return TrackList.Exists(c => c.id == traid &&
                (c.Type == TrackTypeE.下砖轨道 || c.Type == TrackTypeE.储砖_入 || c.Type == TrackTypeE.储砖_出入 || c.Type == TrackTypeE.摆渡车_入));
        }

        #endregion

        #region[更改]

        public bool SetTrackStatus(uint trackid, TrackStatusE trackstatus, out string result, string memo ="")
        {
            Track track = TrackList.Find(c => c.id == trackid);
            if (track == null)
            {
                result = "找不到轨道的信息";
                return false;
            }

            if (track.TrackStatus == trackstatus)
            {
                result = "不用修改";
                return false;
            }

            //if (track.TrackStatus == TrackStatusE.倒库中)
            //{
            //    result = "倒库中不能修改";
            //    return false;
            //}
            UpdateTrackStatus(track, trackstatus, memo);

            result = "";
            return true;
        }

        public List<Track> GetTileTrack(uint areaid, uint tileid)
        {
            List<AreaDeviceTrack> areadevtras = PubMaster.Area.GetAreaDevTraList(areaid, tileid);
            return TrackList.FindAll(c => areadevtras.Exists(a=>a.track_id ==c.id));
        }

        public bool SetStockStatus(uint trackid, TrackStockStatusE goodstatus, out string result, string memo = "")
        {
            Track track = TrackList.Find(c => c.id == trackid);
            if (track == null)
            {
                result = "找不到轨道的信息";
                return false;
            }

            if (track.StockStatus == goodstatus)
            {
                result = "不用修改";
                return false;
            }

            if (goodstatus == TrackStockStatusE.空砖 && PubMaster.Goods.ExistStockInTrack(trackid))
            {
                result = "轨道有库存记录";
                return false;
            }

            if (goodstatus == TrackStockStatusE.满砖 && !PubMaster.Goods.ExistStockInTrack(trackid))
            {
                result = "轨道没有库存记录";
                return false;
            }

            UpdateStockStatus(track, goodstatus, memo);

            result = "";
            return true;
        }

        public void ResetTrackRecent(uint id)
        {
            Track track = TrackList.Find(c => c.id == id);
            if (track != null)
            {
                track.recent_goodid = 0;
                track.recent_tileid = 0;
            }
        }

        public void SetSortTrackStatus(uint taketrackid, uint givetrackid, TrackStatusE fromstatus, TrackStatusE tostatus)
        {
            Track taketrack = TrackList.Find(c => c.id == taketrackid);
            Track givetrack = TrackList.Find(c => c.id == givetrackid);

            if (taketrack != null && taketrack.TrackStatus == fromstatus)
            {
                UpdateTrackStatus(taketrack, tostatus, "倒库");
            }

            if(givetrack != null && givetrack.TrackStatus == fromstatus)
            {
                UpdateTrackStatus(givetrack, tostatus, "倒库");
            }
        }

        /// <summary>
        /// 倒库交换库存信息
        /// </summary>
        /// <param name="taketrackid">满砖轨道</param>
        /// <param name="givetrackid">空砖轨道</param>
        internal void ShiftTrack(uint taketrackid, uint givetrackid)
        {
            UpdateStockStatus(taketrackid, TrackStockStatusE.空砖, "倒库");
            UpdateStockStatus(givetrackid, TrackStockStatusE.满砖, "倒库");
        }

        public void UpdateStockStatus(uint trackid, TrackStockStatusE status, string memo)
        {
            Track track = TrackList.Find(c => c.id == trackid);
            UpdateStockStatus(track, status, memo);
        }

        internal void UpdateStockStatus(Track track, TrackStockStatusE status, string memo)
        {
            if (track != null)
            {
                //if (track.Status == TrackGoodStatusE.满砖 && status == TrackGoodStatusE.有砖) return;
                if (track.StockStatus == status) return;
                mLog.Status(true, string.Format("轨道；{0}，原货：{1}，新货：{2} , {3}", track.name, track.StockStatus, status, memo));
                track.StockStatus = status;
                PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.StockStatus);
                if(status == TrackStockStatusE.有砖 && track.early_full)
                {
                    SetTrackEaryFull(track.id, false, null);
                }
                else
                {
                    SendMsg(track);
                }
            }
        }

        internal void UpdateTrackStatus(Track track, TrackStatusE trackstatus, string memo)
        {
            if (track != null && track.TrackStatus != trackstatus)
            {
                mLog.Status(true, string.Format("轨道；{0}，原状：{1}，新状：{2} , {3}", track.name, track.TrackStatus, trackstatus, memo));
                track.TrackStatus = trackstatus;
                PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.TrackStatus);
                if (trackstatus == TrackStatusE.停用 && track.early_full)
                {
                    SetTrackEaryFull(track.id, false, null);
                }
                SendMsg(track);
            }
        }

        public void UpdateRecentTile(uint trackid, uint recenttile)
        {
            Track track = TrackList.Find(c => c.id == trackid);
            if (track != null && track.recent_tileid != recenttile)
            {
                track.recent_tileid = recenttile;
                PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.RecentTileId);
            }
        }

        public void UpdateRecentGood(uint trackid, uint goodid)
        {
            Track track = TrackList.Find(c => c.id == trackid);
            if (track != null && track.recent_goodid != goodid)
            {
                track.recent_goodid = goodid;
                PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.RecentGoodId);
            }
        }

        /// <summary>
        /// 空砖/满砖/一般的取货卸货
        /// </summary>
        /// <param name="signal"></param>
        /// <param name="signalTime"></param>
        /// <param name="takeTrackCode"></param>
        /// <param name="giveTrackCode"></param>
        /// <returns>处理结果</returns>
        public bool SetTrack(DevCarrierSignalE signal, ushort signalTime, ushort takeTrackCode, ushort giveTrackCode)
        {
            bool result = false;
            switch (signal)
            {
                #region[空砖信息]
                //小车取卸货后: 取砖轨道 -> 空
                case DevCarrierSignalE.空轨道:

                    break;
                #endregion
                case DevCarrierSignalE.满轨道:

                    break;
                case DevCarrierSignalE.非空非满:
                    break;
            }

            return result;
        }

        /// <summary>
        /// 空砖信息
        /// </summary>
        /// <param name="taketrackcode"></param>
        /// <returns></returns>
        public bool SetTrackEmtpy(ushort taketrackcode)
        {
            Track track = GetTrackByCode(taketrackcode);
            if (track != null)
            {
                if (track.StockStatus != TrackStockStatusE.空砖)
                {
                    track.StockStatus = TrackStockStatusE.空砖;
                    PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.StockStatus);
                    PubMaster.Goods.RemoveStock(track.id);
                    SendMsg(track);
                }
                return true;
            }
            return false;
        }

        public List<FerryPos> AddFerryPos(uint areaid, uint devid)
        {
            List<AreaDeviceTrack> deviceTracks = PubMaster.Area.GetAreaDevTraList(areaid, devid);
            if(deviceTracks.Count == 0)
            {
                return new List<FerryPos>();
            }
            bool isdownferry = PubMaster.Device.IsDevType(devid, DeviceTypeE.下摆渡);
            Track track;
            FerryPos pos;
            foreach (AreaDeviceTrack item in deviceTracks)
            {
                track = GetTrack(item.track_id);
                if (track == null) continue;
                pos = new FerryPos
                {
                    track_id = track.id,
                    device_id = devid
                };
                switch (track.Type)
                {
                    case TrackTypeE.上砖轨道:
                    case TrackTypeE.储砖_入:
                        pos.ferry_code = track.ferry_up_code;
                        break;
                    case TrackTypeE.储砖_出入:
                        pos.ferry_code = isdownferry ? track.ferry_up_code : track.ferry_down_code;
                        break;
                    case TrackTypeE.储砖_出:
                    case TrackTypeE.下砖轨道:
                        pos.ferry_code = track.ferry_down_code;
                        break;
                    case TrackTypeE.摆渡车_入:
                    case TrackTypeE.摆渡车_出:
                        continue;
                }
                PubMaster.Mod.TraSql.AddFerryPos(pos);
            }
            //PubMaster.Mod.TraSql.AddFerryPos(areaid, devid);
            return PubMaster.Mod.TraSql.QueryFerryPosList(areaid, devid);
        }

        public List<FerryPos> GetFerryPos(uint areaid, uint devid)
        {
            return PubMaster.Mod.TraSql.QueryFerryPosList(areaid, devid);
        }

        public List<FerryPos> GetFerryPos(uint devid)
        {
            return PubMaster.Mod.TraSql.QueryFerryPosList(devid);
        }

        /// <summary>
        /// 满足信息
        /// </summary>
        /// <param name="givetrackcode"></param>
        /// <returns></returns>
        public bool SetTrackFull(ushort givetrackcode)
        {
            Track track = GetTrackByCode(givetrackcode);
            if (track != null)
            {
                if (track.StockStatus != TrackStockStatusE.满砖)
                {
                    track.StockStatus = TrackStockStatusE.满砖;
                    PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.StockStatus);
                    SendMsg(track);
                }
                return true;
            }
            return false;
        }

        public void UpdateFerryPos(uint id, int ferrypos)
        {
            PubMaster.Mod.TraSql.EditFerryPos(id, ferrypos);
        }
        
        public void UpdateFerryPos(uint devid, int trackcode, int ferrypos)
        {
            PubMaster.Mod.TraSql.EditFerryPos(devid, trackcode, ferrypos);
        }

        public List<uint> GetFerryTrackId(uint area_id, TransTypeE transType)
        {
            List<uint> list = new List<uint>();
            switch (transType)
            {
                case TransTypeE.入库:
                    list.AddRange(TrackList.FindAll(c => c.Type == TrackTypeE.摆渡车_入).Select(c => c.id));
                    break;
                case TransTypeE.出库:
                    list.AddRange(TrackList.FindAll(c => c.Type == TrackTypeE.摆渡车_出).Select(c => c.id));
                    break;
                case TransTypeE.倒库:
                    list.AddRange(TrackList.FindAll(c => c.Type == TrackTypeE.摆渡车_出).Select(c => c.id));
                    break;
                case TransTypeE.其他:
                    break;
                default:
                    break;
            }
            return list;
        }

        public ushort AddTrackLog(ushort area, uint devid, uint trackid, TrackLogE logtype, string memo = "")
        {
            ushort storecount = PubMaster.Goods.GetTrackStockCount(trackid);
            TrackLog log = new TrackLog()
            {
                dev_id = devid,
                track_id = trackid,
                type = (byte)logtype,
                stock_count = storecount,
                log_time = DateTime.Now,
                memo = memo,
                area = area
            };

            PubMaster.Mod.TraSql.AddTrackLog(log);
            return storecount;
        }

        internal bool IsBrotherTrack(uint taketrackid, uint givetrackid)
        {
            return TrackList.Exists(c => c.id == taketrackid && c.brother_track_id == givetrackid);
        }

        public bool GetTrackFerryCode(uint take_track_id, DeviceTypeE ferrytype, out ushort trackferrycode, out string result)
        {
            result = "";
            trackferrycode = 0;
            Track track = TrackList.Find(c => c.id == take_track_id);
            if(track != null)
            {
                switch (track.Type)
                {
                    case TrackTypeE.上砖轨道:
                    case TrackTypeE.储砖_入:
                        trackferrycode = track.ferry_up_code;
                        break;
                    case TrackTypeE.下砖轨道:
                    case TrackTypeE.储砖_出:
                        trackferrycode = track.ferry_down_code;
                        break;
                    case TrackTypeE.储砖_出入:
                        if(ferrytype == DeviceTypeE.下摆渡)
                        {
                            trackferrycode = track.ferry_up_code;
                        }
                        else
                        {
                            trackferrycode = track.ferry_down_code;
                        }
                        break;
                    default:

                        break;
                }

                if(trackferrycode != 0)
                {
                    result = "";
                    return true;
                }
            }

            result = "找不到轨道信息";
            return false;
        }

        public bool IsTrackHaveStock(uint track_id)
        {
            return TrackList.Exists(c => c.id == track_id && c.StockStatus == TrackStockStatusE.有砖);
        }

        public bool IsEmtpy(uint track_id)
        {
            return TrackList.Exists(c => c.id == track_id && c.StockStatus == TrackStockStatusE.空砖);
        }

        internal bool CheckAndSetFull(uint track_id, int storecount)
        {
            Track track = TrackList.Find(c => c.id == track_id);
            if (track != null)
            {
                if(track.StockStatus != TrackStockStatusE.满砖 && track.max_store <= storecount)
                {
                    track.StockStatus = TrackStockStatusE.满砖;
                    PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.StockStatus);
                    SendMsg(track);
                }

                if (track.StockStatus == TrackStockStatusE.满砖)
                {
                    return true;
                }
            }
            return false;
        }

        internal List<uint> GetAreaTrackIds(uint areaid, TrackTypeE type)
        {
            return TrackList.FindAll(c => c.area == areaid && c.Type == type).Select(c=>c.id).ToList();
        }

        public bool IsTrackFull(uint track_id)
        {
            return TrackList.Exists(c => c.id == track_id && c.StockStatus == TrackStockStatusE.满砖);
        }

        public int GetTracCode(ushort trackid)
        {
            return TrackList.Find(c => c.id == trackid)?.TrackCode ?? 0;
        }

        public bool IsStoreType(uint traid)
        {
            return TrackList.Exists(c => c.id == traid 
                                && (c.Type == TrackTypeE.储砖_入 
                                    || c.Type == TrackTypeE.储砖_出 
                                    || c.Type == TrackTypeE.储砖_出入));
        }

        public bool IsTrackType(uint traid, TrackTypeE type)
        {
            return TrackList.Exists(c => c.id == traid && c.Type == type);
        }

        private void SendMsg(Track track)
        {
            MsgAction msg = new MsgAction();
            msg.o1 = track;
            Messenger.Default.Send(msg, MsgToken.TrackStatusUpdate) ;
        }

        public bool IsStatusOkToGive(uint give_track_id)
        {
            return TrackList.Exists(c => c.id == give_track_id
                                    && c.StockStatus != TrackStockStatusE.满砖
                                    && c.TrackStatus == TrackStatusE.启用
                                    && c.AlertStatus == TrackAlertE.正常);
        }


        /// <summary>
        /// 获取入库满砖轨道
        /// </summary>
        /// <returns></returns>
        public List<Track> GetFullInTrackList()
        {
            return TrackList.FindAll(c => c.TrackStatus == TrackStatusE.启用 
                                        && c.StockStatus == TrackStockStatusE.满砖 
                                        && c.Type == TrackTypeE.储砖_入
                                        && c.AlertStatus == TrackAlertE.正常);
        }

        public bool IsTrackEmtpy(uint track_id)
        {
            Track track = GetTrack(track_id);
            if(track != null)
            {
                return track.TrackStatus == TrackStatusE.启用 
                        && track.StockStatus == TrackStockStatusE.空砖 
                        && track.AlertStatus == TrackAlertE.正常
                        && !PubMaster.Goods.ExistStockInTrack(track_id);
            }
            return false;
        }

        public bool IsTrackEnable(uint track_id)
        {
            return TrackList.Exists(c => c.id == track_id && c.TrackStatus == TrackStatusE.启用 && c.AlertStatus == TrackAlertE.正常);
        }

        /// <summary>
        /// 获取最近 下砖/上砖的轨道
        /// </summary>
        /// <param name="list"></param>
        /// <param name="devid"></param>
        /// <param name="goodsid"></param>
        /// <returns></returns>
        internal List<Track> GetRecentUseTracks(List<AreaDeviceTrack> list, uint devid, uint goodsid)
        {
            return TrackList.FindAll(c => c.recent_goodid == goodsid  //&& c.recent_tileid == devid
                                        && list.Exists(l => l.track_id == c.id));
        }

        internal List<Track> GetRecentGoodTracks(List<AreaDeviceTrack> list, uint goodsid)
        {
            return TrackList.FindAll(c => c.recent_goodid == goodsid && list.Exists(l => l.track_id == c.id));
        }

        /// <summary>
        /// 获取区域指定类型的轨道
        /// </summary>
        /// <param name="area"></param>
        /// <param name="totracktype"></param>
        /// <returns></returns>
        public List<Track> GetTrackInTypeFree(ushort area, TrackTypeE totracktype)
        {
            List<Track> list = TrackList.FindAll(c => c.area == area
                                       && c.Type == totracktype
                                       && c.TrackStatus == TrackStatusE.启用
                                       && c.AlertStatus == TrackAlertE.正常);
            if(list.Count > 0)
            {
                list.Sort((x, y) => x.stock_status.CompareTo(y.stock_status));
            }
            return list;
        }

        public bool IsTrackFree(uint trackid)
        {
            if (trackid == 0) return false;
            Track track = GetTrack(trackid);
            return track != null 
                && track.TrackStatus == TrackStatusE.启用 
                && track.StockStatus == TrackStockStatusE.空砖
                && track.AlertStatus == TrackAlertE.正常;
        }

        public void SetTrackAlert(uint trackid, uint carrier, uint transid, TrackAlertE alert)
        {
            Track track = TrackList.Find(c => c.id == trackid);
            if(track != null && track.AlertStatus != alert)
            {
                track.AlertStatus = alert;
                track.alert_carrier = carrier;
                track.alert_trans = transid;
                PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.Alert);
                SendMsg(track);
            }
        }

        public void SetTrackEaryFull(uint trackid, bool value, DateTime? earytime)
        {
            Track track = TrackList.Find(c => c.id == trackid);
            if (track != null && track.early_full != value)
            {
                track.early_full = value;
                track.full_time = earytime;
                PubMaster.Mod.TraSql.EditTrack(track, TrackUpdateE.EarlyFull);
                if (value)
                {
                    PubMaster.Warn.AddTraWarn(WarningTypeE.TrackEarlyFull, (ushort)track.id, track.name);
                }
                else
                {
                    PubMaster.Warn.RemoveTraWarn(WarningTypeE.TrackEarlyFull, (ushort)track.id);
                }
                SendMsg(track);
            }
        }
        #endregion

        #region[更新轨道状态]

        public bool CheckAndUpateTrackStatus(TrackUpdatePack pack, out string result)
        {
            if (pack == null) {
                result = "找不到轨道信息";
                return false;
            }
            if (pack.TrackId == 0) {
                result = "轨道ID不能为空";
                return false; 
            }

            Track track = GetTrack(pack.TrackId);
            if(track.stock_status != pack.OldStockStatus || track.track_status != pack.OldTrackStatus)
            {
                result = "请刷新后再修改！";
                return false;
            }

            if(!pack.IsStockStatusChange() && !pack.IsStatusChange())
            {
                result = "不需要更改，请刷新！";
                return false;
            }
            
            if(pack.IsStatusChange() && !SetTrackStatus(pack.TrackId, (TrackStatusE) pack.TrackStatus, out result, "平板"))
            {
                return false;
            }

            if(pack.IsStockStatusChange() && !SetStockStatus(pack.TrackId, (TrackStockStatusE)pack.StockStatus, out result, "平板"))
            {
                return false;
            }

            result = "";
            return true;
        }

        #endregion

        #region[判断是否有非空轨道状态的轨道]

        public bool HaveTrackInGoodButNotStock(uint areaid, uint tilelifterid, uint goodsid, out List<uint> trackids)
        {
            trackids = new List<uint>();
            List<AreaDeviceTrack> devtrack = PubMaster.Area.GetAreaDevTraList(areaid, tilelifterid);

            //1.查看是否有最近下砖规格轨道
            List<Track> recentusetracks = GetRecentGoodTracks(devtrack, goodsid);
            foreach (Track track in recentusetracks)
            {
                if (track.StockStatus != TrackStockStatusE.有砖
                    || track.TrackStatus != TrackStatusE.启用
                    || track.AlertStatus != TrackAlertE.正常)
                {
                    UpdateRecentTile(track.id, 0);
                    UpdateRecentGood(track.id, 0);
                    continue;
                }
                if(!PubMaster.Goods.ExistStockInTrack(track.id))
                    trackids.Add(track.id);
            }
            return trackids.Count > 0;
        }

        public bool HaveEmptyTrackInTile(ushort areaid, uint devid)
        {
            List<AreaDeviceTrack> list = PubMaster.Area.GetAreaDevTraList(areaid, devid);
            return TrackList.Exists(c => c.StockStatus == TrackStockStatusE.空砖 
                    && list.Exists(l => l.track_id == c.id));
        }

        public bool IsRecentGoodId(uint trackid, uint goods_id)
        {
            return TrackList.Exists(c => c.id == trackid && c.recent_goodid == goods_id);
        }

        public bool IsEarlyFullTimeOver(uint id)
        {
            Track track = GetTrack(id);
            if (track != null && track.early_full)
            {
                if(track.full_time is DateTime time)
                {
                    return (DateTime.Now - time).TotalMinutes > 5;
                }else{
                    track.full_time = DateTime.Now;
                }
                return false;
            }

            return true;
        }
        #endregion
    }
}