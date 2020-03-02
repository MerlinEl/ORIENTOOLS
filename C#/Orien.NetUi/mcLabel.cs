using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;

namespace Orien.NetUi {
    public class mcLabel : Label {
        public Color FillColor { get; set; } = Color.Gray;
        public Color TextColor { get; set; } = Color.White;
        private int _cornerRadius = 15;
        private int _diminisher = 1;
        private Color _transparentColor = Color.FromArgb(0, 0, 50, 50);
        public mcLabel() {

            this.DoubleBuffered = true;
        }
        protected override void OnPaint(PaintEventArgs e) {

            base.OnPaint(e);
            using ( GraphicsPath graphicsPath = GetRoundRectangle(this.ClientRectangle) ) {
                e.Graphics.SmoothingMode = SmoothingMode.AntiAlias;
                using ( SolidBrush solidBrush = new SolidBrush(FillColor) )
                    e.Graphics.FillPath(solidBrush, graphicsPath);
                using ( Pen pen = new Pen(this.ForeColor, 1.0f) )
                    e.Graphics.DrawPath(pen, graphicsPath);
                TextRenderer.DrawText(e.Graphics, this.Text, this.Font, this.ClientRectangle, TextColor);
            }
        }
        private GraphicsPath GetRoundRectangle(Rectangle rect) {

            int cr = _cornerRadius;
            int di = _diminisher;
            GraphicsPath path = new GraphicsPath();
            path.AddArc(rect.X, rect.Y, cr, cr, 180, 90);
            path.AddArc(rect.X + rect.Width - cr - di, rect.Y, cr, cr, 270, 90);
            path.AddArc(rect.X + rect.Width - cr - di, rect.Y + rect.Height - cr - di, cr, cr, 0, 90);
            path.AddArc(rect.X, rect.Y + rect.Height - cr - di, cr, cr, 90, 90);
            path.CloseAllFigures();
            return path;
        }
        public int CornerRadius {

            get { return _cornerRadius; }
            set { _cornerRadius = value; }
        }
        public int Diminisher {

            get { return _diminisher; }
            set { _diminisher = value; }
        }
        public Color TransparentColor {

            get { return _transparentColor; }
            set { _transparentColor = value; }
        }
    }
}
