﻿using enums;
using enums.track;
using module.area;
using module.device;
using module.goods;
using module.window;
using System;
using System.Collections.Generic;
using System.Linq;

namespace resource.area
{
    public class AreaMaster
    {
        #region[构造/初始化]

        public AreaMaster()
        {
            AreaList = new List<Area>();
            AreaDevList = new List<AreaDevice>();
            AreaTraList = new List<AreaTrack>();
            AreaDevTraList = new List<AreaDeviceTrack>();
        }

        public void Start()
        {
            Refresh();
        }

        public void Refresh(bool refr_1 = true, bool refr_2 = true, bool refr_3 = true, bool refr_4 = true)
        {
            if (refr_1)
            {
                AreaList.Clear();
                AreaList.AddRange(PubMaster.Mod.AreaSql.QueryAreaList());
            }

            if (refr_2)
            {
                AreaDevList.Clear();
                AreaDevList.AddRange(PubMaster.Mod.AreaSql.QueryAreaDeviceList());
            }

            if (refr_3)
            {
                AreaTraList.Clear();
                AreaTraList.AddRange(PubMaster.Mod.AreaSql.QueryAreaTrackList());
            }

            if (refr_4)
            {
                AreaDevTraList.Clear();
                AreaDevTraList.AddRange(PubMaster.Mod.AreaSql.QueryAreaDeviceTrackList());
            }
        }

        public uint GetAreaId(uint id)
        {
            return AreaDevList.Find(c => c.device_id == id)?.area_id ?? 0;
        }

        public IList<MyRadioBtn> GetAreaRadioList(bool iswithall = false)
        {
            List<MyRadioBtn> myradios = new List<MyRadioBtn>();

            if (iswithall)
            {
                myradios.Add(new MyRadioBtn()
                {
                    AreaID = 0,
                    AreaName = "全部",
                    AreaTag = "0",
                });
            }

            foreach (Area area in AreaList)
            {
                myradios.Add(new MyRadioBtn()
                {
                    AreaID = area.id,
                    AreaName = area.name,
                    AreaTag = area.id+""
                }); ;
            }

            if (myradios.Count >= 2)
            {
                myradios[0].BorderCorner = new System.Windows.CornerRadius(5, 0, 0, 5);
                myradios[myradios.Count - 1].BorderCorner = new System.Windows.CornerRadius(0, 5, 5, 0);
            }

            return myradios;
        }

        internal List<uint> GetAreaTileIds(uint areaid)
        {
            return AreaDevList.FindAll(c => c.area_id == areaid 
                                && (c.DevType == DeviceTypeE.上砖机 || c.DevType == DeviceTypeE.下砖机))
                                    .Select(c=>c.device_id).ToList();
        }

        internal List<uint> GetAreaFerryIds(uint areaid)
        {
            return AreaDevList.FindAll(c => c.area_id == areaid 
                                && (c.DevType == DeviceTypeE.上摆渡 || c.DevType == DeviceTypeE.下摆渡))
                                    .Select(c=>c.device_id).ToList();
        }

        public bool IsFerryInArea(uint filterareaid, uint iD)
        {
            return AreaDevList.Exists(c => c.area_id == filterareaid && c.device_id == iD);
        }

        public void Stop()
        {

        }
        #endregion

        #region[字段]

        private List<Area> AreaList { set; get; }
        private List<AreaDevice> AreaDevList { set; get; }
        private List<AreaTrack> AreaTraList { set; get; }
        private List<AreaDeviceTrack> AreaDevTraList { set; get; }

        #endregion

        #region[获取对象]

        public List<Area> GetAreaList()
        {
            return AreaList;
        }

        public Area GetArea(uint devid)
        {
            return AreaList.Find(c => c.id == devid);
        }

        public List<AreaDevice> GetAreaDevList()
        {
            return AreaDevList;
        }

        public List<AreaDevice> GetAreaDevList(uint area_id)
        {
            return AreaDevList.FindAll(c => c.area_id == area_id);
        }

        public List<AreaDevice> GetAreaDevList(uint area_id, DeviceTypeE devtype)
        {
            return AreaDevList.FindAll(c => c.area_id == area_id && c.DevType == devtype);
        }

