using Orien.NetUi;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Orien.Launcher {
    class Program {
        static void Main(string[] args) {

            testRoundLabel();
        }
        public static void createTestForm() {

            Form aForm = new Form();
            aForm.Text = @"About Us";
            aForm.Controls.Add(new Label() { Text = "Version 5.0" });
            aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
        }
        public static void testRoundLabel() {

            Form aForm = new Form();
            aForm.Text = @"Label test:";
            aForm.Controls.Add(new mcLabel() {
                Text = "Version 5.0",
                Location = new Point(60, 20),
                FillColor = Color.FromArgb(255, 0, 0),
                TextColor = Color.FromArgb(0,255,0)
            }); 
            aForm.ShowDialog();  // Or just use Show(); if you don't want it to be modal.
        }
    }
}
