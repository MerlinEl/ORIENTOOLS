using System;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;

namespace Orien.NetUi {
    class McProgressBarCircular : Control {
        #region Enums

        public enum ProgressBarShape {
            Round,
            Flat
        }

        public enum ProgressTextType {
            None,
            Value,
            Percentage,
            Custom
        }

        #endregion

        #region Private Variables

        private long _Value;
        private long _Maximum = 100;
        private int _CenterLineWitdh = 1;
        private float _FillWidth = 14f;
        private float _BorderLineWitdh = 2f;

        private Color _FillColorEnd = Color.Orange;
        private Color _FillColorStart = Color.Orange;
        private Color _CenterLineColor = Color.Silver;
        private Color _BorderLineColor = Color.Gold;
        private LinearGradientMode _GradientMode = LinearGradientMode.ForwardDiagonal;
        private ProgressBarShape ProgressShapeVal;
        private ProgressTextType ProgressTextMode;

        #endregion

        #region Contructor

        public McProgressBarCircular() {
            SetStyle(ControlStyles.SupportsTransparentBackColor, true);
            SetStyle(ControlStyles.Opaque, true);
            this.BackColor = SystemColors.Control;
            this.ForeColor = Color.DimGray;

            this.Size = new Size(130, 130);
            this.Font = new Font("Segoe UI", 15);
            this.MinimumSize = new Size(100, 100);
            this.DoubleBuffered = true;

            this.CenterLineWidth = 1;
            this.CenterLineColor = Color.DimGray;

            this.BorderLineWidth = 1;
            this.BorderLineColor = Color.DimGray;

            Value = 57;
            ProgressShape = ProgressBarShape.Flat;
            TextMode = ProgressTextType.Percentage;
        }

        #endregion

        #region Public Custom Properties

        /// <summary>Determine the Value of Progress</summary>
        [Description("Integer value that determines the position of the Progress Bar."), Category("Behavior")]
        public long Value {
            get { return _Value; }
            set {
                if (value > _Maximum) {
                    value = _Maximum;
                }

                _Value = value;
                Invalidate();
            }
        }

        [Description("Gets or Sets the Maximum Value of the Progress bar."), Category("Behavior")]
        public long Maximum {
            get { return _Maximum; }
            set {
                if (value < 1) {
                    value = 1;
                }

                _Maximum = value;
                Invalidate();
            }
        }

        [Description("Initial Color of Progress Bar"), Category("Appearance")]
        public Color FillColorEnd {
            get { return _FillColorEnd; }
            set {
                _FillColorEnd = value;
                Invalidate();
            }
        }

        [Description("Final Color of Progress Bar"), Category("Appearance")]
        public Color FillColorStart {
            get { return _FillColorStart; }
            set {
                _FillColorStart = value;
                Invalidate();
            }
        }

        [Description("Progress Bar Width"), Category("Appearance")]
        public float FillWidth {
            get { return _FillWidth; }
            set {
                _FillWidth = value;
                Invalidate();
            }
        }

        [Description("Color Gradient Mode"), Category("Appearance")]
        public LinearGradientMode GradientMode {
            get { return _GradientMode; }
            set {
                _GradientMode = value;
                Invalidate();
            }
        }

        [Description("Intermediate Line Color"), Category("Appearance")]
        public Color CenterLineColor {
            get { return _CenterLineColor; }
            set {
                _CenterLineColor = value;
                Invalidate();
            }
        }

        [Description("Width of the Intermediate Line"), Category("Appearance")]
        public int CenterLineWidth {
            get { return _CenterLineWitdh; }
            set {
                _CenterLineWitdh = value;
                Invalidate();
            }
        }

        [Description("Border Line Color"), Category("Appearance")]
        public Color BorderLineColor {
            get { return _CenterLineColor; }
            set {
                _BorderLineColor = value;
                Invalidate();
            }
        }

        [Description("Width of the Border Line"), Category("Appearance")]
        public int BorderLineWidth {
            get { return _CenterLineWitdh; }
            set {
                _BorderLineWitdh = value;
                Invalidate();
            }
        }


        [Description("Gets or Sets the Shape of the terminals of the progress bar."), Category("Appearance")]
        public ProgressBarShape ProgressShape {
            get { return ProgressShapeVal; }
            set {
                ProgressShapeVal = value;
                Invalidate();
            }
        }

        [Description("Gets or Sets the Mode as the Text is displayed inside the Progress bar."), Category("Behavior")]
        public ProgressTextType TextMode {
            get { return ProgressTextMode; }
            set {
                ProgressTextMode = value;
                Invalidate();
            }
        }

        [Description("Get the Text displayed inside the Control"), Category("Behavior")]
        public override string Text { get; set; }

        #endregion

        #region EventArgs

        protected override void OnResize(EventArgs e) {
            base.OnResize(e);
            SetStandardSize();
        }

        protected override void OnSizeChanged(EventArgs e) {
            base.OnSizeChanged(e);
            SetStandardSize();
        }

        protected override void OnPaintBackground(PaintEventArgs p) {
            base.OnPaintBackground(p);
        }

        #endregion

        #region Methods

        private void SetStandardSize() {
            int _Size = Math.Max(Width, Height);
            Size = new Size(_Size, _Size);
        }

        public void Increment(int Val) {
            this._Value += Val;
            Invalidate();
        }

