﻿using System;

namespace module.goods
{
    public class StockSum
    {
        public uint goods_id { set; get; }
        public uint track_id { set; get; }
        public DateTime? produce_time { set; get; }
        public uint count { set; get; }
        public uint stack { set; get; }
        public uint pieces { set; get; }
        public uint area { set; get; }
        public byte track_type { set; get; }

        public int CompareProduceTime(DateTime? time)
        {
            if(produce_time is DateTime dtime && time is DateTime ctime)
            {
                return dtime.CompareTo(ctime);
            }
            return 0;
        }
    }
}
