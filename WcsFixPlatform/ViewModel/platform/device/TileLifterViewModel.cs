using enums;
using GalaSoft.MvvmLight.Command;
using GalaSoft.MvvmLight.Messaging;
using HandyControl.Controls;
using HandyControl.Tools.Extension;
using module.device;
using module.goods;
using module.msg;
using module.window;
using resource;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using task;
using wcs.Data.View;
using wcs.Dialog;

namespace wcs.ViewModel
{
    public class TileLifterViewModel : MViewModel
    {
        public TileLifterViewModel() : base("TileLifter")
        {
            _deviceList = new ObservableCollection<TileLifterView>();
            InitAreaRadio();

            Messenger.Default.Register<MsgAction>(this, MsgToken.TileLifterStatusUpdate, TileLifterStatusUpdate);

            PubTask.TileLifter.GetAllTileLifter();

            DeviceView = System.Windows.Data.CollectionViewSource.GetDefaultView(DeviceList);
            DeviceView.Filter = new Predicate<object>(OnFilterMovie);
        }

        bool OnFilterMovie(object item)
        {
            if (filterareaid == 0) return true;
            if (item is TileLifterView view)
            {
                return PubMaster.Area.IsFerryInArea(filterareaid, view.ID);
            }
            return true;
        }
        private void InitAreaRadio()
        {
            AreaRadio = PubMaster.Area.GetAreaRadioList(true);
        }
        #region[字段]

        private ObservableCollection<TileLifterView> _deviceList;
        private TileLifterView _devicselected;

        private IList<MyRadioBtn> _arearadio;
        private uint filterareaid = 0;
        #endregion

        #region[属性]
        public IList<MyRadioBtn> AreaRadio
        {
            get => _arearadio;
            set => Set(ref _arearadio, value);
        }

        public ICollectionView DeviceView { set; get; }

        public ObservableCollection<TileLifterView> DeviceList
        {
            get => _deviceList;
            set => Set(ref _deviceList, value);
        }

        public TileLifterView DeviceSelected
        {
            get => _devicselected;
            set => Set(ref _devicselected, value);
        }

        #endregion

        #region[命令]
        public RelayCommand<RoutedEventArgs> CheckRadioBtnCmd => new Lazy<RelayCommand<RoutedEventArgs>>(() => new RelayCommand<RoutedEventArgs>(CheckRadioBtn)).Value;

        public RelayCommand<string> SendTileLifterTaskCmd => new Lazy<RelayCommand<string>>(() => new RelayCommand<string>(SendTileLifterTask)).Value;


        #endregion

