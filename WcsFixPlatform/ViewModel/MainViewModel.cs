using enums;
using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Command;
using GalaSoft.MvvmLight.Messaging;
using HandyControl.Controls;
using HandyControl.Data;
using module.msg;
using module.role;
using resource;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using wcs.Data.Model;
using wcs.Service;
using wcs.Tools;

namespace wcs.ViewModel
{
    public class MainViewModel : ViewModelBase
    {
        #region[�ֶ�]

        private int _selectTabIndex;

        private ObservableCollection<TabItemModel> _tablist = new ObservableCollection<TabItemModel>();

        private bool _showTabClose = false;

        /// <summary>
        /// �����б�
        /// </summary>
        private ObservableCollection<MenuModel> _menuList;
        #endregion
        public MainViewModel(DataService dataService)
        {
            MenuList = new ObservableCollection<MenuModel>();

            Messenger.Default.Register<MsgAction>(this, MsgToken.OperateGrandUpdate, OperateGrandUpdate);
        }


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


        //��½/�ǳ� ��֤
        private void OperateGrandUpdate(MsgAction obj)
        {
            if (obj == null) return;
            Application.Current.Dispatcher.Invoke(() =>
            {
                if(obj.o1 is WcsUser user)
                {
                    RefreshMenu(user.username, user.password);
                }

                //ȷ�����û�guest����Ϣ
                if(obj.o1 is bool islogout && islogout)
                {
                    RefreshMenu("guest", "guest");
                }
            });
        }

        #region[�˵�]

        private void RefreshMenu(string username, string password)
        {
            MenuList.Clear();
            List<MenuModel> menulist = PubMaster.Role.GetMenu(out string result, username, password);
            foreach (MenuModel item in menulist)
            {
                MenuList.Add(item);
            }

            List<string> closetabkeys = new List<string>();
            foreach (var item in TabList)
            {
                if(!menulist.Exists(c=>item.Key.Equals(c.IKey) || c.ExistDtl(item.Key)))
                {
                    closetabkeys.Add(item.Key);
                }
            }

            foreach (var item in closetabkeys)
            {
                CloseTab(item);
            }
        }

        #endregion

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
            //WinCtlModel model = GetWinCtlModel(key);
            WcsModule model = PubMaster.Role.GetWcsModule(key);
            if (model != null)
            {
                try
                {
                    var obj = AssemblyHelper.ResolveByKey(model.winctlname);
                    var ctl = obj ?? AssemblyHelper.CreateInternalInstance($"window.{model.winctlname}", model.winctlname);
                    if (ctl != null)
                    {
                        TabList.Insert(0, new TabItemModel()
                        {
                            Id = model.id,
                            Key = key,
                            Name = model.name,//MLang.GetLang(model.Name),
                            Geometry = model.geometry,
                            GColor = model.brush,
                            SubContent = ctl
                        });

                        //SelectedTabIndex = TabList.Count - 1;
                        SelectedTabIndex = 0;
                    }
                    else
                    {
                        Growl.Error("���ش����ļ�" + model.winctlname + "����!\n");
                    }
                }
                catch (Exception e)
                {
                    Growl.Error("���ش����ļ�" + model.winctlname + "����!\n" + e.Message);
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