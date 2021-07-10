using System;
using System.IO;
using Newtonsoft.Json;

namespace tool.appconfig
{
    public class GlobalWcsDataConfig
    {
        public static void Init()
        {
            #region[数据库配置文件读取/初始化]
            if (File.Exists(MysqlConfig.SavePath))
            {
                try
                {
                    var json = File.ReadAllText(MysqlConfig.SavePath);
                    MysqlConfig = (string.IsNullOrEmpty(json) ? new MysqlConfig() : JsonConvert.DeserializeObject<MysqlConfig>(json)) ?? new MysqlConfig();
                }
                catch
                {
                    MysqlConfig = new MysqlConfig();
                }
            }
            else
            {
                MysqlConfig = new MysqlConfig();
            }
            SaveMysqlConfig();
            #endregion

            #region[报警灯配置信息]

            if (File.Exists(DevLightConfig.SavePath))
            {
                try
                {
                    var json = File.ReadAllText(DevLightConfig.SavePath);
                    AlertLightConfig = (string.IsNullOrEmpty(json) ? new DevLightConfig() : JsonConvert.DeserializeObject<DevLightConfig>(json)) ?? new DevLightConfig();
                }
                catch
                {
                    AlertLightConfig = new DevLightConfig();
                }
            }
            else
            {
                AlertLightConfig = new DevLightConfig();
            }
            SaveAlertLightConfig();

            #endregion

        }

        public static void SaveMysqlConfig()
        {
            SaveJsonObj(MysqlConfig, MysqlConfig.Path, MysqlConfig.SavePath);
        }

        public static void SaveAlertLightConfig()
        {
            SaveJsonObj(AlertLightConfig, DevLightConfig.Path, DevLightConfig.SavePath);
        }

        #region[保存配置文件]
        public static void SaveJsonObj(object obj, string dirpath, string savepath)
        {
            try
            {
                var json = JsonConvert.SerializeObject(obj);
                if (!Directory.Exists(dirpath))
                {
                    Directory.CreateDirectory(dirpath);
                }
                using (FileStream fs = new FileStream(savepath, FileMode.Create, FileAccess.Write, FileShare.ReadWrite))
                {
                    fs.Seek(fs.Length, SeekOrigin.Current);

                    byte[] data = System.Text.Encoding.UTF8.GetBytes(json);

                    fs.Write(data, 0, data.Length);

                    fs.Close();
                }
            }
            catch (Exception)
            {

            }
        }
        #endregion

        public static MysqlConfig MysqlConfig { get; set; }
        public static DevLightConfig AlertLightConfig { get; set; }
    }
}
