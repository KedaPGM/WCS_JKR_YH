﻿using enums;
using module.device;
using socket.tcp;

namespace task.task
{
    public class TileLifterTask : TaskBase
    {
        #region[兄弟砖机]

        /// <summary>
        /// 需要根据兄弟砖机状态才能作业
        /// </summary>
        public bool HaveBrother
        {
            get => Device?.HaveBrother ?? true;
        }

        public uint BrotherId
        {
            get => Device.brother_dev_id;
        }

        public bool IsTwoTrack
        {
            get => Device.Type2 == DeviceType2E.双轨;
        }

        public StrategyInE InStrategy
        {
            get => Device?.InStrategey ?? StrategyInE.同机同轨;
            set => Device.InStrategey = value;
        }

        public StrategyOutE OutStrategy
        {
            get => Device?.OutStrategey ?? StrategyOutE.同规同轨;
            set => Device.OutStrategey = value;
        }

        #endregion

        #region[属性]

        public bool IsNeed_1
        {
            get => DevStatus?.Need1 ?? false;
        }

        public bool IsNeed_2
        {
            get => DevStatus?.Need2 ?? false;
        }

        public bool IsLoad_1
        {
            get => DevStatus?.Load1 ?? false;
        }

        public bool IsEmpty_1
        {
            get => !DevStatus?.Load1 ?? false;
        }

        public bool IsLoad_2
        {
            get => DevStatus?.Load2 ?? false;
        }
        public bool IsEmpty_2
        {
            get => !DevStatus?.Load2 ?? false;
        }

        public bool IsInvo_1
        {
            get => DevStatus?.Involve1 ?? false;
        }
        
        public bool IsInvo_2
        {
            get => DevStatus?.Involve2 ?? false;
        }

        public byte FullQty
        {
            get => DevStatus?.FullQty ?? 66;
        }

        public bool InInvoStatus
        {
            get => IsNeed_1 || IsNeed_2;
        }

        public bool StopOneTime { set; get; }

        #endregion

        #region[下砖/上砖策略]

        /// <summary>
        /// 入库策略
        /// </summary>
        public StrategyInE StrategyIn
        {
            get => Device.InStrategey;
            set => Device.InStrategey = value;
        }

        /// <summary>
        /// 出库策略
        /// </summary>
        public StrategyOutE StrategyOut
        {
            get => Device.OutStrategey;
            set => Device.OutStrategey = value;
        }

        public DevWorkTypeE WorkType
        {
            get => Device.WorkType;
            set => Device.WorkType = value;
        }

        #endregion

        #region[构造/启动/停止]
        public TileLifterTcp DevTcp { set; get; }
        public DevTileLifter DevStatus { set; get; }

        public TileLifterTask() : base()
        {
            DevStatus = new DevTileLifter();
        }

        public void Start()
        {
            if (!IsEnable) return;

            if (DevTcp == null)
            {
                DevTcp = new TileLifterTcp(Device);
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

        #region[发送指令]

        internal void DoQuery()
        {
            DevTcp?.SendCmd(DevLifterCmdTypeE.查询, 0);
        }

        internal void Do1Invo(DevLifterInvolE invo)
        {
            DevTcp?.SendCmd(DevLifterCmdTypeE.介入1, (byte)invo);
        }

        internal void Do2Invo(DevLifterInvolE invo)
        {
            DevTcp?.SendCmd(DevLifterCmdTypeE.介入2, (byte)invo);
        }

        internal void SetInTaskStatus(bool status)
        {
            DevTcp.IsInTaskStatus = status;
        }
        #endregion
    }
}
