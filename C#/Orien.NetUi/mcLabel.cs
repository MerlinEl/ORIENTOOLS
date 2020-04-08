﻿using System;
using System.Drawing;
using System.Drawing.Drawing2D;
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
