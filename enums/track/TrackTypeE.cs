﻿namespace enums.track
{
    /// <summary>
    /// 轨道类型
    /// </summary>
    public enum TrackTypeE
    {
        上砖轨道,
        下砖轨道,
        储砖_入,
        储砖_出,
        储砖_出入,
        摆渡车_入,
        摆渡车_出
    }


    /// <summary>
    /// 轨道类型
    /// </summary>
    public enum RfFilterTrackTypeE
    {
        入库轨道 = 2,
        出库轨道,
        出入轨道,
    }

    public enum TrackStockStatusE
    {
        空砖,
        有砖,
        满砖,
    }

    public enum TrackStatusE
    {
        停用,
        启用,
        倒库中,
    }

    public enum TrackUpdateE
    {
        StockStatus,
        TrackStatus,
        Common,
        Size,
        Ferry,
        Track,
        RfId,
        Order,
        RecentGoodId,
        RecentTileId,
        Alert,
        EarlyFull,
    }

    public enum TrackAlertE
    {
        正常,
        小车读点故障,
    }

    public enum TrackLogE
    {
        空轨道 = 1,
        满轨道= 2
    }
}
