using Orien.Launcher.Properties;
using Orien.NetUi;
using Orien.Tools;
using System;
using System.Drawing;
using System.Dynamic;
using System.Threading;
using System.Windows.Forms;

namespace Orien.Launcher {

    internal class Program {
        public static bool Exit { get; private set; }
        public static McConsole CConsole;

        [STAThread] //required for full COM support
        private static void Main() {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Console.WriteLine("Orien Tools Solution START!");

            /*Thread t = new Thread(new ThreadStart(TestRadialProgressBar));
            t.Start();
            Console.ReadLine();*/

            //Application.Run(TestRadialProgressBar());
            TestRadialProgressBar();
            while ( !Exit ) {
                Application.DoEvents(); //Now if you call "form.Show()" your form won´t be frozen
                //Do your stuff
            };
        }
        //public static Form TestRadialProgressBar() {
        //}
        public static void TestRadialProgressBar() {
            McPopup.Options options = new McPopup.Options {
                ConfirmToClose = true
            };
            Form progBar = McPopup.Create("Processing geometry calculations", "", McPopup.WindowType.E_Progress, options);
            //progb.Show();
            McImageToolTip myToolTip1 = new McImageToolTip {
                AutoSize = false,
                Size = new Size(400, 128),
                ToolTipTitle = "Button Tooltip"
            };
            //myToolTip1.IsBalloon = false;
            myToolTip1.SetFont("Verdana", 12, FontStyle.Bold, McGetCs.NewColor(0, 32, 64));
            myToolTip1.BorderColor = McGetCs.NewColor(1, 247, 46);
            myToolTip1.SetToolTip(progBar, "Button 1. ToolTip with Image");
            progBar.Tag = Resources.tltp_flatten_01;
            progBar.Show();
            CConsole = new McConsole(progBar);
            CConsole.Log("hello");
            CConsole.Log("hello Rene", "Personal");
            CConsole.Log("hello Rene a:{0} b:{1}", "Formated", new object[] { 15, "Custom String" });

            /*
            ToolTip buttonToolTip = newToolTip();
            buttonToolTip.ToolTipTitle = "Button Tooltip";
            buttonToolTip.UseFading = true;
            buttonToolTip.UseAnimation = true;
            buttonToolTip.IsBalloon = true;
            buttonToolTip.ShowAlways = true;
            buttonToolTip.AutoPopDelay = 5000;
            buttonToolTip.InitialDelay = 1000;
            buttonToolTip.ReshowDelay = 500;
            buttonToolTip.SetToolTip(button1, "Click me to execute.");
            */
        }

        public static void CreateTestForm() {
            _ = new Size(800, 600);
            Form aForm = new Form {
                Text = @"About Us"
            };
            aForm.Controls.Add(new Label() { Text = "Version 5.0" });
            aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
        }

        public static void TestRoundLabel() {
            Form aForm = new Form {
                Text = @"Label test:"
            };
            aForm.Controls.Add(new McLabel() {
                Text = "Version 5.0",
                Location = new Point(60, 20),
                FillColor = Color.FromArgb(255, 0, 0),
                TextColor = Color.FromArgb(0, 255, 0)
            });
            aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
        }

        public static void DynObjTest() {
            dynamic person = new McDynObj();
            person.FirstName = "Ellen";
            person.LastName = "Adams";
            Console.WriteLine(person.firstname + " " + person.lastname);
        }

        public static void DynObjTest2() {
            SetMemberBinder bi = new SetMemberBinderChild("hola", false);
            Console.WriteLine("this is: " + bi.Name);
        }
    }
}