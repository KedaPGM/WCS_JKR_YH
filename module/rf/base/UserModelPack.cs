using System.Collections.Generic;

namespace module.rf
{
    public class UserModelPack
    {
        public string UserId { set; get; }
        public string UserName { set; get; }
        public List<ModuleView> UserModuleView { set; get; }
    }
}
