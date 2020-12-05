﻿using enums;
using module.device;
using System.Runtime.InteropServices;

namespace socket.process
{
    #region[接收状态]

    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct TileStatusStruct
    {
        public ushort Head; //命令字头【0x91,0x01】
        public byte DeviceID;      //设备号
        public byte LoadStatus1;   //货物状态1 左
        public byte LoadStatus2;   //货物状态2 右
        public byte NeedStatus1;   //需求信号1 左
        public byte NeedStatus2;   //需求信号2 右
        public byte FullQty;       //满砖数量
        public byte RecentQty;     //当前数量
        public byte Involve1;      //介入状态1 左
        public byte Involve2;      //介入状态2 右
        public byte OperateMode;   //作业模式
        public ushort Tail; //命令字尾【0xFF,0xFE】
    }

    #endregion

    #region[命令发送]

    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct TileCmdStruct
    {
        public ushort Head; //命令字头【0x90,0x01】
        public byte DeviceID;      //设备号
        public byte Command;        //故障位1
        public byte Value;        //故障位2
        public ushort Tail; //命令字尾【0xFF,0xFE】
    }

    #endregion

    public class TileLifterProcesser : ProcesserBase
    {
        #region[字段]
        DevTileLifter mDev;
        #endregion

        public TileLifterProcesser()
        {
            mDev = new DevTileLifter();
        }

        internal DevTileLifter GetStatus(byte[] data)
        {
            TileStatusStruct st = BufferToStruct<TileStatusStruct>(data);

            mDev.ReSetUpdate();
            mDev.DeviceID = st.DeviceID;
            mDev.Load1 = st.LoadStatus1 == 1;
            mDev.Load2 = st.LoadStatus2 == 1;
            mDev.Need1 = st.NeedStatus1 == 1;
            mDev.Need2 = st.NeedStatus2 == 1;
            mDev.FullQty = st.FullQty;
            mDev.RecentQty = st.RecentQty;
            mDev.Involve1 = st.Involve1 == 1;
            mDev.Involve2 = st.Involve2 == 1;
            mDev.OperateMode = (DevOperateModeE)st.OperateMode;

            return mDev;
        }

        internal byte[] GetCmd(string devid, DevLifterCmdTypeE type, byte value)
        {
            TileCmdStruct cmd = new TileCmdStruct();
            cmd.Head = ShiftBytes(SocketConst.TILELIFTER_CMD_HEAD_KEY);
            cmd.DeviceID = byte.Parse(devid);
            cmd.Command = (byte)type;
            cmd.Value = value;
            cmd.Tail = ShiftBytes(SocketConst.TAIL_KEY);

            return StructToBuffer(cmd);
        }
    }
}
