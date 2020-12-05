using HandyControl.Controls;
using HandyControl.Tools.Extension;
using module.msg;
using resource;
using System;
using System.ComponentModel;
using System.Windows;
using task;
using tool.mlog;
using wcs.Dialog;
using wcs.ViewModel;
using wcs.window;

namespace wcs
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow
    {
        private Log mLog;
        public MainWindow()
        {
            InitializeComponent();
            mLog = (Log)new LogFactory().GetLog("系统", false);
        }


        /// <summary>
        /// 关闭窗口前的操作
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Window_Closing(object sender, CancelEventArgs e)
        {
            
            try
            {
                Application.Current.Dispatcher.Invoke(() =>
                {
                    e.Cancel = true;
                    ShowQuitDialogAsync();
                    //MessageBoxResult result = HandyControl.Controls.MessageBox.Show("是否退出程序！", "警告", MessageBoxButton.YesNo, MessageBoxImage.Warning);

                    //if (result == MessageBoxResult.Yes)
                    //{
                    //    mLog.Status(true, "调度关闭");
                    //    PubMaster.Warn.Stop();
                    //    PubTask.Stop();
                    //    PubMaster.StopMaster();
                    //    Environment.Exit(0);
                    //}
                    //else
                    //{
                    //    e.Cancel = true;
                    //}
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }
        }

        private async void ShowQuitDialogAsync()
        {
            MsgAction result = await HandyControl.Controls.Dialog.Show<OperateGrandDialog>()
                    .Initialize<OperateGrandDialogViewModel>((vm) => { vm.Clear(); vm.SetDialog(true); }).GetResultAsync<MsgAction>();
            if (result.o1 is string password)
            {
                if (!"123456".Equals(password))
                {
                    Growl.Error("退出失败，认证密码错误！");
                    return;
                }
                mLog.Status(true, "调度关闭");
                PubMaster.Warn.Stop();
                PubTask.Stop();
                PubMaster.StopMaster();
                Environment.Exit(0);
            }
        }

        private void Window_Loaded(object sender, System.Windows.RoutedEventArgs e)
        {
            PubMaster.StartMaster();
            PubTask.Start();
            Sprite.Show(new WaringCtl());
            mLog.Status(true, "调度启动");
        }
    }
}
