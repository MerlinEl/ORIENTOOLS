using Orien.Tools;
using System;
using System.ComponentModel;
using System.Drawing;
using System.Threading;
using System.Windows.Forms;

namespace Orien.NetUi {
    public class McPopUpProgressBar : Form {

        // Private Variables
        private readonly bool Debug = false;
        private Size form_size = new Size(800, 600);
        private readonly string progb_title = "";
        private readonly bool NeedConfirmToClose = false;
        private readonly bool ShowConfirmButtonOnDone = false;

        // Ui variables
        private readonly McButton btn_ok = new McButton();
        private readonly McLabel lbl_title = new McLabel();
        private readonly McProgressBarCircular prog_bar = new McProgressBarCircular();
        public McPopUpProgressBar() { }
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
        public McPopUpProgressBar(string title, bool confirmToClose = false, bool showButtonOnDone = false, bool debug = false) {

            //init
            NeedConfirmToClose = confirmToClose;
            ShowConfirmButtonOnDone = showButtonOnDone;
            progb_title = title;
            Debug = debug;
            Console.WriteLine("McPopUpProgressBar > Debug Mode:{0}", Debug);

            //Form setup
            Point form_center = new Point(form_size.Width / 2, form_size.Height / 2);
            Size = form_size;
            FormBorderStyle = FormBorderStyle.None; // Remove the title bar in Form
            BackColor = McUiGlobal.TRANSPARENT_COLOR;
            AllowTransparency = true;
            TransparencyKey = McUiGlobal.TRANSPARENT_COLOR;

            //Progressbar setup
            prog_bar.Anchor = AnchorStyles.None;
            prog_bar.Font = new Font("Impact", 30F, FontStyle.Regular, GraphicsUnit.Point, 178);
            prog_bar.ForeColor = Color.FromArgb(215, 247, 122);
            prog_bar.BackColor = Color.Transparent; //center circle transparent color
            prog_bar.FillWidth = 22;
            prog_bar.FillColorEnd = Color.FromArgb(253, 227, 43);
            prog_bar.FillColorStart = Color.FromArgb(0, 189, 53);
            prog_bar.CenterLineColor = Color.FromArgb(78, 139, 126);
            prog_bar.BorderLineColor = Color.FromArgb(241, 252, 46);
            prog_bar.BorderLineWidth = 4;
            prog_bar.Size = new Size(248, 248); //perimeter
            prog_bar.Location = McMath.GetBoundsCenter(Bounds, prog_bar.Bounds);
            prog_bar.Name = "progBar";
            prog_bar.Value = 0;
            prog_bar.ProgressShape = McProgressBarCircular.ProgressBarShape.Round; //make fill rounded ends

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
            lbl_title.Location = McMath.GetBoundsCenter(prog_bar.Bounds, lbl_title.Bounds, lbl_offset);
            lbl_title.MouseDown += new MouseEventHandler(OnTitleMouseDown);

            //Button OK setup
            btn_ok.Size = new Size(40, 40);
            btn_ok.Name = "btnOK";
            btn_ok.Location = new Point(30, 30);
            btn_ok.ForeColor = Color.FromArgb(215, 247, 122);
            btn_ok.BackColor = Color.FromArgb(29, 84, 56);
            btn_ok.BackDownColor = Color.FromArgb(5, 62, 32);
            btn_ok.BorderColor = Color.FromArgb(148, 194, 15);
            btn_ok.BorderOverColor = Color.FromArgb(215, 247, 122);
            btn_ok.BorderThickness = 2;
            btn_ok.CornerRadius = 20;
            btn_ok.Text = "OK";
            btn_ok.Visible = false;
            Point btn_offset = new Point(0, -50);
            btn_ok.Location = McMath.GetBoundsCenter(prog_bar.Bounds, btn_ok.Bounds, btn_offset); // offset button

            // Add event handlers 
            btn_ok.MouseUp += new MouseEventHandler(OnButtonOkClick);
            if ( debug ) {
                prog_bar.Click += new EventHandler(OnClick);
            }

            //if ( debug ) prog_bar.Click += new EventHandler(onClick);

            //Add controls in to form
            Controls.AddRange(new Control[] { btn_ok, prog_bar, lbl_title });
        }
        // On left button, let the user drag the form.
        private void OnTitleMouseDown(object sender, MouseEventArgs e) {
            if ( e.Button == MouseButtons.Left ) {
                // Release the mouse capture started by the mouse down.
                lbl_title.Capture = false;

                // Create and send a WM_NCLBUTTONDOWN message.
                const int WM_NCLBUTTONDOWN = 0x00A1;
                const int HTCAPTION = 2;
                Message msg =
                    Message.Create(this.Handle, WM_NCLBUTTONDOWN,
                        new IntPtr(HTCAPTION), IntPtr.Zero);
                this.DefWndProc(ref msg);
            }
        }
        private void OnButtonOkClick(object sender, MouseEventArgs e) => Close();
        public void ShowOkButton(bool val) => btn_ok.Visible = val;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="val">percentage values between 1-100</param>
        public void ProgressTo(int val) {

            int percent = McMath.MinMax(val, 1, 100); //min-max val correction
                                                      //System.Threading.Thread.Sleep(1);
            prog_bar.Value = percent;
            prog_bar.Update();
            //Console.WriteLine("Thread ProgressTo > Percent:" + percent.ToString());
            if ( percent == 100 ) { //when is finished
                Console.WriteLine("Thread ProgressTo > Done At:" + percent.ToString());
                if ( NeedConfirmToClose ) {
                    if ( ShowConfirmButtonOnDone ) {
                        ShowOkButton(true);
                    }
                } else {
                    Close();
                }
            }
        }
        public void AnimateText(int val) {
            //Console.WriteLine("Thread AnimateText > Dot_Counter:" + val.ToString());
            lbl_title.Text = progb_title + McString.Multiply(".", val);
            lbl_title.Update();
        }
        public void Reset() {
            lbl_title.Text = progb_title;
            prog_bar.Value = 0;
            btn_ok.Visible = false;
        }

