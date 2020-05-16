using Orien.Launcher.Properties;
using Orien.NetUi;
using System;
using System.Drawing;
using System.Windows.Forms;

namespace Orien.Launcher {

    internal class Program {
        public static bool Exit { get; private set; }
        public static McConsole CConsole;

        [STAThread] //required for full COM support
        private static void Main() {

            /*Environment.SetEnvironmentVariable("CopyFilesOnBuild", "false");
            string value = Environment.GetEnvironmentVariable("CopyFilesOnBuild");
            if ( value == null ) Console.WriteLine("Enviroment variable CopyFilesOnBuild > value:{0}", value);*/

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Console.WriteLine("Orien Tools Solution START!");

            /*Thread t = new Thread(new ThreadStart(TestRadialProgressBar));
            t.Start();
            Console.ReadLine();*/

            //Application.Run(TestRadialProgressBar());
            TestRadialProgressBar();
            while (!Exit) {
                Application.DoEvents(); //Now if you call "form.Show()" your form won´t be frozen
                //Do your stuff
            };
        }
        //public static Form TestRadialProgressBar() {
        //}
        public static void TestRadialProgressBar() {
            /*McPopup.Options options = new McPopup.Options {
                ConfirmToClose = true
            };
            Form progBar = McPopup.Create("Processing geometry calculations", "", McPopup.WindowType.E_Progress, options);*/
            //progb.Show();

            /*McImageToolTip myToolTip1 = new McImageToolTip {
                AutoSize = false,
                Size = new Size(400, 128),
                ToolTipTitle = "Button Tooltip"
            };
            //myToolTip1.IsBalloon = false;
            myToolTip1.SetFont("Verdana", 12, FontStyle.Bold, Color.FromArgb(0, 32, 64));
            myToolTip1.BorderColor = Color.FromArgb(1, 247, 46);
            myToolTip1.SetToolTip(progBar, "Button 1. ToolTip with Image");*/

            Form form = new Form {
                Size = new Size(400, 200)
            };
            Button btn = new Button {
                Text = "Tooltip Test"
            };
            form.Controls.Add(btn);

            McTooltip tltp = new McTooltip {

                HeaderText = "The Title",
                BodyText = "Button 1. ToolTip with Image",
                FooterText = "For Help press F1",
                BodyImageStretch = true,
                ExtendedMode = true,
                AutoHide = false,
                DebugMode = true,
                BodyTextFont = new Font("Arial", 12, FontStyle.Regular),
                //MaxSize = new Size(100, 300)
                MaxSize = new Size(400, 400)
            };
            tltp.SetToolTip(btn, Resources.tltp_flatten_01);
            //progBar.Tag = Resources.tltp_flatten_01;

            form.Show();


            CConsole = new McConsole(form);
            CConsole.Log("hello!"); // main console tab
            CConsole.Log("", "The {0} is {1} years old.", "Tifany", 12); // main console tab
            CConsole.Log("The {0} is {1} years old.", new object[] {"Tifany", 12}); // main console tab
            CConsole.Log("Console", "The {0} is {1} years old.", "Tifany", 12); // main console tab
            CConsole.Log("The {0} is {1} years old.", new object[] {"John", 33});
            CConsole.Log("Personal", "hello Body"); //ok
            CConsole.Log("Formated", "The {0} is {1} years old.", new object[] { "Monika", 22});

            DialogResult result = McInputBox.Show(
                "Input Required",
                "Please enter the value (if available) below.",
                "Value",
                out string output,
                true
            );
            if (result != DialogResult.OK) {
                return;
            }
            CConsole.Log("Input result:" + result + " output:" + output);
        }

            /*public static void CreateTestForm() {
                _ = new Size(800, 600);
                Form aForm = new Form {
                    Text = @"About Us"
                };
                aForm.Controls.Add(new Label() { Text = "Version 5.0" });
                aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
            }*/

            /*public static void TestRoundLabel() {
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
            }*/
        }
}