        public List<AreaDeviceTrack> GetDevTrackList(uint devid)
        {
            return AreaDevTraList.FindAll(c => c.device_id == devid);
        }

        public List<AreaDeviceTrack> GetAreaDevTraList(uint areaid, uint devid)
        {
            List<AreaDeviceTrack> list = AreaDevTraList.FindAll(c => c.area_id == areaid && c.device_id == devid);
            if (list.Count > 0)
            {
                list.Sort((x, y) => x.prior.CompareTo(y.prior));
            }
            return list;
        }

        #endregion

        #region[获取/判断属性]

        public string GetAreaName(uint Area_id)
        {
            return AreaList.Find(c => c.id == Area_id)?.name ?? "";
        }

        /// <summary>
        /// 倒库专用：找到上砖摆渡轨道
        /// </summary>
        /// <param name="trans"></param>
        /// <returns></returns>
        public List<uint> GetFerryTrackSortIds(StockTrans trans, bool istrackid)
        {
            List<uint> list = new List<uint>();
            List<AreaDevice> ferrys = AreaDevList.FindAll(c => c.area_id == trans.area_id && c.DevType == DeviceTypeE.上摆渡);

            if (ferrys != null && ferrys.Count > 0)
            {
                foreach (AreaDevice device in ferrys)
                {
                    if (AreaDevTraList.Exists(c => c.device_id == device.device_id
                                                && c.area_id == device.area_id
                                                && c.track_id == trans.give_track_id))
                    {
                        if (istrackid)
                        {
                            uint trackid = PubMaster.Device.GetFerryTrackId(device.device_id);
                            if (trackid > 0)
                                list.Add(trackid);
                        }
                        else
                        {
                            list.Add(device.device_id);
                        }
                    }
                }
            }

            return list;
        }

        public CarrierTypeE GetCarrierType(uint area_id)
        {
            return AreaList.Find(c => c.id == area_id)?.CarrierType ?? CarrierTypeE.窄车;
        }

        /// <summary>
        /// 摆渡车是否允许定位轨道
        /// </summary>
        /// <param name="areaid"></param>
        /// <param name="ferryid"></param>
        /// <param name="trackid"></param>
        /// <returns></returns>
        public bool IsFerryWithTrack(uint areaid, uint ferryid, uint trackid)
        {
            return AreaDevTraList.Exists(c => c.area_id == areaid && c.device_id == ferryid && c.track_id == trackid);

        }

        /// <summary>
        /// 获取能够同时到达指定轨道的摆渡车ID
        /// </summary>
        /// <param name="ferrytype">摆渡车类型</param>
        /// <param name="traids">轨道可变列表（多个轨道号）</param>
        /// <returns></returns>
        public List<uint> GetWithTracksFerryIds(DeviceTypeE ferrytype, params uint[] traids)
        {
            List<uint> ferryids = PubMaster.Device.GetFerryIds(ferrytype);
            return GetWithTracksFerryIds(ferryids, traids);
        }

        /// <summary>
        /// 获取能够同时到达指定轨道的摆渡车ID
        /// </summary>
        /// <param name="traids">轨道可变列表（多个轨道号）</param>
        /// <returns></returns>
        public List<uint> GetWithTracksFerryIds(params uint[] traids)
        {
            return GetWithTracksFerryIds(null, traids);
        }

        /// <summary>
        /// 获取能够同时到达指定轨道的摆渡车ID
        /// </summary>
        /// <param name="ferryids">需要判断的摆渡车</param>
        /// <param name="traids">轨道可变列表（多个轨道号）</param>
        /// <returns></returns>
        public List<uint> GetWithTracksFerryIds(List<uint> ferryids, params uint[] traids)
        {
            List<uint> filterferryids = new List<uint>();

            if (ferryids == null)
            {
                ferryids = PubMaster.Device.GetFerryIds(DeviceTypeE.上摆渡, DeviceTypeE.下摆渡);
            }
            //查找能满砖所有轨道的摆渡车
            bool havealltrack;
            foreach (var ferryid in ferryids)
            {
                havealltrack = true;
                foreach (uint traid in traids)
                {
                    if (!AreaDevTraList.Exists(c => c.track_id == traid && ferryid == c.device_id))
                    {
                        havealltrack = false;
                    }
                }

                if (havealltrack)
                {
                    filterferryids.Add(ferryid);
                }
            }
            return filterferryids;
        }

