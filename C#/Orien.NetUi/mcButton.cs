
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;

namespace Orien.NetUi {
    internal class mcButton : Button {
        public Color FillColor { get; set; } = Color.Gray;
        public Color TextColor { get; set; } = Color.White;
        public Color TransparentColor { get; set; } = Color.FromArgb(0, 0, 50, 50);
        public int CornerRadius { get; set; } = 15;
        public int Diminisher { get; set; } = 1;
        public float BorderThickness { get; set; } = 2;
        public Color BorderColor { get; set; } = Color.Black;
        public mcButton() {
        }

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

            float cr = CornerRadius;
            float di = Diminisher;
            GraphicsPath path = new GraphicsPath();
            path.AddArc(rect.X, rect.Y, cr, cr, 180, 90);
            path.AddArc(rect.X + rect.Width - cr - di, rect.Y, cr, cr, 270, 90);
            path.AddArc(rect.X + rect.Width - cr - di, rect.Y + rect.Height - cr - di, cr, cr, 0, 90);
            path.AddArc(rect.X, rect.Y + rect.Height - cr - di, cr, cr, 90, 90);
            path.CloseAllFigures();
            return path;
        }


        /*GraphicsPath GetRoundPath(RectangleF Rect, float radius) {
            float r2 = radius / 2f;
            GraphicsPath GraphPath = new GraphicsPath();
            GraphPath.AddArc(Rect.X, Rect.Y, radius, radius, 180, 90);
            GraphPath.AddLine(Rect.X + r2, Rect.Y, Rect.Width - r2, Rect.Y);
            GraphPath.AddArc(Rect.X + Rect.Width - radius, Rect.Y, radius, radius, 270, 90);
            GraphPath.AddLine(Rect.Width, Rect.Y + r2, Rect.Width, Rect.Height - r2);
            GraphPath.AddArc(Rect.X + Rect.Width - radius,
                             Rect.Y + Rect.Height - radius, radius, radius, 0, 90);
            GraphPath.AddLine(Rect.Width - r2, Rect.Height, Rect.X + r2, Rect.Height);
            GraphPath.AddArc(Rect.X, Rect.Y + Rect.Height - radius, radius, radius, 90, 90);
            GraphPath.AddLine(Rect.X, Rect.Height - r2, Rect.X, Rect.Y + r2);
            GraphPath.CloseFigure();
            return GraphPath;
        }

        protected override void OnPaint(PaintEventArgs e) {
            base.OnPaint(e);
            RectangleF Rect = new RectangleF(0, 0, this.Width, this.Height);
            using ( GraphicsPath GraphPath = GetRoundPath(Rect, CornerRadius) ) {
                this.Region = new Region(GraphPath);
                using ( Pen pen = new Pen(Color.CadetBlue, 1.75f) ) {
                    pen.Alignment = PenAlignment.Inset;
                    e.Graphics.DrawPath(pen, GraphPath);
                }
            }
        }*/
    }
}