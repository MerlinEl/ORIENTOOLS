using System.Drawing;
using System.Windows.Forms;

namespace Orien.NetUi {
    class McProgressBar : ProgressBar {
        private static readonly StringFormat sfCenter = new StringFormat() {
            Alignment = StringAlignment.Center,
            LineAlignment = StringAlignment.Center
        };
        private Color textColor = DefaultTextColor;
        private string progressString;
        /// <summary>
        /// ProgressBar with percent Label implemented
        /// </summary>
        public McProgressBar() { SetStyle(ControlStyles.AllPaintingInWmPaint, true); }
        protected override void OnCreateControl() {
            progressString = null;
            base.OnCreateControl();
        }
        protected override void WndProc(ref Message m) {
            switch (m.Msg) {
                case 15:
                if (HideBar) base.WndProc(ref m);
                else {
                    ProgressBarStyle style = Style;
                    if (progressString == null) {
                        progressString = Text;
                        if (!HideBar && style != ProgressBarStyle.Marquee) {
                            int range = Maximum - Minimum;
                            int value = Value;
                            if (range > 42949672) { value = (int)((uint)value >> 7); range = (int)((uint)range >> 7); }
                            if (range > 0) progressString = string.Format(progressString.Length == 0 ? "{0}%" : "{1}: {0}%",
                             value * 100 / range, progressString);
                        }
                    }
                    if (progressString.Length == 0) base.WndProc(ref m);
                    else using (Graphics g = CreateGraphics()) {
                            base.WndProc(ref m);
                            OnPaint(new PaintEventArgs(g, ClientRectangle));
                        }
                }
                break;
                case 0x402: goto case 0x406;
                case 0x406:
                progressString = null;
                base.WndProc(ref m);
                break;
                default:
                base.WndProc(ref m);
                break;
            }
        }
        protected override void OnPaint(PaintEventArgs e) {
            Rectangle cr = ClientRectangle;
            RectangleF crF = new RectangleF(cr.Left, cr.Top, cr.Width, cr.Height);
            using (Brush br = new SolidBrush(TextColor))
                e.Graphics.DrawString(progressString, Font, br, crF, sfCenter);
            base.OnPaint(e);
        }
        public bool HideBar {
            get { return GetStyle(ControlStyles.UserPaint); }
            set { if (HideBar != value) { SetStyle(ControlStyles.UserPaint, value); Refresh(); } }
        }
        public static Color DefaultTextColor {
            get { return SystemColors.ControlText; }
        }
        public Color TextColor {
            get { return textColor; }
            set { textColor = value; }
        }
        public override string Text {
            get { return base.Text; }
            set { if (value != Text) { base.Text = value; progressString = null; } }
        }
        public override Font Font {
            get { return base.Font; }
            set { base.Font = value; }
        }
    }
}
