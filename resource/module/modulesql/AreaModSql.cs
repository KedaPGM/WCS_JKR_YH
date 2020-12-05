﻿using module.area;
using System.Collections.Generic;
using System.Data;
using tool;
using tool.mysql.extend;

namespace resource.module.modulesql
{
    public class AreaModSql : BaseModSql
    {
        public AreaModSql(MySql sql) : base(sql)
        {
        }

        #region[查询]

        public List<Area> QueryAreaList()
        {
            List<Area> list = new List<Area>();
            string sql = string.Format("SELECT t.id, t.`name`, t.`enable`, t.devautorun, t.memo," +
                " t.c_sorttask, t.carriertype, t.full_qty FROM area AS t ");
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<Area>();
            }
            return list;
        }

        public List<AreaDevice> QueryAreaDeviceList()
        {
            List<AreaDevice> list = new List<AreaDevice>();
            string sql = string.Format("SELECT t.id, t.area_id, t.device_id, t.dev_type FROM area_device AS t ");
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<AreaDevice>();
            }
            return list;
        }

        public List<AreaTrack> QueryAreaTrackList()
        {
            List<AreaTrack> list = new List<AreaTrack>();
            string sql = string.Format("SELECT t.id, t.area_id, t.track_id, t.track_type FROM area_track AS t ");
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<AreaTrack>();
            }
            return list;
        }
        
        public List<AreaDeviceTrack> QueryAreaDeviceTrackList()
        {
            List<AreaDeviceTrack> list = new List<AreaDeviceTrack>();
            string sql = string.Format("SELECT t.id, t.area_id, t.device_id, t.track_id, t.prior FROM area_device_track AS t  ");
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<AreaDeviceTrack>();
            }
            return list;
        }

        #endregion

        #region[添加]


        internal bool AddArea(Area area)
        {
            string str = "INSERT INTO `area`(`name`, `enable`, `devautorun`, `memo`) VALUES('{0}', {1}, {2}, '{3}')";
            string sql = string.Format(@str, area.name, area.enable, area.devautorun, area.memo);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }
        
        internal bool AddAreaDevice(AreaDevice areadev)
        {
            string str = "INSERT INTO `area_device`(`area_id`, `device_id`, `dev_type`) VALUES('{0}', '{1}', '{2}')";
            string sql = string.Format(@str, areadev.area_id, areadev.device_id, areadev.dev_type);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        internal bool AddAreaTrack(AreaTrack areatra)
        {
            string str = "INSERT INTO `area_track`(`area_id`, `track_id`, `track_type`) VALUES('{0}', '{1}', '{2}')";
            string sql = string.Format(@str, areatra.area_id, areatra.track_id, areatra.track_type);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }
        
        internal bool AddAreaDeviceTrack(AreaDeviceTrack areadevtra)
        {
            string str = "INSERT INTO `area_device_track`(`area_id`, `device_id`, `track_id`, `prior`) VALUES('{0}', '{1}', '{2}', '{3}')";
            string sql = string.Format(@str, areadevtra.area_id, areadevtra.device_id, areadevtra.track_id, areadevtra.prior);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }


        #endregion

        #region[修改]

        internal bool EditArea(Area area)
        {
            string sql = "UPDATE `area` set name = '{0}', `enable` = {1}, `devautorun` = {2}," +
                " `memo` = '{3}', `full_qty` = '{4}' where id = '{5}'";
            sql = string.Format(sql, area.name, area.enable, area.devautorun, area.memo, area.full_qty, area.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        internal bool EditAreaDevice(AreaDevice areadev)
        {
            string sql = "UPDATE `area_device` set area_id = '{0}', `device_id` = {1} where id = '{2}'";
            sql = string.Format(sql, areadev.area_id, areadev.device_id, areadev.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        internal bool EditAreaTrack(AreaTrack areatra)
        {
            string sql = "UPDATE `area_track` set area_id = '{0}', `track_id` = {1} where id = '{2}'";
            sql = string.Format(sql, areatra.area_id, areatra.track_id, areatra.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }
        
        internal bool EditAreaDeviceTrack(AreaDeviceTrack areadevtra)
        {
            string sql = "UPDATE `area_device_track` set area_id = '{0}', `device_id` = {1}, `track_id` = {2} , `prior` = {3} where id = '{4}'";
            sql = string.Format(sql, areadevtra.area_id, areadevtra.device_id, areadevtra.track_id, areadevtra.prior, areadevtra.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        #endregion

        #region[删除]

        internal bool DeleteArea(Area area)
        {
            string sql = string.Format("DELETE FROM `area` where id = '{0}'", area.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }
        internal bool DeleteAreaDevice(AreaDevice areadev)
        {
            string sql = string.Format("DELETE FROM `area_device` where id = '{0}'", areadev.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }
        internal bool DeleteAreaTrack(AreaTrack areatra)
        {
            string sql = string.Format("DELETE FROM `area_track` where id = '{0}'", areatra.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        internal bool DeleteAreaDeviceTrack(AreaDeviceTrack areadevtra)
        {
            string sql = string.Format("DELETE FROM `area_device_track` where id = '{0}'", areadevtra.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        #endregion
    }
}
