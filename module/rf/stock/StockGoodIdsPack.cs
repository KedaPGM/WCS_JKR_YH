using System.Collections.Generic;

namespace module.rf
{
    public class StockGoodIdsPack
    {
        public List<StockGoodPack> GoodIdsList { set; get; }
        public void AddIds(List<StockGoodPack> ids)
        {
            if(GoodIdsList == null)
            {
                GoodIdsList = new List<StockGoodPack>();
            }
            GoodIdsList.AddRange(ids);
        }
    }
}
