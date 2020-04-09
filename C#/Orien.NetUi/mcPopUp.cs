using Orien.Tools;
using System;
using System.Drawing;
using System.Windows.Forms;

namespace Orien.NetUi {
    public class mcPopUp {
        public mcPopUp() {
        }

        public class ProgBar : Form {

            // Private Variables
            private bool Debug = false;
            private Size form_size = new Size(800, 600);
            private readonly string progb_title = "";
            private readonly bool NeedConfirmToClose = false;
            private readonly bool ShowConfirmButtonOnDone = false;

            // Ui variables
            private readonly mcButton btn_ok = new mcButton();
            private readonly mcLabel lbl_title = new mcLabel();
            private readonly mcRadialProgressBar prog_bar = new mcRadialProgressBar();

            /// <summary>
            /// Create Radial ProgressBar with given title
            /// </summary>
            /// <param name="title"></param>
            /// <param name="confirmToClose">Confirm to close PopUp ProgBar</param>
            /// <param name="showButtonOnDone">Show Confirm Button when progress done</param>
            /// <usage>
            /// mcPopUp.ProgBar progb = new mcPopUp.ProgBar("Processing geometry calculations", false, true);
            /// progb.Show();
            /// progb.progressTo(percent); // range [ 1 - 100 ]
            /// </usage>
            public ProgBar(string title, bool confirmToClose = false, bool showButtonOnDone = false, bool debug = false) {

                //init
                NeedConfirmToClose = confirmToClose;
                ShowConfirmButtonOnDone = showButtonOnDone;
                progb_title = title;
                Debug = debug;

                //Form setup
                Point form_center = new Point(form_size.Width / 2, form_size.Height / 2);
                Size = form_size;
                BackColor = mcUiGlobal.TRANSPARENT_COLOR;
                AllowTransparency = true;
                TransparencyKey = mcUiGlobal.TRANSPARENT_COLOR;

                //Progressbar setup
                prog_bar.Anchor = AnchorStyles.None;
                prog_bar.BackColor = Color.Transparent;
                prog_bar.Font = new Font("Impact", 30F, FontStyle.Regular, GraphicsUnit.Point, 178);
                prog_bar.ForeColor = Color.FromArgb(215, 247, 122);
                prog_bar.InnerColor = mcUiGlobal.TRANSPARENT_COLOR; //inner circle color
                prog_bar.InnerMargin = 0;
                prog_bar.InnerWidth = -1;
                prog_bar.Size = new Size(248, 248); //perimeter
                prog_bar.Location = mcMath.GetBoundsCenter(Bounds, prog_bar.Bounds);
                prog_bar.Name = "Pop_Up_Progress_Bar";
                prog_bar.OuterColor = Color.Gray; //progress background color
                prog_bar.OuterMargin = -25;
                prog_bar.OuterWidth = 26;
                prog_bar.ProgressColor = Color.FromArgb(0, 255, 0);
                prog_bar.ProgressWidth = 20; //circle thickness
                prog_bar.SubscriptText = "";
                prog_bar.SuperscriptText = "";
                prog_bar.TabIndex = 8;
                prog_bar.Text = "0%";
                prog_bar.TextMargin = new Padding(0, -5, 0, 0);
                prog_bar.Value = 0;
                prog_bar.Minimum = 0;
                prog_bar.Maximum = 100;

                // Label Title setup
                lbl_title.TextColor = Color.FromArgb(200, 200, 220);
                lbl_title.FillColor = Color.FromArgb(80, 80, 100);
                lbl_title.Font = new Font("Arial", 16F, FontStyle.Regular);
                lbl_title.Text = progb_title;
                lbl_title.BorderColor = lbl_title.TextColor;
                lbl_title.BorderThickness = (float)1.4;
                lbl_title.Padding = new Padding(4); //grow text background bit
                lbl_title.CornerRadius = lbl_title.Height;
                Point lbl_offset = new Point(0, lbl_title.Height + prog_bar.Height / 2); // offset label
                lbl_title.Location = mcMath.GetBoundsCenter(prog_bar.Bounds, lbl_title.Bounds, lbl_offset);

                //Button OK setup
                btn_ok.Size = new Size(40, 40);
                btn_ok.Location = new Point(30, 30);
                btn_ok.ForeColor = Color.FromArgb(215, 247, 122);
                btn_ok.BackColor = Color.FromArgb(29, 84, 56);
                btn_ok.BackDownColor = Color.FromArgb(12, 194, 101);
                btn_ok.BorderColor = Color.FromArgb(148, 194, 15);
                btn_ok.BorderOverColor = Color.FromArgb(215, 247, 122);
                /*
                btn_ok.TextColor = Color.FromArgb(215, 247, 122);
                btn_ok.FillColor = Color.FromArgb(29, 84, 56);
                 */
                btn_ok.BorderThickness = 2;
                btn_ok.CornerRadius = 20;
                btn_ok.Text = "OK";
                btn_ok.Visible = false;
                Point btn_offset = new Point(0, -40);
                btn_ok.Location = mcMath.GetBoundsCenter(prog_bar.Bounds, btn_ok.Bounds, btn_offset); // offset button

                // Add event handlers 
                btn_ok.Click += new EventHandler(onBtn_01_Click);
                if ( debug ) prog_bar.Click += new EventHandler(onClick);

                //if ( debug ) prog_bar.Click += new EventHandler(onClick);

                //Add controls in to form
                Controls.AddRange(new Control[] { btn_ok, prog_bar, lbl_title });
            }
            private void onBtn_01_Click(object sender, EventArgs e) => Close();

            public void showOkButton(bool val) => btn_ok.Visible = val;
            /// <summary>
            /// 
            /// </summary>
            /// <param name="val">percentage values between 1-100</param>
            public void progressTo(int val) {

                int percent = mcMath.minMax(val, 1, 100); //min-max val correction
                System.Threading.Thread.Sleep(1);
                prog_bar.Value = percent;
                prog_bar.Text = percent.ToString() + "%";
                prog_bar.Update();
                //Console.WriteLine("animation:"+prog_bar.AnimationFunction.ToString());
                //Console.WriteLine("progress:" + percent.ToString());
                if ( percent == 100 ) { //when is finished
                    Console.WriteLine("progress done with:" + percent.ToString());
                    if ( NeedConfirmToClose ) {
                        if ( ShowConfirmButtonOnDone ) showOkButton(true);
                    } else Close();
                }
            }
            public void Reset() {
                prog_bar.Value = 0;
                prog_bar.Text = "0%";
                btn_ok.Visible = false;
            }

            // Debug
            public void onClick(object sender, EventArgs e) {

                Reset();
                float total_steps = 500;
                for ( int i = 0; i <= total_steps; i++ ) {
                    double percent = 100.0 / total_steps * i;
                    progressTo((int)percent);
                }
            }
        }
    }
}