        public void Decrement(int Val) {
            this._Value -= Val;
            Invalidate();
        }
        #endregion

        #region Events

        protected override void OnPaint(PaintEventArgs e) {
            base.OnPaint(e);
            using (Bitmap bitmap = new Bitmap(this.Width, this.Height)) {
                using (Graphics graphics = Graphics.FromImage(bitmap)) {
                    graphics.InterpolationMode = InterpolationMode.HighQualityBilinear;
                    graphics.CompositingQuality = CompositingQuality.HighQuality;
                    graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    graphics.SmoothingMode = SmoothingMode.AntiAlias;

                    //graphics.Clear(Color.Transparent); //<-- this.BackColor, SystemColors.Control, Color.Transparent

                    PaintTransparentBackground(this, e);

                    // Draw the inner white circle:
                    using (Brush mBackColor = new SolidBrush(this.BackColor)) {
                        graphics.FillEllipse(mBackColor,
                                18, 18,
                                (this.Width - 0x30) + 12,
                                (this.Height - 0x30) + 12);
                    }

                    // Draw the thin gray line in the middle:
                    using (Pen pen2 = new Pen(CenterLineColor, this.CenterLineWidth)) {
                        graphics.DrawEllipse(pen2,
                            18, 18,
                          (this.Width - 0x30) + 12,
                          (this.Height - 0x30) + 12);
                    }

                    // Draw the Progressbar Border
                    FillArc(graphics, new SolidBrush(_BorderLineColor), this.FillWidth + _BorderLineWitdh, this._Value);

                    // Draw the Progressbar Gradient Fill
                    using (LinearGradientBrush brush = new LinearGradientBrush(ClientRectangle, _FillColorEnd, _FillColorStart, GradientMode)) {

                        FillArc(graphics, brush, this.FillWidth, this._Value);
                    }

                    #region Draw the Progress Text

                    switch (this.TextMode) {
                        case ProgressTextType.None:
                            this.Text = string.Empty;
                            break;

                        case ProgressTextType.Value:
                            this.Text = _Value.ToString();
                            break;

                        case ProgressTextType.Percentage:
                            this.Text = Convert.ToString(Convert.ToInt32((100 / _Maximum) * _Value)) + " %";
                            break;

                        default:
                            break;
                    }

                    if (this.Text != string.Empty) {
                        using (Brush FontColor = new SolidBrush(this.ForeColor)) {
                            int ShadowOffset = 2;
                            SizeF MS = graphics.MeasureString(this.Text, this.Font);
                            SolidBrush shadowBrush = new SolidBrush(Color.FromArgb(100, this.ForeColor));

                            //Sombra del Texto:
                            graphics.DrawString(this.Text, this.Font, shadowBrush,
                                Convert.ToInt32(Width / 2 - MS.Width / 2) + ShadowOffset,
                                Convert.ToInt32(Height / 2 - MS.Height / 2) + ShadowOffset
                            );

                            //Texto del Control:
                            graphics.DrawString(this.Text, this.Font, FontColor,
                                Convert.ToInt32(Width / 2 - MS.Width / 2),
                                Convert.ToInt32(Height / 2 - MS.Height / 2));
                        }
                    }

                    #endregion

                    // Here is drawn all the Control:
                    e.Graphics.DrawImage(bitmap, 0, 0);
                    graphics.Dispose();
                    bitmap.Dispose();
                }
            }
        }

        private static void PaintTransparentBackground(Control c, PaintEventArgs e) {
            if (c.Parent == null || !Application.RenderWithVisualStyles) {
                return;
            }

            ButtonRenderer.DrawParentBackground(e.Graphics, c.ClientRectangle, c);
        }

        private void FillArc(Graphics graphics, Brush brush, float thickness, long value) {

            using (Pen pen = new Pen(brush, thickness)) {
                switch (this.ProgressShapeVal) {
                    case ProgressBarShape.Round:
                        pen.StartCap = LineCap.Round;
                        pen.EndCap = LineCap.Round;
                        break;

                    case ProgressBarShape.Flat:
                        pen.StartCap = LineCap.Flat;
                        pen.EndCap = LineCap.Flat;
                        break;
                }
                graphics.DrawArc(pen,
                   0x12, 0x12,
                   (this.Width - 0x23) - 2,
                   (this.Height - 0x23) - 2,
                   -90,
                   (int)Math.Round((360.0 / _Maximum) * value));
            }
        }


        /// <summary> Draw a Color-Filled Circle with the perfect Edges. </summary>
        /// <param name = "g"> 'Canvas' of the Object to draw </param>
        /// <param name = "brush"> Fill color and style </param>
        /// <param name = "centerX"> Center of the Circle, on the X axis </param>
        /// <param name = "centerY"> Center of the Circle, on the Y axis </param>
        /// <param name = "radius"> Radius of the Circle </param>
        /*private void FillCircle(Graphics g, Brush brush, float centerX, float centerY, float radius) {
            g.InterpolationMode = InterpolationMode.HighQualityBilinear;
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.PixelOffsetMode = PixelOffsetMode.HighQuality;
            g.SmoothingMode = SmoothingMode.AntiAlias;

            using ( GraphicsPath gp = new GraphicsPath() ) {
                g.FillEllipse(brush, centerX - radius, centerY - radius,
                          radius + radius, radius + radius);
            }
        }*/

        #endregion
    }
}
