using enums;
using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Command;
using GalaSoft.MvvmLight.Messaging;
using HandyControl.Controls;
using HandyControl.Data;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using wcs.Data.Model;
using wcs.Lang;
using wcs.Service;
using wcs.Tools;

namespace wcs.ViewModel
{

    public class MainViewModel : ViewModelBase
    {
        #region[�˵�]

        private void AddMenu(bool showquery, bool showsetting)
        {
            MenuList.Clear();

            //MenuModel home = new MenuModel()
            //{
            //    Name = "��ҳ",
            //    IKey = "Home",
            //    OpenPage = true
            //};
            //MenuList.Add(home);
            MenuModel task = new MenuModel()
            {
                Name = "����",
                IKey = "",
                OpenPage = false,
                MenuList = new List<MenuModel>()
                {
                    new MenuModel()
                    {
                        Name = "����",
                        IKey = "AreaSwitch",
                        OpenPage = true
                    },
                    new MenuModel()
                    {
                        Name = "����",
                        IKey = "Trans",
                        OpenPage = true
                    },
                    //new MenuModel()
                    //{
                    //    Name = "�������",
                    //    IKey = "TileTrack",
                    //    OpenPage = true
                    //}

                }
            };
            MenuList.Add(task);

            MenuModel device = new MenuModel()
            {
                Name = "�豸",
                IKey = "",
                OpenPage = false,
                MenuList = new List<MenuModel>()
                {
                    new MenuModel()
                    {
                        Name = "ש��",
                        IKey = "TileLifter",
                        OpenPage = true
                    },
                    new MenuModel()
                    {
                        Name = "�ڶɳ�",
                        IKey = "Ferry",
                        OpenPage = true
                    },
                    new MenuModel()
                    {
                        Name = "���䳵",
                        IKey = "Carrier",
                        OpenPage = true
                    },new MenuModel()
                    {
                        Name = "���",
                        IKey = "Track",
                        OpenPage = true,
                    }
                    //,
                    //new MenuModel()
                    //{
                    //    Name = "ƽ��",
                    //    IKey = "RfClient",
                    //    OpenPage = true
                    //}
                }
            };
            MenuList.Add(device);

            MenuModel good = new MenuModel()
            {
                Name = "ͳ��",
                IKey = "",
                OpenPage = false,
                MenuList = new List<MenuModel>()
                {
                    new MenuModel()
                    {
                        Name = "���",
                        IKey = "Goods",
                        OpenPage = true
                    },new MenuModel()
                    {
                        Name = "���",
                        IKey = "StockSum",
                        OpenPage = true
                    },new MenuModel()
                    {
                        Name = "���",
                        IKey = "Stock",
                        OpenPage = true
                    }
                }
            };
            MenuList.Add(good);

            MenuModel set = new MenuModel()
            {
                Name = "����",
                IKey = "",
                OpenPage = false,
                MenuList = new List<MenuModel>()
                {
                   new MenuModel()
                    {
                        Name = "�������",
                        IKey = "TrackAllocate",
                        OpenPage = true
                    },
                    new MenuModel()
                    {
                        Name = "�ڶɶ�λ",
                        IKey = "FerryPos",
                        OpenPage = true
                    },
                    new MenuModel()
                    {
                        Name = "��������",
                        IKey = "Area",
                        OpenPage = true
                    },
                    //new MenuModel()
                    //{
                    //    Name = "�ֵ�",
                    //    IKey = "Diction",
                    //    OpenPage = true
                    //},
                   // new MenuModel()
                   // {
                   //     Name = "�����ש",
                   //     IKey = "TestGood",
                   //     OpenPage = true
                   // },
                   //new MenuModel()
                   // {
                   //     Name = "�������",
                   //     IKey = "AddManualTrans",
                   //     OpenPage = true
                   // }
                }
            };
            MenuList.Add(set);

            MenuModel log = new MenuModel()
            {
                Name = "��¼",
                IKey = "",
                OpenPage = false,
                MenuList = new List<MenuModel>()
                {
                    new MenuModel()
                    {
                        Name ="����",
                        OpenPage = true,
                        IKey = "WarnLog"
                    },
                    new MenuModel()
                    {
                        Name ="�������",
                        OpenPage = true,
                        IKey = "TrackLog"
                    },
                }
            };

            MenuList.Add(log);
        }

        #endregion

        #region[�ֶ�]

        private int _selectTabIndex;

