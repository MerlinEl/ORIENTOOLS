
using System;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;
/**
CornerRadius " - how far is the edge of the button rounded."
BorderWidth " - specifies the width of edge."
BorderColor " - specifies the color of edge."
Properties on Mouse Over:
BorderOverColor " - specifies the color of edge when mouse is over button."
Properties on Mouse Click:
BackDownColor " - specifies the fill color when button triggers the event "OnMouseDown""        
BackOverColor " - specifies the over color when button triggers the event "OnMouseEnter""        
*/
namespace Orien.NetUi {
    public class McButton : Button {
        public Color TransparentColor { get; set; } = Color.FromArgb(0, 0, 50, 50);
        [Category("Fill"), DisplayName("Fill Down Color")] //FlatAppearance.MouseDownBackColor
        public Color BackDownColor { get; set; } = Color.FromArgb(113, 117, 121); //Invalidate();
        [Category("Fill"), DisplayName("Fill Over Color")] //FlatAppearance.MouseOverBackColor
        public Color BackOverColor { get; set; }
        [Category("Border"), DisplayName("Border Color")]
        public Color BorderColor { get; set; } = Color.FromArgb(181, 190, 198);
        [Category("Border"), DisplayName("Border Over Color")]
        public Color BorderOverColor { get; set; } = Color.FromArgb(208, 210, 212);
        [Category("Border"), DisplayName("Border Width")]
        public float BorderThickness { get; set; } = 1.75f;
        private int corner_radius = 50;
        public bool IsMouseOver { get; private set; }
        private bool IsMouseDown { get; set; }
        public McButton() { }
        [Category("Border"), DisplayName("Border Radius")]
        public int CornerRadius {
            get {
                //b_radius = Math.Min(Math.Min(Height, Width), b_radius);
                return corner_radius;
            }
            set {
                if ( corner_radius == value ) {
                    return;
                }
                //b_radius = Math.Min(Math.Min(Height, Width), value);
                corner_radius = value;
                Invalidate();
            }
        }
        GraphicsPath GetRoundPath(RectangleF Rect, int radius, float width = 0) {
            //Fix radius to rect size
            radius = (int)Math.Max(( Math.Min(radius, Math.Min(Rect.Width, Rect.Height)) - width ), 1);
            float r2 = radius / 2f;
            float w2 = width / 2f;
            GraphicsPath GraphPath = new GraphicsPath();

            //Top-Left Arc
            GraphPath.AddArc(Rect.X + w2, Rect.Y + w2, radius, radius, 180, 90);

            //Top-Right Arc
            GraphPath.AddArc(Rect.X + Rect.Width - radius - w2, Rect.Y + w2, radius, radius, 270, 90);

            //Bottom-Right Arc
            GraphPath.AddArc(Rect.X + Rect.Width - w2 - radius,
                               Rect.Y + Rect.Height - w2 - radius, radius, radius, 0, 90);
            //Bottom-Left Arc
            GraphPath.AddArc(Rect.X + w2, Rect.Y - w2 + Rect.Height - radius, radius, radius, 90, 90);

            //Close line ( Left)           
            GraphPath.AddLine(Rect.X + w2, Rect.Y + Rect.Height - r2 - w2, Rect.X + w2, Rect.Y + r2 + w2);

            //GraphPath.CloseFigure();            

            return GraphPath;
        }
        private void DrawText(Graphics g, RectangleF Rect) {
            float r2 = CornerRadius / 2f;
            float w2 = BorderThickness / 2f;
            Point point = new Point();
            StringFormat format = new StringFormat();

            switch ( TextAlign ) {
                case ContentAlignment.TopLeft:
                point.X = (int)( Rect.X + r2 / 2 + w2 + Padding.Left );
                point.Y = (int)( Rect.Y + r2 / 2 + w2 + Padding.Top );
                format.LineAlignment = StringAlignment.Center;
                break;
                case ContentAlignment.TopCenter:
                point.X = (int)( Rect.X + Rect.Width / 2f );
                point.Y = (int)( Rect.Y + r2 / 2 + w2 + Padding.Top );
                format.LineAlignment = StringAlignment.Center;
                format.Alignment = StringAlignment.Center;
                break;
                case ContentAlignment.TopRight:
                point.X = (int)( Rect.X + Rect.Width - r2 / 2 - w2 - Padding.Right );
                point.Y = (int)( Rect.Y + r2 / 2 + w2 + Padding.Top );
                format.LineAlignment = StringAlignment.Center;
                format.Alignment = StringAlignment.Far;
                break;
                case ContentAlignment.MiddleLeft:
                point.X = (int)( Rect.X + r2 / 2 + w2 + Padding.Left );
                point.Y = (int)( Rect.Y + Rect.Height / 2 );
                format.LineAlignment = StringAlignment.Center;
                break;
                case ContentAlignment.MiddleCenter:
                point.X = (int)( Rect.X + Rect.Width / 2 );
                point.Y = (int)( Rect.Y + Rect.Height / 2 );
                format.LineAlignment = StringAlignment.Center;
                format.Alignment = StringAlignment.Center;
                break;
                case ContentAlignment.MiddleRight:
                point.X = (int)( Rect.X + Rect.Width - r2 / 2 - w2 - Padding.Right );
                point.Y = (int)( Rect.Y + Rect.Height / 2 );
                format.LineAlignment = StringAlignment.Center;
                format.Alignment = StringAlignment.Far;
                break;
                case ContentAlignment.BottomLeft:
                point.X = (int)( Rect.X + r2 / 2 + w2 + Padding.Left );
                point.Y = (int)( Rect.Y + Rect.Height - r2 / 2 - w2 - Padding.Bottom );
                format.LineAlignment = StringAlignment.Center;
                break;
                case ContentAlignment.BottomCenter:
                point.X = (int)( Rect.X + Rect.Width / 2 );
                point.Y = (int)( Rect.Y + Rect.Height - r2 / 2 - w2 - Padding.Bottom );
                format.LineAlignment = StringAlignment.Center;
                format.Alignment = StringAlignment.Center;
                break;
                case ContentAlignment.BottomRight:
                point.X = (int)( Rect.X + Rect.Width - r2 / 2 - w2 - Padding.Right );
                point.Y = (int)( Rect.Y + Rect.Height - r2 / 2 - w2 - Padding.Bottom );
                format.LineAlignment = StringAlignment.Center;
                format.Alignment = StringAlignment.Far;
                break;
                default:
                break;
            }
            using ( Brush brush = new SolidBrush(ForeColor) ) {
                g.DrawString(Text, Font, brush, point, format);
            }
        }
        protected override void OnPaint(PaintEventArgs e) {
            //e.Graphics.SmoothingMode = SmoothingMode.HighQuality;
            e.Graphics.SmoothingMode = SmoothingMode.AntiAlias;
            //e.Graphics.InterpolationMode = InterpolationMode.HighQualityBilinear;
            //e.Graphics.CompositingQuality = CompositingQuality.HighQuality;
            //e.Graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
            //e.Graphics.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;
            RectangleF Rect = new RectangleF(0, 0, this.Width, this.Height);
            Brush brush = new SolidBrush(this.BackColor);
            //Pen pen = new Pen(BorderColor, BorderWidth);

            GraphicsPath GraphPath = GetRoundPath(Rect, CornerRadius);

            this.Region = new Region(GraphPath);

            //Draw Back Color
            if ( IsMouseDown ) {
                using ( Brush mouseDownBrush = new SolidBrush(BackDownColor) ) {
                    e.Graphics.FillPath(mouseDownBrush, GraphPath);
                }
            } else if ( IsMouseOver && !BackOverColor.IsEmpty ) {
                using ( Brush overBrush = new SolidBrush(BackOverColor) ) {
                    e.Graphics.FillPath(overBrush, GraphPath);
                }
            } else {
                e.Graphics.FillPath(brush, GraphPath);
            }

            //Draw Border
            #region DrawBorder

            GraphicsPath GraphInnerPath;
            Pen pen;

            if ( IsMouseDown ) {
                GraphInnerPath = GetRoundPath(Rect, CornerRadius, BorderThickness);
                pen = new Pen(BorderOverColor, BorderThickness);
            } else if ( IsMouseOver ) {
                GraphInnerPath = GetRoundPath(Rect, CornerRadius, BorderThickness);
                pen = new Pen(BorderOverColor, BorderThickness);
            } else {
                GraphInnerPath = GetRoundPath(Rect, CornerRadius, BorderThickness);
                pen = new Pen(BorderColor, BorderThickness);
            }


            pen.Alignment = PenAlignment.Inset;
            if ( pen.Width > 0 ) {
                e.Graphics.DrawPath(pen, GraphInnerPath);
            }
            #endregion

            //Draw Text
            DrawText(e.Graphics, Rect);
        }// End Paint Method
        protected override void OnMouseEnter(EventArgs e) {
            IsMouseOver = true;
            Invalidate();
            base.OnMouseEnter(e);
        }
        protected override void OnMouseLeave(EventArgs e) {
            IsMouseOver = false;
            IsMouseDown = false;
            Invalidate();
            base.OnMouseHover(e);
        }
        protected override void OnMouseDown(MouseEventArgs e) {
            IsMouseDown = true;
            Invalidate();
            base.OnMouseDown(e);
            Capture = true;
        }
        protected override void OnMouseUp(MouseEventArgs e) {
            IsMouseDown = false;
            Invalidate();
            base.OnMouseUp(e);
            Capture = false;
            // Change your color or whatever here
        }
    }
}