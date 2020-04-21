using System;
using System.Drawing;
using System.Dynamic;
using System.Windows.Forms;
using Orien.NetUi;
using Orien.Tools;

namespace Orien.Launcher
{
    class Program
    {
        public static bool Exit { get; private set; }

        [STAThread] //required for full COM support
        static void Main(string[] args)
        {

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Console.WriteLine("Orien Tools Solution START!");

            Application.Run(TestRadialProgressBar());

            //OR
            /*
                TestRadialProgressBar()
                //Do some stuff...
                while ( !Exit ) {
                    Application.DoEvents(); //Now if you call "form.Show()" your form won´t be frozen
                    //Do your stuff
                }
            */

            //OR
            /*
                Console.ReadLine();
            */
        }

        public static Form TestRadialProgressBar()
        {
            mcPopup.Options options = new mcPopup.Options();
            options.ConfirmToClose = true;
            Form progBar = mcPopup.Create("Processing geometry calculations", "", mcPopup.WindowType.E_Progress, options);
            //progb.Show();
            return progBar;
        }

        public static void CreateTestForm()
        {

            Size form_size = new Size(800, 600);
            Form aForm = new Form();
            aForm.Text = @"About Us";
            aForm.Controls.Add(new Label() { Text = "Version 5.0" });
            aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
        }
        public static void TestRoundLabel()
        {

            Form aForm = new Form();
            aForm.Text = @"Label test:";
            aForm.Controls.Add(new mcLabel()
            {
                Text = "Version 5.0",
                Location = new Point(60, 20),
                FillColor = Color.FromArgb(255, 0, 0),
                TextColor = Color.FromArgb(0, 255, 0)
            });
            aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
        }
        public static void DynObjTest()
        {

            dynamic person = new mcDynObj();
            person.FirstName = "Ellen";
            person.LastName = "Adams";
            Console.WriteLine(person.firstname + " " + person.lastname);
        }
        public static void DynObjTest2()
        {

            SetMemberBinder bi = new SetMemberBinderChild("hola", false);
            Console.WriteLine("this is: " + bi.Name);
        }
    }
}