        private ObservableCollection<TabItemModel> _tablist = new ObservableCollection<TabItemModel>();

        private readonly List<WinCtlModel> WinCtlList = new List<WinCtlModel>();

        private bool _showTabClose = false;

        /// <summary>
        /// �����б�
        /// </summary>
        private ObservableCollection<MenuModel> _menuList;
        private string winmsg = "";
        #endregion
        public MainViewModel(DataService dataService)
        {
            WinCtlList.AddRange(dataService.GetWinCtlData());
            MenuList = new ObservableCollection<MenuModel>();
            AddMenu(true, true);

            //Messenger.Default.Register<MsgAction>(this, MsgToken.OperationUpdate, OperationUpdate);
            //Messenger.Default.Register<MsgAction>(this, MsgToken.WindowMsgShow, WindowMsgShow);
            SideMenuItemSelect("Home");
        }

        ///// <summary>
        ///// չʾ��ʾ��Ϣ
        ///// </summary>
        ///// <param name="msg"></param>
        //private void WindowMsgShow(MsgAction msg)
        //{
        //    if (!PubMaster.MDic.IsSwitchOn(DictionCode.ShowWinMsg)) return;
        //    Application.Current.Dispatcher.Invoke(() =>
        //    {
        //        if (msg.p1 is MsgTypeE type && msg.p2 is string content && msg.p3 is int id)
        //        {
        //            if (winmsg.Equals(content)) return;
        //            winmsg = content;
        //            switch (type)
        //            {
        //                case MsgTypeE.Info:
        //                    Growl.Info(content);
        //                    break;
        //                case MsgTypeE.Waring:
        //                    Growl.Warning(content);
        //                    break;
        //                case MsgTypeE.Error:
        //                    Growl.Error(content);
        //                    break;
        //                case MsgTypeE.Success:
        //                    Growl.Success(content);
        //                    break;
        //                default:
        //                    break;
        //            }
        //        }
        //    });
        //}

        #region[����]

        public int SelectedTabIndex
        {
            get => _selectTabIndex;
            set => Set(ref _selectTabIndex, value);
        }

        public ObservableCollection<TabItemModel> TabList
        {
            get => _tablist;
            set => Set(ref _tablist, value);
        }

        public bool ShowTabCloseBtn
        {
            get => _showTabClose;
            set => Set(ref _showTabClose, value);
        }

        /// <summary>
        ///     �����б�
        /// </summary>
        public ObservableCollection<MenuModel> MenuList
        {
            get => _menuList;
            set => Set(ref _menuList, value);
        }
        #endregion

        #region[����]

        public RelayCommand<string> SideMenuItemSelectCmd => new Lazy<RelayCommand<string>>(() => new RelayCommand<string>(SideMenuItemSelect)).Value;
        public RelayCommand<RoutedEventArgs> ClosedCmd => new Lazy<RelayCommand<RoutedEventArgs>>(() => new RelayCommand<RoutedEventArgs>(Closed)).Value;
        public RelayCommand<CancelRoutedEventArgs> ClosingCmd => new Lazy<RelayCommand<CancelRoutedEventArgs>>(() => new RelayCommand<CancelRoutedEventArgs>(Closing)).Value;
        public RelayCommand<RoutedEventArgs> MenuTreeViewChangeCmd => new Lazy<RelayCommand<RoutedEventArgs>>(() => new RelayCommand<RoutedEventArgs>(MenuTreeViewChange)).Value;
        public RelayCommand<RoutedEventArgs> TabSelectedCmd => new Lazy<RelayCommand<RoutedEventArgs>>(() => new RelayCommand<RoutedEventArgs>(TabSelected)).Value;

        #endregion

        #region[����]

        private WinCtlModel GetWinCtlModel(string key)
        {
            return WinCtlList?.Find(c => c.Key.Equals(key)) ?? null;
        }

        /// <summary>
        /// ��ť�˵��л�
        /// </summary>
        /// <param name="tag"></param>
        private void SideMenuItemSelect(string tag)
        {
            if (!IsExistTab(tag)) return;
            AddTabItem(tag);

            Messenger.Default.Send(tag, MsgToken.TabItemSelected);
        }

