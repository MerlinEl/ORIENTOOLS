using Orien.Tools;
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Threading;
using System.Timers;
using System.Windows.Forms;

namespace Orien.NetUi {
    public class mcLabel : Label {
        public Color FillColor { get; set; } = Color.Gray;
        public Color TextColor { get; set; } = Color.White;
        public Color TransparentColor { get; set; } = Color.FromArgb(0, 0, 50, 50);
        public int CornerRadius { get; set; } = 15;
        public int Diminisher { get; set; } = 1;
        public float BorderThickness { get; set; } = 2;
        public Color BorderColor { get; set; } = Color.Black;
        private System.Threading.Timer DotTimer;
        private static string _Text;
        private bool _Autosize;
        private static int Dot_Counter = 0;
        public mcLabel() {

            DoubleBuffered = true;
            AutoSize = true;
            BorderStyle = BorderStyle.None;
        }

        public override string Text {
            get {
                return base.Text;
            }
            set {

                base.Text = value;
                UpdateSize(value);

            }
        }

        public void StartAnimateDots() {

            /*if ( DotTimer == null ) {

                _Text = Text;
                _Autosize = false;
                TimerCallback cb = new TimerCallback(AnimateText);
                DotTimer = new System.Threading.Timer(cb, Text, 4000, 500);

            } else {
         
                Text = _Text;
                _Autosize = AutoSize;
                DotTimer.Dispose();
            }*/
        }

        /*private static void AnimateText(object obj) { 

            //Thread.Sleep(1000);
            Console.WriteLine(Thread.CurrentThread.ManagedThreadId);
            Dot_Counter = Dot_Counter < 3 ? Dot_Counter + 1 : 0; //repeat numbers in range [1 - 3]
            if ( obj is TextBox ) obj = _Text + mcString.Multiply(".", Dot_Counter);
        }*/

        private void UpdateSize(string value) {

            Console.WriteLine("Label UpdateSize..");
            Graphics g = Graphics.FromHwnd(this.Handle);
            SizeF sz = g.MeasureString(value, Font);
            Width = (int)sz.Width;
            Height = (int)sz.Height;
        }

        /*public override Rectangle Bounds {
            get {
                // Create a glyph that is 10x10 and sitting
                // in the middle of the control.  Glyph coordinates
                // are in adorner window coordinates, so we must map
                // using the behavior service.
                Point edge = behaviorSvc.ControlToAdornerWindow(control);
                Size size = Control.Size;
                Point center = new Point(edge.X + ( size.Width / 2 ),
                    edge.Y + ( size.Height / 2 ));

                Rectangle bounds = new Rectangle(
                    center.X - 5,
                    center.Y - 5,
                    10,
                    10);

                return bounds;
            }
        }*/

        protected override void OnPaint(PaintEventArgs e) {

            base.OnPaint(e);
            using ( GraphicsPath graphicsPath = GetRoundRectangle(this.ClientRectangle) ) {
                e.Graphics.SmoothingMode = SmoothingMode.AntiAlias;
                using ( SolidBrush solidBrush = new SolidBrush(FillColor) )
                    e.Graphics.FillPath(solidBrush, graphicsPath);
                using ( Pen pen = new Pen(BorderColor, BorderThickness) )
                    e.Graphics.DrawPath(pen, graphicsPath);
                TextRenderer.DrawText(e.Graphics, this.Text, this.Font, this.ClientRectangle, TextColor);
            }
        }

        private GraphicsPath GetRoundRectangle(Rectangle rect) {

            int cr = CornerRadius;
            int di = Diminisher;
            GraphicsPath path = new GraphicsPath();
            path.AddArc(rect.X, rect.Y, cr, cr, 180, 90);
            path.AddArc(rect.X + rect.Width - cr - di, rect.Y, cr, cr, 270, 90);
            path.AddArc(rect.X + rect.Width - cr - di, rect.Y + rect.Height - cr - di, cr, cr, 0, 90);
            path.AddArc(rect.X, rect.Y + rect.Height - cr - di, cr, cr, 90, 90);
            path.CloseAllFigures();
            return path;
        }
    }
}