        /// <summary>
        /// 查看是否摆渡车分配的轨道里面是否配置了另外一个轨道
        /// </summary>
        /// <param name="ferryids">已经配置了A轨道的摆渡车信息</param>
        /// <param name="trackid">需要检查是否配了的B轨道</param>
        /// <returns></returns>
        public bool ExistFerryWithTrack(List<uint> ferryids, uint trackid)
        {
            return AreaDevTraList.Exists(c => ferryids.Contains(c.device_id) && c.track_id == trackid);
        }

        /// <summary>
        /// 获取摆渡车ID或摆渡车轨道的ID
        /// </summary>
        /// <param name="trans"></param>
        /// <param name="istrackid"></param>
        /// <returns></returns>
        public List<uint> GetFerryWithTrackInOut(DeviceTypeE ferrytype, uint areaid, uint taketrackid, uint givetrackid, uint cartrackid, bool istrackid)
        {
            List<uint> list = new List<uint>();
            List<AreaDevice> ferrys = AreaDevList.FindAll(c => c.area_id == areaid && c.DevType == ferrytype);

            if (ferrys != null && ferrys.Count > 0)
            {
                bool takematch, givematch, carmatch;
                foreach (AreaDevice device in ferrys)
                {
                    takematch = taketrackid == 0 || AreaDevTraList.Exists(c => c.device_id == device.device_id
                                                  && c.area_id == device.area_id
                                                  && c.track_id == taketrackid);
                    givematch = givetrackid == 0 || AreaDevTraList.Exists(c => c.device_id == device.device_id
                                                && c.area_id == device.area_id
                                                && c.track_id == givetrackid);
                    carmatch = cartrackid == 0 || AreaDevTraList.Exists(c => c.device_id == device.device_id
                                                && c.area_id == device.area_id
                                                && c.track_id == cartrackid);

                    if (takematch && givematch && carmatch)
                    {
                        if (istrackid)
                        {
                            uint trackid = PubMaster.Device.GetFerryTrackId(device.device_id);
                            if(trackid > 0)
                                list.Add(trackid);
                        }
                        else
                        {
                            list.Add(device.device_id);
                        }
                    }
                }
            }

            return list;
        }

        public void SaveToDb(uint areaid, uint devid)
        {
            foreach (AreaDeviceTrack item in AreaDevTraList.FindAll(c => c.area_id == areaid && c.device_id == devid))
            {
                PubMaster.Mod.AreaSql.EditAreaDeviceTrack(item);
            }
        }

        public void AddAreaTileTrackList(uint areaid, uint toareaid, Device tile)
        {
            TrackTypeE tracktype = TrackTypeE.储砖_入;

            if (tile.Type == DeviceTypeE.上砖机)
            {
                tracktype = TrackTypeE.储砖_出;
            }
            List<uint> trackids = PubMaster.Track.GetAreaTrackIds(areaid, tracktype);
            trackids.AddRange(PubMaster.Track.GetAreaTrackIds(areaid, TrackTypeE.储砖_出入));
            ushort prior = (ushort)AreaDevTraList.Count(c => c.area_id == toareaid && c.device_id == tile.id);
            prior++;
            AreaDeviceTrack areatradev;
            foreach (uint trackid in trackids)
            {
                if (AreaDevTraList.Exists(c => c.area_id == toareaid && c.device_id == tile.id && c.track_id == trackid))
                {
                    continue;
                }

                areatradev = new AreaDeviceTrack()
                {
                    area_id = toareaid,
                    device_id = tile.id,
                    track_id = trackid,
                    prior = prior,
                };
                PubMaster.Mod.AreaSql.AddAreaDeviceTrack(areatradev);
                prior += 1;
            }

            Refresh(false, false, false, true);
        }

        public bool DeleteAreaDevTrack(uint id)
        {
            AreaDeviceTrack track = AreaDevTraList.Find(c => c.id == id);
            if (track != null)
            {
                AreaDevTraList.Remove(track);
                PubMaster.Mod.AreaSql.DeleteAreaDeviceTrack(track);
                return true;
            }
            return false;
        }