        // Debug
        readonly int Total_Steps = 500;
        bool Simulation_In_Progress = false;
        BackgroundWorker Progress_Worker;
        BackgroundWorker Animate_Worker;
        public void OnClick(object sender, EventArgs e) {

            if ( !Simulation_In_Progress ) {

                Simulation_In_Progress = true;

                // simulate progress
                Progress_Worker = new BackgroundWorker {
                    WorkerReportsProgress = true,
                    WorkerSupportsCancellation = true
                };
                Progress_Worker.DoWork += new DoWorkEventHandler(BackgroundWorker1_DoWork);
                Progress_Worker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(BackgroundWorker1_RunWorkerCompleted);
                Progress_Worker.ProgressChanged += new ProgressChangedEventHandler(RackgroundWorker1_ProgressChanged);
                Progress_Worker.RunWorkerAsync(0);

                // animate label dots           
                Animate_Worker = new BackgroundWorker {
                    WorkerReportsProgress = true,
                    WorkerSupportsCancellation = true
                };
                Animate_Worker.DoWork += new DoWorkEventHandler(BackgroundWorker2_DoWork);
                Animate_Worker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(BackgroundWorker2_RunWorkerCompleted);
                Animate_Worker.ProgressChanged += new ProgressChangedEventHandler(BackgroundWorker2_ProgressChanged);
                Animate_Worker.RunWorkerAsync(0);
                //if ( !Animate_Worker.IsBusy ) Animate_Worker.RunWorkerAsync();

            } else {
                Progress_Worker.CancelAsync();
                Animate_Worker.CancelAsync();
                Progress_Worker.Dispose();
                Animate_Worker.Dispose();
                Simulation_In_Progress = false;
                Reset();
            }
        }

        private void BackgroundWorker1_DoWork(object sender, DoWorkEventArgs e) {
            BackgroundWorker worker = sender as BackgroundWorker; // Get the BackgroundWorker that raised this event.
            int n = (int)e.Argument;
            if ( n > Total_Steps ) {
                throw new ArgumentException("value must be < " + Total_Steps.ToString(), "n");
            }
            long result = 0;
            if ( worker.CancellationPending ) {

                e.Cancel = true;

            } else {
                do {
                    n++;
                    int percentComplete = (int)( 100.0 / Total_Steps * n );
                    result = percentComplete;
                    Thread.Sleep(10);
                    worker.ReportProgress(percentComplete);
                } while ( n <= Total_Steps );
            }
            // Assign value to the result (This is will be available in RunWorkerCompleted eventhandler)
            e.Result = result;
        }

        private void BackgroundWorker2_DoWork(object sender, DoWorkEventArgs e) {
            BackgroundWorker worker = sender as BackgroundWorker; // Get the BackgroundWorker that raised this event.
            int n = (int)e.Argument;
            long result = n;
            if ( worker.CancellationPending ) {

                e.Cancel = true;

            } else {
                do {
                    n = n < 3 ? n + 1 : 0; //progress or reset
                    Thread.Sleep(500);
                    // Report progress as a percentage of the total task.
                    worker.ReportProgress(n);
                } while ( Simulation_In_Progress );
            }
            // Assign value to the result (This is will be available in RunWorkerCompleted eventhandler)
            e.Result = result;
        }

        // This event handler updates the progress bar.
        private void RackgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e) {
            ProgressTo(e.ProgressPercentage);
        }
        // This event handler updates the animated label.
        private void BackgroundWorker2_ProgressChanged(object sender, ProgressChangedEventArgs e) {
            AnimateText(e.ProgressPercentage);
        }

        private void BackgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e) {
            // First, handle the case where an exception was thrown.
            if ( e.Error != null ) {
                MessageBox.Show(e.Error.Message);
            } else if ( e.Cancelled ) {
                Simulation_In_Progress = false;
                // Next, handle the case where the user canceled the operation.
            } else {
                Simulation_In_Progress = false;
                // Finally, handle the case where the operation succeeded.
            }
        }

        private void BackgroundWorker2_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e) {
            // First, handle the case where an exception was thrown.
            if ( e.Error != null ) {
                MessageBox.Show(e.Error.Message);
            } else if ( e.Cancelled ) {
                Simulation_In_Progress = false;
                // Next, handle the case where the user canceled the operation.
            } else {
                Simulation_In_Progress = false;
                // Finally, handle the case where the operation succeeded.
            }
        }
    }
}
