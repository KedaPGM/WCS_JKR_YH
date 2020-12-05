﻿using enums.track;
using module;
using module.track;
using System;
using System.Collections.Generic;
using System.Data;
using tool;
using tool.mysql.extend;

namespace resource.module.modulesql
{
    public class TrackModSql : BaseModSql
    {
        public TrackModSql(MySql sql) : base(sql)
        {

        }

        #region[查询]

        public List<Track> QueryTrackList()
        {
            List<Track> list = new List<Track>();
            string sql = string.Format("SELECT t.id, t.`name`, t.area, t.type, t.`stock_status`," +
                " t.`track_status`, t.width, t.left_distance, t.right_distance," +
                " t.ferry_up_code, t.ferry_down_code, t.max_store, t.brother_track_id," +
                " t.left_track_id, t.right_track_id, t.memo," +
                " t.rfid_1, t.rfid_2, t.rfid_3, t.rfid_4, t.rfid_5, t.rfid_6," +
                " t.`order`, t.`recent_goodid`, t.`recent_tileid`, t.`alert_status`, t.`alert_carrier`," +
                " t.`alert_trans`, t.`early_full`, t.`full_time` FROM track AS t ORDER BY t.`order`");
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<Track >();
            }
            return list;
        }

        public List<FerryPos> QueryFerryPosList()
        {
            List<FerryPos> list = new List<FerryPos>();
            string sql = string.Format("SELECT t.id, t.track_id, t.device_id, t.ferry_code, t.ferry_pos FROM ferry_pos AS t  ");
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<FerryPos>();
            }
            return list;
        }

        public List<FerryPos> QueryFerryPosList(uint areaid, uint devid)
        {
            List<FerryPos> list = new List<FerryPos>();
            string sql = string.Format("SELECT t.id, t.track_id, t.device_id, t.ferry_code, t.ferry_pos FROM ferry_pos AS t  " +
                "where t.device_id = {0} and  t.track_id in (select id from track r where r.area = {1}) ", devid, areaid);
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<FerryPos>();
            }
            return list;
        }

        public List<FerryPos> QueryFerryPosList(uint devid)
        {
            List<FerryPos> list = new List<FerryPos>();
            string sql = string.Format("SELECT t.id, t.track_id, t.device_id, t.ferry_code, t.ferry_pos FROM ferry_pos AS t  " +
                "where t.device_id = {0} ", devid);
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<FerryPos>();
            }
            return list;
        }

        public List<TrackLog> QueryTrackLog(int type, uint area, DateTime start, DateTime stop)
        {
            List<TrackLog> list = new List<TrackLog>();
            string sql = string.Format("SELECT t.id, t.track_id, t.type, t.dev_id, t.stock_count, t.log_time, t.memo FROM track_log AS t " +
                "WHERE t.log_time >= '{0}' and t.log_time <= '{1}'", start.ToString(timeformat), stop.ToString(timeformat));
            if (type > 0)
            {
                sql += string.Format(" and `type` = {0}", type);
            }

            if (area > 0)
            {
                sql += string.Format(" and `area` = {0}", area);
            }
            sql += " limit 200";
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<TrackLog>();
            }
            return list;
        }

        #endregion

        #region[添加]


        internal bool AddTrack(Track track)
        {
            string str = "INSERT INTO `track`( `name`, `area`, `type`, `stock_status`, `width`, `left_distance`, `right_distance`," +
                " `ferry_up_code`, `ferry_down_code`, `max_store`, `brother_track_id`, `left_track_id`, `right_track_id`, `memo`," +
                " `rfid_1`, `rfid_2`, `rfid_3`, `rfid_4`, `rfid_5`, `rfid_6`, `order`, `recent_goodid`, `recent_tileid`) " +
                "VALUES('{0}', '{1}', '{2}', '{3}', {4}, '{5}', '{6}', '{7}', '{8}', '{9}', '{10}', '{11}', '{12}', '{13}', " +
                "'{14}', '{15}', '{16}', '{17}', '{18}', '{19}', '{20}', '{21}', '{22}')";
            string sql = string.Format(@str, track.name, track.area, track.type, track.stock_status, track.width, track.left_distance, track.right_distance,
                track.ferry_up_code, track.ferry_down_code, track.max_store, track.brother_track_id, track.left_track_id, track.right_track_id, track.memo,
                track.rfid_1, track.rfid_2, track.rfid_3, track.rfid_4, track.rfid_5, track.rfid_6, track.order, track.recent_goodid, track.recent_tileid);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        internal bool AddFerryPos(FerryPos ferpos)
        {
            string str = "INSERT INTO `ferry_pos`(`track_id`, `device_id`, `ferry_code`, `ferry_pos`)  VALUES('{0}', '{1}', '{2}', '{3}')";
            string sql = string.Format(@str, ferpos.track_id, ferpos.device_id, ferpos.ferry_code, ferpos.ferry_pos);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        internal bool AddFerryPos(uint areaid, uint devid)
        {
            List<FerryPos> list = new List<FerryPos>();
            string sql = string.Format("select  t.id as 'track_id', {0} as'device_id',  (t.ferry_up_code + t.ferry_down_code) as 'ferry_code'," +
                " 0 as 'ferry_pos' from track t where t.area = {1};",devid, areaid);
            DataTable dt = mSql.ExecuteQuery(@sql);
            if (!mSql.IsNoData(dt))
            {
                list = dt.ToDataList<FerryPos>();
            }
            if (list.Count > 0)
            {
                foreach (FerryPos pos in list)
                {
                    if(pos.ferry_code > 0)
                        AddFerryPos(pos);
                }
            }
            return list.Count > 0; ;
        }


        internal bool AddTrackLog(TrackLog log)
        {
            string str = "INSERT INTO `track_log`(`track_id`, `type`, `dev_id`, `stock_count`, `log_time`, `memo`, `area`) " +
                "VALUES('{0}', '{1}', '{2}', '{3}', {4}, '{5}', '{6}')";
            string sql = string.Format(@str, log.track_id, log.type, log.dev_id, log.stock_count,
                GetTimeOrNull(log.log_time),log.memo, log.area);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        #endregion

        #region[修改]

        internal bool EditTrack(Track track, TrackUpdateE type)
        {
            string sql = "UPDATE `track` SET ";
            switch (type)
            {
                case TrackUpdateE.StockStatus:
                    sql += string.Format("`stock_status` = {0}", track.stock_status);
                    break;
                case TrackUpdateE.TrackStatus:
                    sql += string.Format("`track_status` = {0}", track.track_status);
                    break;
                case TrackUpdateE.Common:
                    sql += string.Format("`name` = '{0}', `area` = {1}, `type` = {2}, `max_store` = {3}, `memo` = '{4}'", 
                        track.name, track.area, track.type, track.max_store, track.memo);
                    break;
                case TrackUpdateE.Size:
                    sql += string.Format("`width` = {0}, `left_distance` = {1}, `right_distance` = {2}", 
                        track.width, track.left_distance, track.right_distance);
                    break;
                case TrackUpdateE.Ferry:
                    sql += string.Format("`ferry_up_code` = {0}, `ferry_down_code` = {1}",
                        track.ferry_up_code, track.ferry_down_code);
                    break;
                case TrackUpdateE.Track:
                    sql += string.Format("`brother_track_id` = {0}, `left_track_id` = {1}, `right_track_id` = {2}", 
                        track.brother_track_id, track.left_track_id, track.right_track_id);
                    break;
                case TrackUpdateE.RfId:
                    sql += string.Format("`rfid_1` = {0}, `rfid_2` = {1}, `rfid_3` = {2}, `rfid_4` = {3}, `rfid_5` = {4}, `rfid_6` = {5}",
                        track.rfid_1, track.rfid_2, track.rfid_3, track.rfid_4, track.rfid_5, track.rfid_6);
                    break;
                case TrackUpdateE.Order:
                    sql += string.Format("`order` = {0} ", track.order);
                    break;
                case TrackUpdateE.RecentGoodId:
                    sql += string.Format("`recent_goodid` = {0} ", track.recent_goodid);
                    break;
                case TrackUpdateE.RecentTileId:
                    sql += string.Format("`recent_tileid` = {0} ", track.recent_tileid);
                    break;
                case TrackUpdateE.Alert:
                    sql += string.Format("`alert_status` = {0} ,`alert_carrier` = {1} ,`alert_trans` = {2} ",
                        track.alert_status, track.alert_carrier, track.alert_trans);
                    break;
                case TrackUpdateE.EarlyFull:
                    sql += string.Format("`early_full` = {0} ,`full_time` = {1} ",
                        track.early_full, GetTimeOrNull(track.full_time));
                    break;
                default:
                    sql += " 1=1";
                    break;
            }
            sql += string.Format(" WHERE `id` = {0}",track.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        internal bool EditFerryPos(uint id, int ferrypos)
        {
            string sql = "UPDATE `ferry_pos` SET  `ferry_pos` = {0} WHERE `id` = {1}";
            sql = string.Format(sql, ferrypos, id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        internal bool EditFerryPos(uint devid,int trackcode, int ferrypos)
        {
            string sql = "UPDATE `ferry_pos` SET  `ferry_pos` = {0}" +
                " WHERE `ferry_code` = {1} and `device_id` = {2}";
            sql = string.Format(sql,  ferrypos, trackcode ,devid);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        #endregion

        #region[删除]

        internal bool DeleteTrack(Track track)
        {
            string sql = string.Format("DELETE FROM `track` where id = '{0}'", track.id);
            int row = mSql.ExcuteSql(sql);
            return row >= 1;
        }

        #endregion
    }
}