        #region[方法]
        private async void SendTileLifterTask(string tag)
        {
            if (DeviceSelected == null)
            {
                Growl.Warning("请先选择设备");
                return;
            }

            if (byte.TryParse(tag, out byte stype))
            {
                switch (stype)
                {
                    case 1:
                        PubTask.TileLifter.DoInv(DeviceSelected.ID, true, DevLifterInvolE.介入);
                        break;
                    case 2:
                        PubTask.TileLifter.DoInv(DeviceSelected.ID, true, DevLifterInvolE.离开);
                        break;
                    case 3:
                        PubTask.TileLifter.DoInv(DeviceSelected.ID, false, DevLifterInvolE.介入);
                        break;
                    case 4:
                        PubTask.TileLifter.DoInv(DeviceSelected.ID, false, DevLifterInvolE.离开);
                        break;
                    case 5://修改规格
                        uint area = PubMaster.Device.GetDeviceArea(DeviceSelected.ID);
                        bool isuptilelifter = PubMaster.Device.IsDevType(DeviceSelected.ID, DeviceTypeE.上砖机);
                        DialogResult result = await HandyControl.Controls.Dialog.Show<GoodsSelectDialog>()
                         .Initialize<GoodsSelectViewModel>((vm) =>
                         {
                             vm.SetAreaFilter(area, false);
                             if (isuptilelifter)
                             {
                                 vm.QueryStockGood();
                             }
                             else
                             {
                                 vm.QueryGood();
                             }
                         }).GetResultAsync<DialogResult>();

                        if (result.p1 is bool rs && result.p2 is Goods good)
                        {
                            if(PubMaster.Device.SetTileLifterGoods(DeviceSelected.ID, good.id))
                            {
                                PubTask.TileLifter.UpdateTileLifterGoods(DeviceSelected.ID, good.id);
                            }
                        }

                        break;
                    case 6://启动
                        PubTask.TileLifter.StartStopTileLifter(DeviceSelected.ID, true);
                        break;
                    case 7://停止
                        PubTask.TileLifter.StartStopTileLifter(DeviceSelected.ID, false);
                        break;
                    case 8://修改策略
                        bool isdowntile = PubMaster.Device.IsDevType(DeviceSelected.ID, DeviceTypeE.下砖机);
                        MsgAction strategyrs = await HandyControl.Controls.Dialog.Show<ChangeStrategyDialog>()
                            .Initialize<ChangeStrategyDialogViewModel>((vm) => {

                                vm.SetShow(isdowntile);
                                if (isdowntile)
                                {
                                    vm.SetInStrategy(DeviceSelected.InStrategy);
                                }
                                else
                                {
                                    vm.SetOutStrategy(DeviceSelected.OutStrategy, DeviceSelected.WorkType);
                                }
                            }).GetResultAsync<MsgAction>();

                        if (strategyrs.o1 is bool ishcnage)
                        {
                            if(isdowntile && strategyrs.o2 is StrategyInE instrategy)
                            {
                                if(PubMaster.Device.SetInStrategy(DeviceSelected.ID, instrategy))
                                {
                                    PubTask.TileLifter.UpdateTileInStrategry(DeviceSelected.ID, instrategy);
                                }
                            }

                            if(!isdowntile && strategyrs.o2 is StrategyOutE outstrategy && strategyrs.o3 is DevWorkTypeE worktype)
                            {
                                if((DeviceSelected.OutStrategy != outstrategy
                                    || DeviceSelected.WorkType != worktype)
                                    && PubMaster.Device.SetOutStrategy(DeviceSelected.ID, outstrategy, worktype))
                                {
                                    PubTask.TileLifter.UpdateTileOutStrategry(DeviceSelected.ID, outstrategy, worktype);
                                }
                            }
                        }
                        break;

                    case 9://开始作业
                        if(PubMaster.Device.SetDevWorking(DeviceSelected.ID, true, out DeviceTypeE _))
                        {
                            PubTask.TileLifter.UpdateWorking(DeviceSelected.ID, true, 255);
                        }
                        break;

                    case 10://结束作业                        
                        if(PubMaster.Device.SetDevWorking(DeviceSelected.ID, false, out DeviceTypeE _))
                        {
                            PubTask.TileLifter.UpdateWorking(DeviceSelected.ID, false, 255);
                        }
                        break;
                }
            }
        }

        

        private void TileLifterStatusUpdate(MsgAction msg)
        {
            if (msg.o1 is DevTileLifter dev 
                && msg.o2 is SocketConnectStatusE conn 
                && msg.o3 is uint gid 
                && msg.o4 is StrategyInE instrategy 
                && msg.o5 is StrategyOutE outstrategy
                && msg.o6 is bool working
                && msg.o7 is DevWorkTypeE worktype)
            {
                Application.Current.Dispatcher.Invoke(() =>
                {
                    TileLifterView view = DeviceList.FirstOrDefault(c => c.ID == msg.ID);
                    if (view == null)
                    {
                        view = new TileLifterView()
                        {
                            ID = msg.ID,
                            Name = msg.Name
                        };
                        DeviceList.Add(view);
                    }
                    view.Update(dev, conn, gid, instrategy, outstrategy, working, worktype);
                });
            }
        }

        private void CheckRadioBtn(RoutedEventArgs args)
        {
            if (args.OriginalSource is RadioButton btn)
            {
                if (uint.TryParse(btn.Tag.ToString(), out uint areaid))
                {
                    filterareaid = areaid;
                    DeviceView.Refresh();
                }
            }
        }

        #endregion

        protected override void TabActivate()
        {
        }

        protected override void TabDisActivate()
        {

        }
    }
}
