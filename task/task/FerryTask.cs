﻿using enums;
using module.device;
using resource;
using socket.tcp;
using System;

namespace task.task
{
    public class FerryTask : TaskBase
    {
        #region[逻辑属性]

        public bool IsLock { set; get; }
        public uint TransId { set; get; }
        public DateTime? LockRefreshTime { set; get; }

        #endregion

        #region[属性]
        public DevFerryStatusE Status
        {
            get => DevStatus?.DeviceStatus ?? DevFerryStatusE.设备故障;
        }
        public DevOperateModeE OperateMode//操作模式
        {
            get => DevStatus?.WorkMode ?? DevOperateModeE.无;
        }
        public DevFerryLoadE Load
        {
            get => DevStatus?.LoadStatus ?? DevFerryLoadE.未知;
        }
        public bool IsDownLight
        {
            get => DevStatus?.DownLight ?? false;
        }
        public bool IsUpLight
        {
            get => DevStatus?.UpLight ?? false;
        }
        public ushort UpSite
        {
            get => DevStatus?.UpSite ?? 0;
        }
        public ushort DownSite
        {
            get => DevStatus?.DownSite ?? 0;
        }
        public uint UpTrackId { set; get; }
        public uint DownTrackId { set; get; }

        #endregion

        #region[构造/启动/停止]

        public FerryTcp DevTcp { set; get; }
        public DevFerry DevStatus { set; get; }
        public DevFerrySite DevSite { set; get; }

        public FerryTask():base()
        {
            DevStatus = new DevFerry();
        }

        public void Start()
        {
            if (!IsEnable) return;

            if (DevTcp == null)
            {
                DevTcp = new FerryTcp(Device);
            }

            if (!DevTcp.m_Working)
            {
                DevTcp.Start();
            }
        }

        public void Stop()
        {
            DevTcp?.Stop();
        }
        #endregion

        #region[判断状态]
        public bool IsOnSite(ushort ferrycode)
        {
            return (UpSite == ferrycode && IsUpLight) || (DownSite == ferrycode && IsDownLight);
        }

        #endregion

        #region[发送指令]
        internal void DoQuery()
        {
            DevTcp?.SendCmd(DevFerryCmdE.查询, 0, 0, 0);
        }

        internal void DoLocate(ushort trackcode)
        {
            byte[] b = BitConverter.GetBytes(trackcode);
            DevTcp?.SendCmd(DevFerryCmdE.定位, b[1], b[0], 0);
        }

        internal void DoSiteQuery(ushort trackcode)
        {
            byte[] b = BitConverter.GetBytes(trackcode);
            DevTcp?.SendCmd(DevFerryCmdE.查询轨道坐标, b[1], b[0], 0);
        }

        internal void DoSiteUpdate(ushort trackcode, int trackpos)
        {
            byte[] b = BitConverter.GetBytes(trackcode);
            DevTcp?.SendCmd(DevFerryCmdE.设置轨道坐标, b[1], b[0], trackpos);
        }

        internal void DoReSet(DevFerryResetPosE resetpos)
        {
            DevTcp?.SendCmd(DevFerryCmdE.原点复位, (byte)resetpos, 0, 0);
        }

        internal void DoStop()
        {
            DevTcp?.SendCmd(DevFerryCmdE.终止任务, 0, 0, 0);
        }


        #endregion

        #region[更新轨道信息]

        internal void UpdateInfo()
        {
            if (UpSite == 0)
            {
                UpTrackId = 0;
            }

            if (UpSite != 0 && (DevStatus?.IsUpSiteChange ?? false))
            {
                UpTrackId = PubMaster.Track.GetTrackId(UpSite);
            }

            if(DownSite == 0)
            {
                DownTrackId = 0;
            }

            if (DownSite != 0 && (DevStatus?.IsDownSiteChange ?? false))
            {
                DownTrackId = PubMaster.Track.GetTrackId(DownSite);
            }
        }
        #endregion

        #region[锁定摆渡车]

        /// <summary>
        /// 摆渡车是否空闲
        /// </summary>
        /// <returns></returns>
        public bool IsFerryFree()
        {
            if (Load == DevFerryLoadE.载车)
            {
                return false;
            }

            if(TransId == 0 && !IsLock)
            {
                return true;
            }

            if (IsLockOverTime() && IsLock)
            {
                IsLock = false;
                TransId = 0;
                return true;
            }

            return false;
        }

        /// <summary>
        /// 继续锁定摆渡车
        /// </summary>
        /// <param name="transid"></param>
        public bool IsStillLockInTrans(uint transid)
        {
            if(IsLock && TransId == transid)
            {
                LockRefreshTime = DateTime.Now;
                return true;
            }
            return false;
        }

        /// <summary>
        /// 解锁摆渡车
        /// </summary>
        /// <param name="transid"></param>
        public void SetFerryUnlock(uint transid)
        {
            if (IsLock && TransId == transid)
            {
                TransId = 0;
                IsLock = false;
            }
        }

        /// <summary>
        /// 摆渡车是否被锁定
        /// </summary>
        /// <returns></returns>
        public bool IsFerryLock()
        {
            if(Load == DevFerryLoadE.载车)
            {
                return true;
            }
            
            if(IsLockOverTime() || TransId == 0)
            {
                return false;
            }

            return true;
        }

        internal void SetFerryLock(uint id)
        {
            TransId = id;
            IsLock = true;
            LockRefreshTime = DateTime.Now;
        }

        /// <summary>
        /// 是否锁定超时
        /// </summary>
        /// <returns></returns>
        public bool IsLockOverTime()
        {
            if(LockRefreshTime is null)
            {
                LockRefreshTime = DateTime.Now;
            }

            if (LockRefreshTime is DateTime time && (DateTime.Now - time).TotalSeconds > 20)
            {
                return true;
            }

            return false;
        }

        #endregion

        #region  获取属性

        internal uint GetFerryCurrentTrackId()
        {
            uint trackId = 0;
            switch (Type)
            {
                case DeviceTypeE.上摆渡:
                    trackId = IsUpLight ? UpTrackId : DownTrackId;
                    break;
                case DeviceTypeE.下摆渡:
                    trackId = IsDownLight ? DownTrackId : UpTrackId;
                    break;
                default:
                    break;
            }
            return trackId;
        }

        #endregion

    }
}
