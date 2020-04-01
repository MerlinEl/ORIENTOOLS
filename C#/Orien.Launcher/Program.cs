using Orien.NetUi;
using Orien.Tools;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Orien.Launcher {
    class Program {
        static void Main(string[] args) {

            Console.WriteLine("Orien Tools Solution START!");
            mcRadialProgressBar progb = new mcRadialProgressBar();
            //progb.location
            //DynObjTest2();
            Console.ReadLine();
        }
        public static void CreateTestForm() {

            Form aForm = new Form();
            aForm.Text = @"About Us";
            aForm.Controls.Add(new Label() { Text = "Version 5.0" });
            aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
        }
        public static void TestRoundLabel() {

            Form aForm = new Form();
            aForm.Text = @"Label test:";
            aForm.Controls.Add(new mcLabel() {
                Text = "Version 5.0",
                Location = new Point(60, 20),
                FillColor = Color.FromArgb(255, 0, 0),
                TextColor = Color.FromArgb(0, 255, 0)
            });
            aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
        }
        public static void DynObjTest() {

            dynamic person = new mcDynObj();
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