        /// <summary>
        /// �ж��Ƿ��Ѵ�
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public bool IsExistTab(string key)
        {
            TabItemModel tab = TabList.FirstOrDefault(c => c.Key.Equals(key));
            if (tab != null)
            {
                //SelectedTabIndex = TabList.IndexOf(tab);

                int i = TabList.IndexOf(tab);
                if (i >= 3)
                {
                    TabList.Move(i, 0);
                    i = 0;
                }
                SelectedTabIndex = i;

                //Tab�л����Լ�⵽
                //Messenger.Default.Send(key, MsgToken.TabItemSelected);
            }
            return tab == null;
        }

        private void CloseTab(string key)
        {
            TabItemModel tab = TabList.FirstOrDefault(c => c.Key.Equals(key));
            if (tab != null)
            {
                if (tab.SubContent is IDisposable disposable)
                {
                    disposable.Dispose();
                }
                TabList.Remove(tab);
            }
        }

        /// <summary>
        /// ��Ӳ�ѡ������Tab
        /// </summary>
        /// <param name="key"></param>
        /// <param name="name"></param>
        /// <param name="icon"></param>
        /// <param name="color"></param>
        /// <param name="content"></param>
        public void AddTabItem(string key)
        {
            //if (TabList.Count > 5)
            //{
            //    Growl.Warning("�����ȹرն���Ĵ��ڣ���");
            //    return;
            //}
            WinCtlModel model = GetWinCtlModel(key);
            if (model != null)
            {
                try
                {
                    var obj = AssemblyHelper.ResolveByKey(model.WinCtlName);
                    var ctl = obj ?? AssemblyHelper.CreateInternalInstance($"window.{model.WinCtlName}", model.WinCtlName);
                    if (ctl != null)
                    {
                        //TabList.Add(new TabItemModel()
                        TabList.Insert(0, new TabItemModel()
                        {
                            Key = key,
                            Name = MLang.GetLang(model.Name),
                            Geometry = model.Geometry,
                            GColor = model.Brush,
                            SubContent = ctl
                        });

                        //SelectedTabIndex = TabList.Count - 1;
                        SelectedTabIndex = 0;
                    }
                    else
                    {
                        Growl.Error("���ش����ļ�" + model.WinCtlName + "����!\n");
                    }
                }
                catch (Exception e)
                {
                    Growl.Error("���ش����ļ�" + model.WinCtlName + "����!\n" + e.Message);
                }
            }
            else
            {
                Growl.Warning("�Ҳ���ģ�����õ���Ϣ(Data/WinCtlData.json)");
            }


            if (TabList.Count > 1)
            {
                ShowTabCloseBtn = true;
            }
        }

        private void Closing(CancelRoutedEventArgs args)
        {
            //Growl.Info($"{(args.OriginalSource as TabItem)?.Header} Closing");
        }


        private void Closed(RoutedEventArgs args)
        {
            //Growl.Info($"{(args.OriginalSource as TabItem)?.Header} Closed");
            if (args.OriginalSource is TabItemModel item)
            {
                if (item.SubContent is IDisposable disposable)
                {
                    disposable.Dispose();
                }

                //Messenger.Default.Send(item.Key, MsgToken.TabItemClosed);
            }

            if (TabList.Count <= 2)
            {
                ShowTabCloseBtn = false;
            }
        }

        //private void OperationUpdate(MsgAction msg)
        //{
        //    if (msg.p1 is bool grand)
        //    {
        //        if (msg.p2 is string user && msg.p3 is bool showquery && msg.p4 is bool showsetting)
        //        {
        //            if (grand && !string.IsNullOrEmpty(user))
        //            {
        //                AddMenu(showquery, showsetting);
        //            }
        //        }

        //        if (!grand)
        //        {
        //            AddMenu(false, false);
        //            CloseTab("AgvLogQuery");
        //            CloseTab("SiteLogQuery");
        //            CloseTab("Switch");
        //            CloseTab("Dictionary");
        //        }
        //    }
        //}

        private void MenuTreeViewChange(RoutedEventArgs orgs)
        {
            if (orgs != null && orgs.OriginalSource is TreeView pro && pro.SelectedItem is MenuModel menu)
            {
                if (menu.OpenPage)
                {
                    SideMenuItemSelect(menu.IKey);
                }
            }
        }

        private void TabSelected(RoutedEventArgs orgs)
        {
            if (orgs != null && orgs.OriginalSource is HandyControl.Controls.TabControl pro && pro.SelectedItem is TabItemModel tab)
            {
                Messenger.Default.Send(tab.Key, MsgToken.TabItemSelected);
            }
        }
        #endregion
    }
}