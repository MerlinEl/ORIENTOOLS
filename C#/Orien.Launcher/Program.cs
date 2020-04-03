using Orien.NetUi;
using Orien.Tools;
using System;
using System.Drawing;
using System.Dynamic;
using System.Windows.Forms;
using WinFormAnimation;

namespace Orien.Launcher {
    class Program {
        static void Main(string[] args) {

            Console.WriteLine("Orien Tools Solution START!");
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(createForm());
            Console.ReadLine();
            //DynObjTest2();
        }

        public static Form createForm() {
            //variables
            Size form_size = new Size(800, 600);
            Point form_center = new Point(form_size.Width / 2, form_size.Height / 2);
            //ui
            Form form = new Form();
            Button btn_01 = new Button();
            mcRadialProgressBar progb = new mcRadialProgressBar();
            //form setup
            form.Size = form_size;
            form.BackColor = mcGlobal.TRANSPARENT_COLOR;
            form.AllowTransparency = true;
            form.TransparencyKey = mcGlobal.TRANSPARENT_COLOR;
            //button setup
            btn_01.Size = new Size(40, 40);
            btn_01.Location = new Point(30, 30);
            btn_01.Text = "Run";
            btn_01.Click += new EventHandler(onBtn_01_Click);
            void onBtn_01_Click(object sender, EventArgs e) {
                progb.Reset();
                for ( int i = 0; i <= 100; i++ ) {
                    progb.Value = i;
                    progb.Text = i.ToString() + "%";
                }
            }
            //progressbar setup
            progb.AnimationFunction = KnownAnimationFunctions.Liner;
            progb.Anchor = AnchorStyles.None;
            progb.AnimationSpeed = 500;
            progb.BackColor = Color.Transparent;
            progb.Font = new Font("Impact", 30F, FontStyle.Regular, GraphicsUnit.Point, 178);
            progb.ForeColor = Color.FromArgb(215, 247, 122);
            progb.InnerColor = mcGlobal.TRANSPARENT_COLOR; //inner circle color
            progb.InnerMargin = 0;
            progb.InnerWidth = -1;
            progb.Size = new Size(248, 248); //perimeter
            Console.WriteLine("progb canter:"+ mcMath.GetBoundsCenter(form.Bounds, progb.Bounds).ToString());
            progb.Location = mcMath.GetBoundsCenter(form.Bounds, progb.Bounds);
            progb.MarqueeAnimationSpeed = 2000;
            progb.Name = "Pop_Up_Progress_Bar";
            progb.OuterColor = Color.Gray; //progress background color
            progb.OuterMargin = -25;
            progb.OuterWidth = 26;
            progb.ProgressColor = Color.FromArgb(0, 255, 0);
            progb.ProgressWidth = 20; //circle thickness
            progb.SubscriptText = "";
            progb.SuperscriptText = "";
            progb.TabIndex = 8;
            progb.Text = "0%";
            progb.TextMargin = new Padding(0, -5, 0, 0);
            progb.Value = 0;

            mcLabel lbl_title = new mcLabel();
            lbl_title.TextColor = Color.FromArgb(200, 200, 220);
            lbl_title.FillColor = Color.FromArgb(80, 80, 100);
            lbl_title.Font = new Font("Arial", 16F, FontStyle.Regular);
            lbl_title.Text = "Processing...";
            lbl_title.BorderColor = lbl_title.TextColor;
            lbl_title.BorderThickness = (float)1.4;
            lbl_title.Padding = new Padding(4); //grow text background bit
            lbl_title.CornerRadius = lbl_title.Height;
            //move label center-top on progressbar
            Point lbl_offset = new Point (0, lbl_title.Height + progb.Height / 2);
            lbl_title.Location = mcMath.GetBoundsCenter(progb.Bounds, lbl_title.Bounds, lbl_offset);

            //Add controls in to form
            form.Controls.AddRange(new Control[] { btn_01, progb, lbl_title });
            return form;
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
