using enums;

namespace module.area
{
    public class Area
    {
        public uint id { set; get; }
        public string name { set; get; }
        public bool enable { set; get; }
        public bool devautorun { set; get; }
        public string memo { set; get; }
        public int c_sorttask { set; get; }//倒库数量限制
        public byte carriertype { set; get; }//运输车类型
        public byte full_qty { set; get; }//区域轨道满砖时，轨道库存数未达标警告数

        public CarrierTypeE CarrierType
        {
            get => (CarrierTypeE)carriertype;
            set => carriertype = (byte)value;
        }
    }
}
