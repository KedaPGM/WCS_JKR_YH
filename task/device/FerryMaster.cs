using enums;
using enums.track;
using enums.warning;
using GalaSoft.MvvmLight.Messaging;
using module.area;
using module.device;
using module.goods;
using module.msg;
using module.track;
using resource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using task.task;
using tool.mlog;
using tool.timer;

namespace task.device
{
    /// <summary>
    /// 摆渡车
    /// </summary>
    public class FerryMaster
    {
        #region[字段]
        private object _objmsg;
        private MsgAction mMsg;
        private List<FerryTask> DevList { set; get; }

        private readonly object _obj;

        private Thread _mRefresh;
        private bool Refreshing = true;
        private MTimer mTimer;
        #region[摆渡对位]
        private bool _IsSetting;
        private List<FerryPosSet> _FerryPosSetList;
        private Log mlog;
        #endregion

        #endregion

        #region[属性]

        #endregion

        #region[构造/启动/停止/重连]

        public FerryMaster()
        {
            mlog = (Log)new LogFactory().GetLog("Ferry", false);
            mTimer = new MTimer();
            _objmsg = new object();
            mMsg = new MsgAction();
            _obj = new object();
            DevList = new List<FerryTask>();
            _FerryPosSetList = new List<FerryPosSet>();

            Messenger.Default.Register<SocketMsgMod>(this, MsgToken.FerryMsgUpdate, FerryMsgUpdate);
        }

        public void Start()
        {
            List<Device> ferrys = PubMaster.Device.GetFerrys();
            foreach (Device dev in ferrys)
            {
                FerryTask task = new FerryTask
                {
                    Device = dev
                };
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

        public void Stop()
        {
            foreach (FerryTask task in DevList)
            {
                task.Stop();
            }
        }

        public void ReStart()
        {

        }

        private void Refresh()
        {
            while (Refreshing)
            {
                if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(1)))
                {
                    try
                    {
                        foreach (FerryTask task in DevList)
                        {
                            if (task.IsEnable)
                            {
                                task.DoQuery();
                            }

                            if (task.IsEnable && _IsSetting && _FerryPosSetList.Find(c => c.FerryId == task.ID) is FerryPosSet set)
                            {
                                Thread.Sleep(1000);
                                task.DoSiteQuery(set.QueryPos);
                            }

                            #region 失去位置信息
                            uint ctid = task.GetFerryCurrentTrackId();
                            Track ct = PubMaster.Track.GetTrack(ctid);
                            if (ct == null || ctid == 0 || ctid.Equals(0) || ctid.CompareTo(0) == 0)
                            {
                                PubMaster.Warn.AddDevWarn(WarningTypeE.FerryNoLocation, (ushort)task.ID);
                            }
                            else
                            {
                                PubMaster.Warn.RemoveDevWarn(WarningTypeE.FerryNoLocation, (ushort)task.ID);
                            }
                            #endregion

                            // 手动清记录目标点
                            if (task.DevStatus.WorkMode == DevOperateModeE.手动 && task.DevStatus.TargetSite == 0)
                            {
                                task.RecordTraId = 0;
                                task.DevTcp.AddStatusLog(string.Format("手动-清除记录目标"));
                            }

                            if (task.Status == DevFerryStatusE.停止 && task.DevStatus.CurrentTask == DevFerryTaskE.定位)
                            {
                                //上砖测轨道ID 或 下砖测轨道ID
                                if (task.UpTrackId == PubMaster.Track.GetTrackId(task.DevStatus.TargetSite) && task.IsUpLight)
                                {
                                    Thread.Sleep(1000);
                                    task.DoStop();
                                }

                                if (task.DownTrackId == PubMaster.Track.GetTrackId(task.DevStatus.TargetSite) && task.IsDownLight)
                                {
                                    Thread.Sleep(1000);
                                    task.DoStop();
                                }

                                if (task.DevStatus.CurrentTask == task.DevStatus.FinishTask && task.DevStatus.TargetSite == 0)
                                {
                                    Thread.Sleep(1000);
                                    task.DoStop();
                                }
                            }
                        }
                    }
                    finally { Monitor.Exit(_obj); }
                }
                Thread.Sleep(2000);
            }
        }

        #endregion

        #region[获取信息]