        public void AddAreaFerryTrackList(uint areaid, uint toareaid, Device ferry)
        {
            TrackTypeE tracktype = TrackTypeE.储砖_入;
            TrackTypeE tiletrtype = TrackTypeE.下砖轨道;

            if (ferry.Type == DeviceTypeE.上摆渡)
            {
                tracktype = TrackTypeE.储砖_出; 
                tiletrtype = TrackTypeE.上砖轨道;
            }
            List<uint> trackids = PubMaster.Track.GetAreaTrackIds(areaid, tracktype);
            trackids.AddRange(PubMaster.Track.GetAreaTrackIds(areaid, TrackTypeE.储砖_出入));
            trackids.AddRange(PubMaster.Track.GetAreaTrackIds(areaid, tiletrtype));
            ushort prior = (ushort)AreaDevTraList.Count(c => c.area_id == toareaid && c.device_id == ferry.id);
            prior++;
            AreaDeviceTrack areatradev;
            foreach (uint trackid in trackids)
            {
                if (AreaDevTraList.Exists(c=>c.area_id == toareaid && c.device_id == ferry.id && c.track_id == trackid))
                {
                    continue;
                }

                areatradev = new AreaDeviceTrack()
                {
                    area_id = toareaid,
                    device_id = ferry.id,
                    track_id = trackid,
                    prior = prior,
                };
                PubMaster.Mod.AreaSql.AddAreaDeviceTrack(areatradev);
                prior += 1;
            }

            Refresh(false, false, false, true);
        }

        public bool IsInDevTrack(uint trackid, uint toareaid, uint devid)
        {
            return AreaDevTraList.Exists(c => c.area_id == toareaid && c.device_id == devid && c.track_id == trackid);
        }

        public void AddAreaTrack(uint trackid, uint toareaid, Device dev)
        {
            ushort prior = (ushort)AreaDevTraList.Count(c => c.area_id == toareaid && c.device_id == dev.id);
            prior++;

            if (AreaDevTraList.Exists(c => c.area_id == toareaid && c.device_id == dev.id && c.track_id == trackid))
            {
                return;
            }

            AreaDeviceTrack areatradev = new AreaDeviceTrack()
            {
                area_id = toareaid,
                device_id = dev.id,
                track_id = trackid,
                prior = prior,
            };

            PubMaster.Mod.AreaSql.AddAreaDeviceTrack(areatradev);
            prior += 1;

            Refresh(false, false, false, true);
        }

        public bool IsFerrySetTrack(uint ferryid, uint trackid)
        {
            return AreaDevTraList.Exists(c => c.device_id == ferryid && c.track_id == trackid);
        }

        public List<uint> GetTileTrackIds(StockTrans trans)
        {
            List<AreaDeviceTrack> list = GetAreaDevTraList(trans.area_id, trans.tilelifter_id);
            return list.Select(c => c.track_id).ToList();
        }

        public List<AreaTrack> GetAreaTrackIds(uint areaid)
        {
            return AreaTraList.FindAll(c => c.area_id == areaid);
        }

        public List<uint> GetAreaTrackIds(uint areaid, TrackTypeE typeE)
        {
            List<AreaTrack> areaTracks = AreaTraList.FindAll(c => c.area_id == areaid && c.TrackType == typeE);
            return areaTracks.Select(c => c.track_id).ToList();
        }

        /// <summary>
        /// 获取下砖机所在的区域ID
        /// </summary>
        /// <param name="tileid"></param>
        /// <returns></returns>
        public uint GetAreaDevAreaId(uint tileid)
        {
            return AreaDevList.Find(c => c.device_id == tileid)?.area_id ?? 0;
        }

        public bool IsSortTaskLimit(ushort area, int count)
        {
            int carcount = PubMaster.Device.GetCarriers(area);
            if (carcount > 5)
            {
                return count >= 2;
            }
            else
            {
                return count >= 1;
            }
            //return AreaList.Exists(c => c.id == area && count >= c.c_sorttask);
        }

        public ushort GetAreaFullQty(uint id)
        {
            return AreaList.Find(c => c.id == id)?.full_qty ?? 0;
        }

        #endregion

        #region[更改]

        #endregion
    }
}
