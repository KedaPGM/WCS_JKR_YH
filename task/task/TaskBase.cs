using enums;
using module.device;
using resource;
using System;
using tool.timer;

namespace task.task
{
    public abstract class TaskBase
    {
        #region[字段]
        public uint AreaId
        {
            get => Device.area;
        }

        public DeviceTypeE Type
        {
            get => Device?.Type ?? DeviceTypeE.其他;
        }

        public uint ID
        {
            get => Device?.id ?? 0;
        }

        public bool IsEnable
        {
            get => Device?.enable ?? false;
        }

        public bool IsWorking
        {
            get => Device?.do_work ?? false;
            set => Device.do_work = value;
        }

        public uint GoodsId
        {
            get => Device?.goods_id ?? 0;
        }

        /// <summary>
        /// [单轨/双轨]上下砖机左侧轨道ID
        /// </summary>
        public uint LeftTrackId
        {
            get => Device?.left_track_id ?? 0;
        }

        /// <summary>
        /// [双轨]上下砖机右侧轨道ID
        /// </summary>
        public uint RigthTrackId
        {
            get => Device?.right_track_id ?? 0;
        }

        public Device Device { set; get; }
        private SocketConnectStatusE mconn;
        internal bool MConChange;
        public MTimer mTimer;
        public SocketConnectStatusE ConnStatus
        {
            get => mconn;
            set
            {
                MConChange = value != mconn;
                mconn = value;
            }
        
        }
        /// <summary>
        /// 设备通讯刷新时间
        /// </summary>
        private DateTime SockRefreshTime { set; get;  }
        private bool HaveRefreshToSurface { set; get; }
        #endregion

        public TaskBase()
        {
            mTimer = new MTimer();
        }


        internal void SetEnable(bool isenable)
        {
            Device.enable = isenable;
            PubMaster.Device.SetEnable(Device.id, isenable);
        }

        internal void SetEnableAndWorking(bool isenable)
        {
            Device.enable = isenable;
            Device.do_work = isenable;
            PubMaster.Device.SetEnable(Device.id, isenable);
            PubMaster.Device.SetDevWorking(Device.id, isenable, out DeviceTypeE type);
        }
    }
}