        public void GetAllFerry()
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                return;
            }
            try
            {
                foreach (FerryTask task in DevList)
                {
                    MsgSend(task, task.DevStatus);
                }
            }
            finally { Monitor.Exit(_obj); }
        }

        internal FerryTask GetFerry(uint devid)
        {
            return DevList.Find(c => c.ID == devid);
        }

        /// <summary>
        /// 摆渡车当前对应轨道ID
        /// </summary>
        /// <param name="devid"></param>
        /// <returns></returns>
        public uint GetFerryCurrentTrackId(uint devid)
        {
            return DevList.Find(c => c.ID == devid)?.GetFerryCurrentTrackId() ?? 0;
        }

        #endregion

        #region[数据更新]

        private void FerryMsgUpdate(SocketMsgMod mod)
        {
            if (mod != null)
            {
                if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
                {
                    try
                    {
                        FerryTask task = DevList.Find(c => c.ID == mod.ID);
                        if (task != null)
                        {
                            task.ConnStatus = mod.ConnStatus;
                            if (mod.Device is DevFerry ferry)
                            {
                                task.DevStatus = ferry;
                                task.UpdateInfo();
                                if (ferry.IsUpdate || mTimer.IsTimeOutAndReset(TimerTag.DevRefreshTimeOut, ferry.ID, 5))
                                {
                                    MsgSend(task, ferry);
                                }

                                ///摆渡车对位中
                                if (_IsSetting)
                                {
                                    if (_FerryPosSetList.Find(c => c.FerryId == task.ID && !c.IsRF) is FerryPosSet set)
                                    {
                                        PosMsgSend(task, ferry);
                                    }

                                    if (_FerryPosSetList.Find(c => c.FerryId == task.ID && c.IsRF) is FerryPosSet rfset)
                                    {
                                        RfPosMsgSend(rfset, ferry);
                                    }
                                }
                            }

                            if (mod.Device is DevFerrySite site)
                            {
                                task.DevSite = site;

                                if (_FerryPosSetList.Find(c => c.FerryId == task.ID && !c.IsRF) is FerryPosSet fset)
                                {
                                    PosMsgSend(task, site);
                                }

                                if (_FerryPosSetList.Find(c => c.FerryId == task.ID && c.IsRF) is FerryPosSet rfset)
                                {
                                    RfPosSiteMsgSend(rfset, task.ID, site);
                                }
                            }
                            CheckConn(task);
                        }
                    }
                    catch (Exception e)
                    {
                        mlog.Error(true, e.Message, e);
                    }
                    finally { Monitor.Exit(_obj); }
                }
            }
        }

        public bool HaveFerryOnTrack(ushort ferry_code, DevCarrierTaskE type, out string result)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                result = "稍后再试！";
                return false;
            }
            try
            {
                Track track = PubMaster.Track.GetTrackByCode(ferry_code);
                if(track != null)
                {
                    if(track.Type == TrackTypeE.摆渡车_入 || track.Type == TrackTypeE.摆渡车_出)
                    {
                        result = "小车已经在摆渡车上了！";
                        return false;
                    }
                    FerryTask task = null;
                    if (type == DevCarrierTaskE.前进至摆渡车)
                    {
                        task = DevList.Find(c => c.IsOnSite(track.ferry_down_code));
                    }

                    if(type == DevCarrierTaskE.后退至摆渡车)
                    {
                        task = DevList.Find(c => c.IsOnSite(track.ferry_up_code));
                    }

                    if (!CheckFerryStatus(task, out result))
                    {
                        return false;
                    }

                    if (task.Status == DevFerryStatusE.停止)
                    {
                        return true;
                    }
                }
            }
            finally
            {
                Monitor.Exit(_obj);
            }
            result = "没有符合条件的摆渡车!";
            return false;
        }

        public bool HaveFerryOnTileTrack(ushort ferry_code, DevCarrierTaskE type, out string result)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                result = "稍后再试！";
                return false;
            }
            try
            {
                Track track = PubMaster.Track.GetTrackByCode(ferry_code);
                if (track != null)
                {
                    if (track.Type == TrackTypeE.摆渡车_入 || track.Type == TrackTypeE.摆渡车_出)
                    {
                        result = "小车已经在摆渡车上了！";
                        return true;
                    }
                    FerryTask task = null;
                    if (type == DevCarrierTaskE.前进至摆渡车)
                    {
                        task = DevList.Find(c => c.IsOnSite(track.ferry_down_code));
                    }

                    if (type == DevCarrierTaskE.后退至摆渡车)
                    {
                        task = DevList.Find(c => c.IsOnSite(track.ferry_up_code));
                    }

                    if (task == null)
                    {
                        result = "找不到对应轨道（" + track.name + "）的摆渡车设备信息";
                        mlog.Status(true, result);
                        return false;
                    }

                    if (!CheckFerryStatus(task, out result))
                    {
                        mlog.Status(true, task.Device.name + "摆渡车HaveFerryOnTileTrack()" + result);
                        return false;
                    }

                    if (task.Status == DevFerryStatusE.停止)
                    {
                        return true;
                    }
                    mlog.Status(true, task.Device.name + "摆渡车HaveFerryOnTileTrack()" + result);
                }
            }
            finally
            {
                Monitor.Exit(_obj);
            }
            result = "没有符合条件的摆渡车!";
            return false;
        }

        private void CheckConn(FerryTask task)
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

        #region[执行任务]

        internal bool TryLock(StockTrans trans, uint ferryid, uint carriertrackid)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                return false;
            }
            try
            {
                FerryTask task = DevList.Find(c => c.ID == ferryid);
                if (task == null) return false;

                //小车在摆渡车上，直接锁定
                if(task.LeftTrackId == carriertrackid)
                {
                    if (!task.IsStillLockInTrans(trans.id))
                    {
                        task.SetFerryLock(trans.id);
                    }
                    return true;
                }

                if (task.IsStillLockInTrans(trans.id))
                {
                    return true;
                }

                if (task.IsFerryFree())
                {
                    task.SetFerryLock(trans.id);
                }

                return false;
            }
            finally { Monitor.Exit(_obj); }
        }

        public bool StopFerry(uint id, out string result)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                result = "稍后再试！";
                return false;
            }
            try
            {
                FerryTask task = DevList.Find(c => c.ID == id);
                if (!CheckFerryStatus(task, out result))
                {
                    return false;
                }
                task.DoStop();
                return true;
            }
            finally
            {
                Monitor.Exit(_obj);
            }
        }

        public bool DoManualLocate(uint ferryid, uint trackid, bool isdownferry, out string result)
        {
            Track tra = PubMaster.Track.GetTrack(trackid);
            if(tra == null)
            {
                result = "找不到轨道信息！";
                return false;
            }

            if(!PubMaster.Area.IsFerrySetTrack(ferryid, tra.id))
            {
                result = "摆渡车未配置" + tra.name +"！";
                return false;
            }

            ushort ferrycode = tra.ferry_down_code;
            if (isdownferry)
            {
                if (tra.Type == TrackTypeE.上砖轨道 || tra.Type == TrackTypeE.储砖_出)
                {
                    result = "请选择下砖区域的轨道";
                    return false;
                }
            }
            else
            {   //上砖摆渡
                if (tra.Type == TrackTypeE.下砖轨道 || tra.Type == TrackTypeE.储砖_入)
                {
                    result = "请选择上砖区域的轨道";
                    return false;
                }
            }

            switch (tra.Type)
            {
                case TrackTypeE.上砖轨道:
                    ferrycode = tra.ferry_up_code;
                    break;
                case TrackTypeE.下砖轨道:
                    ferrycode = tra.ferry_down_code;
                    break;
                case TrackTypeE.储砖_入:
                    ferrycode = tra.ferry_up_code;
                    break;
                case TrackTypeE.储砖_出:
                    ferrycode = tra.ferry_down_code;
                    break;
                case TrackTypeE.储砖_出入:
                    ferrycode = isdownferry ? tra.ferry_up_code : tra.ferry_down_code;
                    break;
                case TrackTypeE.摆渡车_入:
                case TrackTypeE.摆渡车_出:
                    result = "请重新选择其他轨道";
                    return false;
            }

            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    //查看是否有小车正在上摆渡车
                    FerryTask task = DevList.Find(c => c.ID == ferryid);

                    if (!IsAllowToMove(task, trackid, out result))
                    {
                        task.DoStop();
                        return false;
                    }

                    // 避让不让发指令
                    if (ExistsAvoid(task, trackid, out result, false))
                    {
                        mlog.Info(true, string.Format(@"定位车【{0}】,存在避让【{1}】", task.Device.name, result));
                        return false;
                    }

                    task.DoLocate(ferrycode, trackid);
                    mlog.Info(true, string.Format(@"定位车【{0}】, PC手动", task.Device.name));
                    return true;
                }
                finally
                {
                    Monitor.Exit(_obj);
                }
            }
            result = "稍后再试！";
            return false;
        }

        /// <summary>
        /// 终止摆渡车
        /// </summary>
        /// <param name="trackid"></param>
        internal void StopFerryByFerryTrackId(uint trackid)
        {
            uint ferryid = PubMaster.Device.GetFerryIdByFerryTrackId(trackid);
            if (ferryid > 0)
            {
                StopFerry(ferryid, out string _);
            }
        }

        public bool SetFerryPos(uint id, ushort ferry_code, int intpos, out string result)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                result = "稍后再试！";
                return false;
            }
            try
            {
                FerryTask task = DevList.Find(c => c.ID == id);
                if (!CheckFerryStatus(task, out result))
                {
                    return false;
                }
                task.DoSiteUpdate(ferry_code, intpos);
                //_FerrySiteCode = ferry_code;
                return true;
            }
            finally
            {
                Monitor.Exit(_obj);
            }
        }

        public bool ReSetFerry(uint id, DevFerryResetPosE resettype, out string result)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                result = "稍后再试！";
                return false;
            }
            try
            {
                FerryTask task = DevList.Find(c => c.ID == id);
                if (!CheckFerryStatus(task, out result))
                {
                    return false;
                }
                task.DoReSet(resettype);
                return true;
            }
            finally
            {
                Monitor.Exit(_obj);
            }
        }

        /// <summary>
        /// 定位摆渡车
        /// </summary>
        /// <param name="ferryid">摆渡车ID</param>
        /// <param name="to_track_id">定位轨道ID</param>
        /// <param name="result">结果</param>
        /// <returns></returns>
        internal bool DoLocateFerry(uint ferryid, uint to_track_id, out string result)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                result = "稍后再试！";
                return false;
            }
            try
            {
                FerryTask task = DevList.Find(c => c.ID == ferryid);
                if (!IsAllowToMove(task, to_track_id, out result))
                {
                    return false;
                }

                if (task.IsNotDoingTask)
                {
                    if (task.DevStatus.TargetSite != 0 && PubMaster.Track.GetTrackId(task.DevStatus.TargetSite) != to_track_id)
                    {
                        Thread.Sleep(1000);
                        task.DoStop();
                        result = "消除残留目标点！";
                        return false;
                    }

                    //上砖测轨道ID 或 下砖测轨道ID
                    if (task.UpTrackId == to_track_id && task.IsUpLight)
                    {
                        if (task.DevStatus.CurrentTask == DevFerryTaskE.终止)
                        {
                            return true;
                        }
                        else
                        {
                            Thread.Sleep(1000);
                            result = "到位执行终止！";
                            task.DoStop();
                        }

                        return false;
                    }
                    
                    if (task.DownTrackId == to_track_id && task.IsDownLight)
                    {
                        if (task.DevStatus.CurrentTask == DevFerryTaskE.终止)
                        {
                            return true;
                        }
                        else
                        {
                            Thread.Sleep(1000);
                            result = "到位执行终止！";
                            task.DoStop();
                        }

                        return false;
                    }

                    #region 交管 
                    if (ExistsAvoid(task, to_track_id, out result))
                    {
                        mlog.Info(true, string.Format(@"定位车【{0}】,存在避让【{1}】", task.Device.name, result));
                        return false;
                    }
                    mlog.Info(true, string.Format(@"定位车【{0}】,不需避让【{1}】", task.Device.name, result));
                    #endregion

                    #region // 定位前检查同轨道的摆渡车 - 停用

                    //List<AreaDevice> areatras = PubMaster.Area.GetAreaDevList(task.AreaId, task.Type);
                    ////List<AreaDevice> areatras = PubMaster.Area.GetAreaDevListWithType(task.Type);
                    //uint taskTrackId;
                    //short trackOrder;
                    //short takeTrackOrder = PubMaster.Track.GetTrack(to_track_id)?.order ?? 0;
                    //int safedis = PubMaster.Dic.GetDtlIntCode("FerryAvoidNumber");
                    //foreach (AreaDevice ferry in areatras)
                    //{
                    //    if (ferry.device_id != ferryid)
                    //    {

                    //        //同区域另一台摆渡车
                    //        FerryTask taskB = DevList.Find(c => c.ID == ferry.device_id);
                    //        if (!CheckFerryStatus(taskB, out string r))
                    //        {
                    //            continue;
                    //        }

                    //        //另一台摆渡车对着的轨道id
                    //        uint taskBTrackId = taskB.GetFerryCurrentTrackId();

                    //        short trackBOrder = PubMaster.Track.GetTrack(taskBTrackId)?.order ?? 0;

                    //        //另一台摆渡车的目的轨道的顺序
                    //        short taskBTargetOrder = PubMaster.Track.GetTrackByCode(taskB.DevStatus.TargetSite)?.order ?? 0;

                    //        //当前摆渡车对着的轨道id
                    //        taskTrackId = task.GetFerryCurrentTrackId();

                    //        //当前摆渡车对着的轨道的顺序
                    //        trackOrder = PubMaster.Track.GetTrack(taskTrackId)?.order ?? 0;

                    //        if (trackBOrder == 0 || trackOrder == 0)
                    //        {
                    //            return false;
                    //        }

                    //        int leftCompare, rightCompare;
                    //        if (trackOrder >= takeTrackOrder)
                    //        {
                    //            leftCompare = takeTrackOrder - safedis;
                    //            rightCompare = trackOrder + safedis;
                    //        }
                    //        else
                    //        {
                    //            leftCompare = trackOrder - safedis;
                    //            rightCompare = takeTrackOrder + safedis;
                    //        }
                    //        leftCompare = leftCompare < 0 ? 0 : leftCompare;
                    //        switch (taskB.Status)
                    //        {
                    //            case DevFerryStatusE.停止:
                    //                //当前摆渡车要前进
                    //                if ((leftCompare < trackBOrder && trackBOrder < rightCompare)
                    //                       || (leftCompare < taskBTargetOrder && taskBTargetOrder < rightCompare))
                    //                {
                    //                    if (taskB.IsFerryLock())
                    //                    {
                    //                        return false;
                    //                    }
                    //                    uint avoidTrackId;
                    //                    if (trackOrder < takeTrackOrder)
                    //                    {
                    //                        avoidTrackId = PubMaster.Track.GetTrackIdByDifference(to_track_id, safedis, true);
                    //                    }
                    //                    else
                    //                    {
                    //                        avoidTrackId = PubMaster.Track.GetTrackIdByDifference(to_track_id, safedis, false);
                    //                    }
                    //                    if (PubMaster.Track.GetTrackFerryCode(avoidTrackId, task.Type, out ushort newtrackferrycode, out result))
                    //                    {
                    //                        taskB.DoLocate(newtrackferrycode);
                    //                        return false;
                    //                    }
                    //                }
                    //                break;
                    //            case DevFerryStatusE.前进:
                    //            case DevFerryStatusE.后退:
                    //                //当前摆渡车在另一台摆渡车的后面
                    //                if ((leftCompare < trackBOrder && trackBOrder < rightCompare)
                    //                       || (leftCompare < taskBTargetOrder && taskBTargetOrder < rightCompare))
                    //                {
                    //                    return false;
                    //                }
                    //                break;
                    //            default:
                    //                return false;
                    //        }

                    //    }
                    //}

                    #endregion

                    if (PubMaster.Track.GetTrackFerryCode(to_track_id, task.Type, out ushort trackferrycode, out result))
                    {
                        task.DoLocate(trackferrycode, to_track_id);
                    }
                }
            }
            finally
            {
                Monitor.Exit(_obj);
            }

            return false;
        }

        internal bool UnlockFerry(StockTrans trans, uint ferryid)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                return false;
            }
            try
            {
                FerryTask task = DevList.Find(c => c.ID == ferryid);
                if(task != null)
                {
                    task.SetFerryUnlock(trans.id);
                }
                return true;
            }
            finally
            {
                Monitor.Exit(_obj);
            }
        }

        /// <summary>
        /// 是否存在避让
        /// </summary>
        public bool ExistsAvoid(FerryTask task, uint to_track_id, out string msg, bool isAdd = true)
        {
            // 确认是否已被交管
            if (PubTask.TrafficControl.ExistsRestricted(task.ID))
            {
                msg = "被交管中";
                return true;
            }

            // 同区域内其他同类型的摆渡车
            List<FerryTask> ferries = DevList.FindAll(c => c.AreaId == task.AreaId && c.Type == task.Type && c.ID != task.ID);
            if (ferries == null || ferries.Count == 0)
            {
                msg = "无车干扰";
                return false;
            }

            // 当前轨道ID
            uint TrackId = task.GetFerryCurrentTrackId();

            #region 失去位置信息
            Track ct = PubMaster.Track.GetTrack(TrackId);
            if (ct == null || TrackId == 0 || TrackId.Equals(0) || TrackId.CompareTo(0) == 0)
            {
                msg = task.Device.name + "：没有当前位置信息";
                return true;
            }

            Track tt = PubMaster.Track.GetTrack(to_track_id);
            if (tt == null || to_track_id == 0 || to_track_id.Equals(0) || to_track_id.CompareTo(0) == 0)
            {
                msg = task.Device.name + "：找不到目的位置信息";
                return true;
            }
            #endregion

            // 当前摆渡车对着的轨道的顺序
            short fromOrder = ct?.order ?? 0;
            // 目的轨道顺序
            short toOrder = tt?.order ?? 0;

            if (fromOrder == 0 || fromOrder.Equals(0) || fromOrder.CompareTo(0) == 0
                || toOrder == 0 || toOrder.Equals(0) || toOrder.CompareTo(0) == 0)
            {
                // 无顺序 不动
                msg = "没有轨道避让顺序";
                return true;
            }

            // 摆渡间安全距离 轨道数
            int safedis = PubMaster.Dic.GetDtlIntCode(DicTag.FerryAvoidNumber);
            // 摆渡轨道最小值（默认相对位置顺序以 1 记起）
            int mindis = PubMaster.Track.GetMinOrder((ushort)task.AreaId, task.Type);
            // 摆渡轨道最大值
            int maxdis = PubMaster.Track.GetMaxOrder((ushort)task.AreaId, task.Type);

            // 当前摆渡车移动区间 
            int limitMin, limitMax, standbyOrder;
            if (fromOrder > toOrder)
            {
                // 后退的安全范围
                limitMin = (toOrder - safedis) < mindis ? mindis : (toOrder - safedis);
                limitMax = fromOrder;
                // 待命点
                standbyOrder = limitMin;
            }
            else
            {
                // 前进的安全范围
                limitMin = fromOrder;
                limitMax = (toOrder + safedis) > maxdis ? maxdis : (toOrder + safedis);
                // 待命点
                standbyOrder = limitMax;
            }

            if (standbyOrder == 0 || standbyOrder.Equals(0) || standbyOrder.CompareTo(0) == 0)
            {
                msg = string.Format("[ {0} ]: 无法得到移动前其他车需避让到的安全待命点", task.Device.name);
                return true;
            }

            //循环判断 
            foreach (FerryTask other in ferries)
            {
                // 停用了就不管？
                if (!other.IsWorking && !other.IsEnable) continue;

                // 其一摆渡当前轨道ID
                uint otherTrackId = other.GetFerryCurrentTrackId();

                #region 失去位置信息
                Track ot = PubMaster.Track.GetTrack(otherTrackId);
                if (ot == null || otherTrackId == 0 || otherTrackId.Equals(0) || otherTrackId.CompareTo(0) == 0)
                {
                    msg = other.Device.name + "：没有当前位置信息";
                    return true;
                }
                #endregion

                // 其一摆渡当前轨道顺序
                short otherOrder = ot?.order ?? 0;

                if (otherOrder == 0 || otherOrder.Equals(0) || otherOrder.CompareTo(0) == 0)
                {
                    // 无顺序 不动
                    msg = other.Device.name + "没有当前轨道避让顺序";
                    return true;
                }

                // 其一摆渡目的轨道顺序
                short otherToOrder = PubMaster.Track.GetTrackByCode(other.DevStatus.TargetSite)?.order ?? 0;

                // 使用 记录目标点
                if (otherToOrder == 0 || otherToOrder.Equals(0) || otherToOrder.CompareTo(0) == 0)
                {
                    otherToOrder = PubMaster.Track.GetTrack(other.RecordTraId)?.order ?? 0;
                }

                // 记录
                mlog.Info(true, string.Format(@"定位车[ {0} ]移动[ {1} - {2} ]移序[ {3} - {4} ]安全间距轨道数({5})范围[ {6} ~ {7} ], 同坑内另一车[ {8} ]移序[ {9} - {10} ]",
                    task.Device.name, ct.name, tt.name,
                    fromOrder, toOrder, safedis, limitMin, limitMax,
                    other.Device.name, otherOrder, otherToOrder));

                #region 【交管判断】
                bool isOtherRunning = true; // other车在移动
                if (otherToOrder == 0 || otherToOrder.Equals(0) || otherToOrder.CompareTo(0) == 0) isOtherRunning = false; // other车停止

                // 1. other车的当前位置在安全范围内？
                if (limitMin < otherOrder && otherOrder < limitMax)
                {
                    // 范围内则考虑交管
                    if (isOtherRunning)
                    {
                        // 移动中不能生成交管，跳过
                        msg = string.Format("同坑内另一台车[ {0} ]: 是阻碍并在移动中", other.Device.name);
                        return true;
                    }
                    else
                    {
                        // 确认是否已被同类型交管
                        if (PubTask.TrafficControl.ExistsTrafficControl(TrafficControlTypeE.摆渡车交管摆渡车, other.ID, out uint fid))
                        {
                            msg = string.Format("同坑内另一台车[ {0} ]: 已与[ {1} ]交管",
                                 other.Device.name, PubMaster.Device.GetDeviceName(fid));
                            return true;
                        }

                        // 安全待命点不变
                        if (standbyOrder == otherOrder)
                        {
                            msg = string.Format("同坑内另一台车[ {0} ]: 已到位安全待命点", other.Device.name);
                            return true;
                        }

                        // 没有移动则生成交管
                        if (isAdd)
                        {
                            uint standbyTraID = PubMaster.Track.GetTrackIDByOrder((ushort)other.AreaId, standbyOrder);
                            // 加入交管
                            PubTask.TrafficControl.AddTrafficControl(new TrafficControl()
                            {
                                area = (ushort)task.AreaId,
                                TrafficControlType = TrafficControlTypeE.摆渡车交管摆渡车,
                                restricted_id = task.ID,
                                control_id = other.ID,
                                from_track_id = otherTrackId,
                                to_track_id = standbyTraID
                            }, out msg);
                            return true; // 限制仅生成一个交管
                        }
                        else
                        {
                            // 只提示，不加入交管
                            msg = string.Format("同坑内另一台车[ {0} ]: 是阻碍", other.Device.name);
                            return true;
                        }
                    }
                }
                // 2. 移动中的other车，目的位置在安全范围内？
                else
                {
                    if (isOtherRunning && limitMin < otherToOrder && otherToOrder < limitMax)
                    {
                        // 移动中不能生成交管，跳过
                        msg = string.Format("同坑内另一台车[ {0} ]: 是阻碍并在移动中", other.Device.name);
                        return true;
                    }
                }
                #endregion

            }
            msg = "无检测到避让";
            return false;
        }

        #endregion

        #region[发送信息]
        private void MsgSend(FerryTask task, DevFerry ferry)
        {
            if (Monitor.TryEnter(_objmsg, TimeSpan.FromSeconds(5)))
            {
                try
                {
                    mMsg.ID = task.ID;
                    mMsg.Name = task.Device.name;
                    mMsg.o1 = ferry;
                    mMsg.o2 = task.ConnStatus;
                    Messenger.Default.Send(mMsg, MsgToken.FerryStatusUpdate);
                }
                finally
                {
                    Monitor.Exit(_objmsg);
                }
            }
        }

        private void PosMsgSend(FerryTask task, DevFerrySite site)
        {
            mMsg.ID = task.ID;
            mMsg.Name = task.Device.name;
            mMsg.o1 = site;
            Messenger.Default.Send(mMsg, MsgToken.FerrySiteUpdate);
        }

        private void PosMsgSend(FerryTask task, DevFerry ferry)
        {
            mMsg.ID = task.ID;
            mMsg.Name = task.Device.name;
            mMsg.o1 = ferry;
            Messenger.Default.Send(mMsg, MsgToken.FerrySiteUpdate);
        }

        //对位的光电状态
        private void RfPosMsgSend(FerryPosSet set, DevFerry ferry)
        {
            if(!PubTask.Rf.SendFerryLightPos(set.MEID, ferry.UpSite, ferry.DownSite, ferry.UpLight, ferry.DownLight) 
                && mTimer.IsOver(TimerTag.RfFerrySiteUpdateSendOffline, ferry.DeviceID, 60))
            {
                StopRfPosSet(set.MEID);
            }
        }

        private void RfPosSiteMsgSend(FerryPosSet set, uint devid, DevFerrySite site)
        {
            if (site.TrackCode !=0  //&& site.TrackPos != 0
                )
            {
                PubMaster.Track.UpdateFerryPos(devid, site.TrackCode, site.TrackPos);
                //PubTask.Rf.SendFerryPos(devid, set.IP);

                if (!PubTask.Rf.SendSucc2Rf(set.MEID, FunTag.UpdateFerryPos, "ok")
                    && mTimer.IsOver(TimerTag.RfFerrySiteUpdateSendOffline, devid, 60, 10))
                {
                    StopRfPosSet(set.MEID);
                }
            }
            PubTask.Rf.SendFerrySitePos(set.MEID,devid, site);
        }

        #endregion

        #region[摆渡对位]

        public void StartFerryPosSetting(uint id, ushort code)
        {
            StopFerryPosSetting();
            if (!_FerryPosSetList.Exists(c=>c.FerryId == id && !c.IsRF))
            {
                FerryPosSet set = new FerryPosSet();
                set.FerryId = id;
                set.IsRF = false;
                set.QueryPos = code;
                _FerryPosSetList.Add(set);
            }
            _IsSetting = true;
        }

        public void StopFerryPosSetting()
        {
            _FerryPosSetList.RemoveAll(c => !c.IsRF);
            _IsSetting = _FerryPosSetList.Count != 0;
        }

        public void StartRfPosSet(string meid, uint ferryid)
        {
            FerryPosSet set = _FerryPosSetList.Find(c => meid.Equals(c.MEID));
            if (set == null)
            {
                set = new FerryPosSet();
                set.FerryId = ferryid;
                set.IsRF = true;
                set.MEID = meid;
                _FerryPosSetList.Add(set);
            }
            else
            {
                set.FerryId = ferryid;
            }
            _IsSetting = true;
        }

        public void StopRfPosSet(string meid)
        {
            _FerryPosSetList.RemoveAll(c => meid.Equals(c.MEID));
            _IsSetting = _FerryPosSetList.Count != 0;
        }

        #endregion

        #region[分配-摆渡车]

        /// <summary>
        /// 根据交易信息分配摆渡车
        /// 1.取货轨道是否有车
        /// 2.卸货轨道是否有车
        /// 3.摆渡车上是否有车
        /// 4.根据上下砖机轨道优先级逐轨道是否有车
        /// 5.对面储砖区域(上下砖机轨道对应的兄弟轨道是否有车)
        /// 6.对面区域摆渡车是否有车
        /// 7.对面砖机轨道是否有车
        /// </summary>
        /// <param name="trans"></param>
        /// <param name="ferrytype"></param>
        /// <param name="priortrackid"></param>
        /// <param name="ferryid"></param>
        /// <param name="result"></param>
        /// <param name="carTraid"> 倒库车当前位置 </param>
        /// <returns></returns>
        public bool AllocateFerry(StockTrans trans, DeviceTypeE ferrytype, uint priortrackid, out uint ferryid, out string result)
        {
            result = "";
            ferryid = 0;
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                try
                {

                    //3.1获取能到达[取货/卸货]轨道的摆渡车的ID
                    List<uint> ferryids;
                    Track carrierTrack = PubTask.Carrier.GetCarrierTrack(trans.carrier_id);
                    bool isCarInFerry = false;
                    if (carrierTrack.Type == enums.track.TrackTypeE.摆渡车_入 || carrierTrack.Type == enums.track.TrackTypeE.摆渡车_出)
                    {
                        isCarInFerry = true;
                    }

                    if (trans.TransType == TransTypeE.倒库)
                    {
                        ferryids = PubMaster.Area.GetFerryWithTrackInOut(ferrytype, trans.area_id, 0, trans.give_track_id, isCarInFerry ? 0 : carrierTrack.id, false);
                    }
                    else
                    {
                        ferryids = PubMaster.Area.GetFerryWithTrackInOut(ferrytype, trans.area_id, trans.take_track_id, trans.give_track_id, isCarInFerry ? 0 : carrierTrack.id, false);
                    }

                    //3.2摆渡车上是否有车[空闲，无货]
                    List<FerryTask> ferrys = DevList.FindAll(c => ferryids.Contains(c.ID));

                    if (isCarInFerry)
                    {
                        ferryid = DevList.Find(c => c.LeftTrackId == carrierTrack.id)?.ID ?? 0;
                        return true;
                    }

                    short carrierTrackOrder = carrierTrack.order;

                    if (ferrys.Count > 0)
                    {
                        int safedis = PubMaster.Dic.GetDtlIntCode("FerryAvoidNumber");
                        //判断是否存在有摆渡车已被锁
                        if (ferrys.Exists(c => c.IsFerryLock()) && ferrys.Exists(c => !c.IsFerryLock()))
                        {
                            List<FerryTask> ferryLockeds = ferrys.FindAll(c => c.IsFerryLock());
                            List<FerryTask> ferryUnLockeds = ferrys.FindAll(c => !c.IsFerryLock());

                            foreach (FerryTask fUnLocked in ferryUnLockeds)
                            {
                                if (CheckFerryStatus(fUnLocked) && (fUnLocked.IsStillLockInTrans(trans.id) || fUnLocked.IsFerryFree()))
                                {
                                    //摆渡车所对着的轨道id
                                    //uint taskUnLockedTrackId = ferrytype == DeviceTypeE.上摆渡 ? fUnLocked.DownTrackId : fUnLocked.UpTrackId;
                                    uint taskUnLockedTrackId = fUnLocked.GetFerryCurrentTrackId();

                                    //摆渡车的当前轨道的顺序
                                    short taskUnLockedCurrentOrder = PubMaster.Track.GetTrack(taskUnLockedTrackId)?.order ?? 0;

                                    int leftCompare, rightCompare;
                                    if (taskUnLockedCurrentOrder >= carrierTrackOrder)
                                    {
                                        leftCompare = carrierTrackOrder - safedis;
                                        rightCompare = taskUnLockedCurrentOrder + safedis;
                                    }
                                    else
                                    {
                                        leftCompare = taskUnLockedCurrentOrder - safedis;
                                        rightCompare = carrierTrackOrder + safedis;
                                    }
                                    leftCompare = leftCompare < 0 ? 0 : leftCompare;
                                    bool isChosen = true;
                                    foreach (FerryTask fLocked in ferryLockeds)
                                    {
                                        if (!CheckFerryStatus(fLocked, out string r))
                                        {
                                            continue;
                                        }

                                        if (CheckFerryStatus(fLocked) && fLocked.IsStillLockInTrans(trans.id))
                                        {
                                            ferryid = fLocked.ID;
                                            return true;
                                        }
                                        //上锁摆渡车所对着的轨道id
                                        //uint taskLockedTrackId = ferrytype == DeviceTypeE.上摆渡 ? fLocked.DownTrackId : fLocked.UpTrackId;
                                        uint taskLockedTrackId = fLocked.GetFerryCurrentTrackId();

                                        //上锁摆渡车的当前轨道的顺序
                                        short taskLockedCurrentOrder = PubMaster.Track.GetTrack(taskLockedTrackId)?.order ?? 0;

                                        //上锁摆渡车的目的轨道的位置顺序
                                        short taskLockedTargetOrder = PubMaster.Track.GetTrackByCode(fLocked.DevStatus.TargetSite)?.order ?? 0;

                                        if ((leftCompare < taskLockedCurrentOrder && taskLockedCurrentOrder < rightCompare)
                                               || (leftCompare < taskLockedTargetOrder && taskLockedTargetOrder < rightCompare))
                                        {
                                            isChosen = false;
                                            break;
                                        }
                                    }
                                    if (isChosen)
                                    {
                                        ferryid = fUnLocked.ID;
                                        return true;
                                    }
                                }
                                return false;
                            }
                        }

                        long distance = 999;
                        //如何判断哪个摆渡车最好储砖
                        foreach (FerryTask ferry in ferrys)
                        {
                            if (CheckFerryStatus(ferry) && (ferry.IsStillLockInTrans(trans.id) || ferry.IsFerryFree()))
                            {
                                // 摆渡车对应轨道号
                                Track ferryTrack = PubMaster.Track.GetTrack(ferry.GetFerryCurrentTrackId());

                                if (ferryTrack == null || ferryTrack.order == 0)
                                {
                                    continue;

                                }
                                //摆渡车跟运输车轨道的差绝对值,   数据库 在录入的轨道order时，砖机轨道的顺序是对着的那条储砖轨道的顺序
                                long d = Math.Abs(ferryTrack.order - carrierTrack.order);
                                if (distance > d)
                                {
                                    distance = d;
                                    ferryid = ferry.ID;
                                }
                            }
                        }
                        return ferryid != 0;
                    }
                }
                finally { Monitor.Exit(_obj); }
            }
            return false;
        }


        /// <summary>
        /// 检查摆渡车状态
        /// </summary>
        /// <param name="ferry"></param>
        /// <returns></returns>
        private bool CheckFerryStatus(FerryTask ferry)
        {
            if (ferry.ConnStatus == SocketConnectStatusE.通信正常
                    && ferry.OperateMode == DevOperateModeE.自动
                    && ferry.Status == DevFerryStatusE.停止
                    && ferry.Load == DevFerryLoadE.空)
            {
                return true;
            }

            return false;
        }

        #endregion

        #region[条件判断]

        /// <summary>
        /// 获取通讯且启用的摆渡ID集
        /// </summary>
        /// <param name="ferryids"></param>
        /// <returns></returns>
        public List<uint> GetWorkingAndEnable(List<uint> ferryids)
        {
            return DevList.FindAll(c => c.IsWorking && c.IsEnable && ferryids.Contains(c.ID))?.Select(c => c.ID).ToList();
        }

        private bool CheckFerryStatus(FerryTask task, out string result)
        {
            if (task == null)
            {
                result = "找不到可上的摆渡车";
                return false;
            }

            if (task.ConnStatus != SocketConnectStatusE.通信正常)
            {
                result = "设备未连接";
                return false;
            }

            if(task.OperateMode == DevOperateModeE.手动)
            {
                result = "手动操作中";
                return false;
            }

            result = "";
            return true;
        }

        internal bool IsLoadOrEmpty(FerryTask task, out string result)
        {
            if (task.Load == DevFerryLoadE.未知 || task.Load == DevFerryLoadE.非空)
            {
                result = "摆渡车非空非载车";
                return false;
            }
            result = "";
            return true;
        }

        internal bool IsLoad(uint ferryid)
        {
            return DevList.Exists(c => c.ID == ferryid
                                    && c.ConnStatus == SocketConnectStatusE.通信正常
                                    && c.Load == DevFerryLoadE.载车);
        }

        internal bool IsUnLoad(uint ferryid)
        {
            return DevList.Exists(c => c.ID == ferryid
                                    && c.ConnStatus == SocketConnectStatusE.通信正常
                                    && c.Load == DevFerryLoadE.空);
        }        
        
        internal bool IsStop(uint ferryid)
        {
            return DevList.Exists(c => c.ID == ferryid
                                    && c.ConnStatus == SocketConnectStatusE.通信正常
                                    && c.Status == DevFerryStatusE.停止);
        }

        internal bool IsStopAndSiteOnTrack(uint id, bool isferryupsite, out string result)
        {
            FerryTask task = DevList.Find(c => c.LeftTrackId == id);
            if (task == null)
            {
                result = "找不到设备";
                return false;
            }

            if (!CheckFerryStatus(task, out result))
            {
                return false;
            }

            if (task.Status != DevFerryStatusE.停止)
            {
                result = "摆渡车非停止状态！";
                return false;
            }

            if(isferryupsite && !task.IsUpLight)
            {
                result = "摆渡车上光电未亮！";
                return false;
            }

            if(!isferryupsite && !task.IsDownLight)
            {
                result = "摆渡车下光电未亮！";
                return false;
            }

            result = "";
            return true;
        }

        /// <summary>
        /// 摆渡车是否可移动
        /// </summary>
        public bool IsAllowToMove(FerryTask task, uint totrackid, out string result)
        {
            // 检查摆渡车状态
            if (!CheckFerryStatus(task, out result))
            {
                return false;
            }
            if (!IsLoadOrEmpty(task, out result))
            {
                return false;
            }

            if (task.Type == DeviceTypeE.上摆渡 && !PubMaster.Track.IsUpAreaTrack(totrackid))
            {
                result = string.Format("上摆渡，不能定位到轨道[ {0} ]", PubMaster.Track.GetTrackName(totrackid));
                return false;
            }

            if (task.Type == DeviceTypeE.下摆渡 && !PubMaster.Track.IsDownAreaTrack(totrackid))
            {
                result = string.Format("下摆渡，不能定位到轨道[ {0} ]", PubMaster.Track.GetTrackName(totrackid));
                return false;
            }

            // 检查是否存在目的位置移动
            if (task.RecordTraId > 0 && task.RecordTraId != totrackid)
            {
                result = string.Format("摆渡车正移至[ {0} ]，等待到位完成或执行终止",
                    PubMaster.Track.GetTrackName(task.RecordTraId));
                return false;
            }

            //检查摆渡车对应的轨道，是否有运输车正在执行【上摆渡车的任务】 20210127
            if (task.IsUpLight
                && PubTask.Carrier.HaveCarrierTaskInTrack(task.UpTrackId, DevCarrierTaskE.后退至摆渡车))
            {
                result = "小车正在上摆渡车";
                return false;
            }

            if (task.IsDownLight
                && PubTask.Carrier.HaveCarrierTaskInTrack(task.DownTrackId, DevCarrierTaskE.前进至摆渡车))
            {
                result = "小车正在上摆渡车";
                return false;
            }

            //找摆渡车上的运输车
            //判断运输车是否在动  
            //在动则返回false，不给摆渡车发任务  20210127
            if (task.Load == DevFerryLoadE.载车)
            {
                //在摆渡车轨道上的运输车是否有状态不是停止的或者是手动的
                if (PubTask.Carrier.IsCarrierMoveInTrack(task.LeftTrackId))
                {
                    result = "摆渡车上的运输车在运动/手动状态中/任务没有完成";
                    return false;
                }
            }

            return true;
        }

        #endregion

        #region[启动/停止]

        /// <summary>
        /// 启动/停止摆渡车
        /// </summary>
        /// <param name="ferryid"></param>
        /// <param name="isstart"></param>
        public void StartStopFerry(uint ferryid, bool isstart)
        {
            if (Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                try
                {
                    FerryTask task = DevList.Find(c => c.ID == ferryid);
                    if (task != null)
                    {
                        if (isstart)
                        {
                            if (!task.IsEnable)
                            {
                                task.SetEnableAndWorking(isstart);
                            }
                            task.Start();
                        }
                        else
                        {
                            if (task.IsEnable)
                            {
                                task.SetEnableAndWorking(isstart);
                            }
                            task.Stop();
                            PubMaster.Warn.RemoveDevWarn((ushort)task.ID);
                        }
                    }
                }
                finally { Monitor.Exit(_obj); }
            }

        }

        internal List<FerryTask> GetDevFerrys()
        {
            return DevList;
        }

        internal void UpdateWorking(uint devId, bool working)
        {
            if (!Monitor.TryEnter(_obj, TimeSpan.FromSeconds(2)))
            {
                return;
            }
            try
            {
                FerryTask task = DevList.Find(c => c.ID == devId);
                if (task != null)
                {
                    task.IsWorking = working;
                    MsgSend(task, task.DevStatus);
                }
            }
            finally { Monitor.Exit(_obj); }

        }

        #endregion
    }

    public class FerryPosSet
    {
        public bool IsRF { set; get; }
        public string MEID { set; get; }
        public uint FerryId { set; get; }
        public ushort QueryPos { set; get; } = 201;
    }
}
