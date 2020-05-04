using Orien.Tools;
using System;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows.Forms;
/**
 * 
 *@Example1
 * 
Form form = new Form {
    Size = new Size(400, 200)
};
Button btn = new Button {
    Text = "Tooltip Test"
};
form.Controls.Add(btn);
form.Controls.Add(btn);

McTooltip tltp = new McTooltip {

    HeaderText = "The Title",
    BodyText = "Button 1. ToolTip with Image",
    FooterText = "For Help press F1",
    BodyImageStretch = true,
    ExtendedMode = true,
    AutoHide = false,
    DebugMode = false,
    MaxSize = new Size(100, 300)
};
tltp.SetToolTip(btn, Resources.tltp_flatten_01);
 *
 *@Example2
 * 
private void AddTooltip(Control btn) {
    McTooltip tltp = new McTooltip {
        BodyImageStretch = true,
        ExtendedMode = true,
        DebugMode = false,
        MaxSize = new Size(100, 300)
    };
    //tltp.SetToolTip(btn, "Body ABCD 123456\n\t1\n\t2\nABCD", "Help", "Press F1 for more help");
    string text_body = "Another way to do this is with a TextRenderer, and call its MeasureString method, passing the string and the font type.";
    tltp.SetToolTip(btn, text_body, "How to get a string width", "Press F1 for more help", Resources.tltp_flatten_01);

    propertyGrid1.Name = "propertyGrid1";
    propertyGrid1.TabIndex = 4;
    propertyGrid1.SelectedObject = tltp;
    propertyGrid1.PropertySort = PropertySort.Alphabetical;
}
*/
namespace Orien.NetUi {

    public class McTooltip : Form {

        #region Private Variables

        private enum MorphTypes {
            ALLOW_START = 0,
            WAIT_INIT = 1,
            WAIT_EXPAND = 2,
            WAIT_HIDE = 3,
            EXTEND_MODE = 4,//,
            DISABLED = 5
        }
        private MorphTypes MorphType = MorphTypes.ALLOW_START;
        private Control ParentButtonControl;
        private Timer MorphTimer;
        private bool DrawExtend = false;
        private readonly Timer FadeTimer = new Timer();
        private bool FadeProgress = false;
        private readonly StringFormat TextFormatHeader = new StringFormat {
            LineAlignment = StringAlignment.Center,
            Alignment = StringAlignment.Center,
            //HotkeyPrefix = System.Drawing.Text.HotkeyPrefix.Show, //"&Click Here";
            FormatFlags = StringFormatFlags.NoWrap
        };
        private readonly StringFormat TextFormatFooter = new StringFormat { };
        private readonly TextFormatFlags CenterFlags =
            TextFormatFlags.HorizontalCenter |
            TextFormatFlags.VerticalCenter |
            TextFormatFlags.WordBreak;
        private Size TotalSize;
        private Size headTextSize;
        private Size bodyTextSize;
        private Size bodyImageSize;
        private Size footerTextSize;

        #endregion

        public McTooltip() => InitializeComponent();

        #region Visible Properties

        [CategoryAttribute("Text Input"), DescriptionAttribute(@"Gets or sets the Header text content.")]
        public string HeaderText { get; set; }
        [CategoryAttribute("Text Input"), DescriptionAttribute(@"Gets or sets the Body text content.")]
        public string BodyText { get; set; }
        [CategoryAttribute("Text Input"), DescriptionAttribute(@"Gets or sets the Footer text content.")]
        public string FooterText { get; set; }

        [CategoryAttribute("Text Color"), DescriptionAttribute(@"Gets or sets the Header text color.")]
        public Color HeaderTextColor { get; set; }
        [CategoryAttribute("Text Color"), DescriptionAttribute(@"Gets or sets the Header text back color.")]
        public Color HeaderTextBackColor { get; set; }
        [CategoryAttribute("Text Color"), DescriptionAttribute(@"Gets or sets the Body text color.")]
        public Color BodyTextColor { get; set; }
        [CategoryAttribute("Text Color"), DescriptionAttribute(@"Gets or sets the Footer text color.")]
        public Color FooterTextColor { get; set; }

        [CategoryAttribute("Text Font"), DescriptionAttribute(@"Gets or sets the Header text font.")]
        public Font HeaderextFont { get; set; } = new Font("Verdana", 10, FontStyle.Bold);
        [CategoryAttribute("Text Font"), DescriptionAttribute(@"Gets or sets the Body text font.")]
        public Font BodyTextFont { get; set; } = new Font("Arial", 8);
        [CategoryAttribute("Text Font"), DescriptionAttribute(@"Gets or sets the Footer text font.")]
        public Font FooterTextFont { get; set; } = new Font("Arial", 8);


        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Gets or sets the maximum size of the ToolTip.")]
        public Size MaxSize { get; set; } = new Size(250, 400);
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Gets or sets the type of the ToolTip.")]
        public bool ExtendedMode { get; set; } = false;
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Gets or sets the corner radius of the simple ToolTip.")]
        public int RoundCornersRadius { get; set; } = 8;
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Time before Simple ToolTip will bge hidden.")]
        public int DurationSimple { get; set; } = 4000; // 4sec
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Time before Extended ToolTip will bge hidden.")]
        public int DurationExtended { get; set; } = 6000; // 6sec
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Time pased before ToolTip shown.")]
        public int InitialDelay { get; set; } = 500; // 500ms
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Time which need to pass before ToolTip to be transformed to Extended version.")]
        public int ExtendedDelay { get; set; } = 2000; //2s
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Time which need to pass before ToolTip reshown.")]
        public int ReshowDelay { get; set; } = 500; //2s TODO reshow delay
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Force the ToolTip text to be displayed whether or not the form is active.")]
        public bool ShowAlways { get; set; } = true;
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Keep visible as long the user have mouse under control.")]
        public bool AutoHide { get; set; } = false;
        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Enable - Disable fade in - out.")]
        public bool Animated { get; private set; } = true;

        [CategoryAttribute("Behavior"), DescriptionAttribute(@"Enable - Disable debug mode.")]
        public bool DebugMode { get; set; } = false;

        [CategoryAttribute("Image Settings"), DescriptionAttribute(@"Gets or sets the ToolTip Image.")]
        public Image BodyImage { get; set; }
        [CategoryAttribute("Image Settings"), DescriptionAttribute(@"Gets or sets the Image stretch style.")]
        public bool BodyImageStretch { get; set; }


        [CategoryAttribute("Ui Settings"), DescriptionAttribute(@"Gets or sets the border color for the ToolTip.")]
        public Color BorderColor { get; set; }
        [CategoryAttribute("Ui Settings"), DescriptionAttribute(@"Gets or sets the border thickness for the ToolTip.")]
        public int BorderThickness { get; set; }
        [CategoryAttribute("Ui Settings"), DescriptionAttribute(@"Gets or sets distance between Ui components the ToolTip.")]
        public int UiOffset { get; set; } = 4;

        #endregion


        #region Hidden Properties


        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never), Bindable(false),
        DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public new string AccessibleName { get; set; }
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never), Bindable(false),
        DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public new string Text { get; set; }
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never), Bindable(false),
        DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public new string AccessibleDescription { get; set; }
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never), Bindable(false),
        DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public new bool AcceptButton { get; set; }

        #endregion


        #region Public Methods
        public void SetToolTip(Control control, Bitmap bmp) {

            if (control == null || bmp == null) return;
            SetToolTip(control, BodyText, HeaderText, FooterText, bmp);
        }

        public void SetToolTip(Control control, string imagePath) {

            if (control == null || !File.Exists(imagePath)) return;
            SetToolTip(control, BodyText, HeaderText, FooterText, imagePath);
        }

        public void SetToolTip(Control control, string textBody, string textTitle = "", string textFooter = "", string imagePath = "") {

            if (!File.Exists(imagePath)) return;
            Bitmap bmp;
            using (var bmpTemp = new Bitmap(imagePath)) {
                bmp = new Bitmap(bmpTemp);
            }
            SetToolTip(control, textBody, textTitle, textFooter, bmp);
        }

        public void SetToolTip(Control control, string textBody, string textTitle = "", string textFooter = "", Bitmap bmp = null) {

            if (DebugMode) Console.WriteLine("Set Tooltip > ctrl:{0} textTitle:{1}", control.Name, textTitle);
            ParentButtonControl = control;
            HeaderText = textTitle;
            BodyText = textBody;
            FooterText = textFooter;
            BodyImage = bmp ?? CreateBitmapPlaceholder(100, 100, Color.Green);
            RegisterPopUpEvents(control);
            base.SetTopLevel(true);
        }

        #endregion


        #region Private Methods

        #region Show - Hide

        public void HideTooltip() {
            if (DebugMode) Console.WriteLine("HideTooltip >");
            if (MorphTimer != null) { //dispose timer
                MorphTimer.Stop();
                MorphTimer.Dispose();
            }
            DrawExtend = false;
            ParentButtonControl = null;
            if (Animated) {
                FadeTimer.Stop();
                FadeTimer.Tick -= FadeIn;
                FadeProgress = false;
                HideFadeOut();

            } else {
                Hide();
                MorphType = MorphTypes.ALLOW_START;
            }
        }

        private void ShowTooltip() {
            if (DebugMode) Console.WriteLine("ShowTooltip >");
            UpdateSizeAndPosition();
            TopMost = true;
            if (Animated) ShowFadeIn(); else Show();
        }

        private void ShowFadeIn() {
            FadeProgress = true;
            Opacity = 0; //first the opacity is 0
            Visible = true;
            FadeTimer.Interval = 10;  //we'll increase the opacity every 10ms
            FadeTimer.Tick += FadeIn;  //this calls the function that changes opacity 
            FadeTimer.Start();
        }
        void FadeIn(object sender, EventArgs e) {
            if (Opacity >= 1) {
                FadeTimer.Stop();   //this stops the timer if the form is completely displayed
                FadeProgress = false;
            } else
                Opacity += 0.05;
        }

        private void HideFadeOut() {
            //Removed is not realy need
            //FadeProgress = true;
            //FadeTimer.Interval = 10;  //we'll decerase the opacity every 10ms
            //FadeTimer.Tick += new EventHandler(FadeOut);  //this calls the fade out function
            //FadeTimer.Start();
            Hide();
            MorphType = MorphTypes.ALLOW_START;
        }

        void FadeOut(object sender, EventArgs e) {
            if (Opacity <= 0)     //check if opacity is 0
            {
                FadeTimer.Stop();    //if it is, we stop the timer
                Visible = false;
            } else
                Opacity -= 0.05;
        }

        #endregion

        #region Mouse Events

        private void RegisterPopUpEvents(Control control) {

            if (DebugMode) Console.WriteLine("RegisterPopUpEvents >");
            control.MouseHover += new EventHandler(OnHover);
            control.MouseLeave += new EventHandler(OnLeave);
        }

        private void OnLeave(object sender, EventArgs e) => HideTooltip();
        private void OnHover(object sender, EventArgs e) {
            if (DebugMode) Console.WriteLine("OnHover > MorphType:{0}", MorphType);
            if (MorphType != MorphTypes.ALLOW_START) return;
            MorphType = MorphTypes.WAIT_INIT;
            ParentButtonControl = sender as Control;
            MorphTimer = new Timer {
                Interval = InitialDelay,
                Enabled = true
            };
            MorphTimer.Tick += OnDealayPased;
            MorphTimer.Start();
        }

        #endregion

        private void OnDealayPased(object sender, EventArgs e) {
            if (FadeProgress) return;
            if (DebugMode) Console.WriteLine("OnDealayPased > type:{0} interval:{1}", MorphType, MorphTimer.Interval);
            if (ParentButtonControl == null) { //the user have left control
                MorphType = MorphTypes.DISABLED;
                HideTooltip();
                return;
            }
            switch (MorphType) {

                case MorphTypes.WAIT_INIT:
                    if (DebugMode) Console.WriteLine("\tcase Wait_Init");
                    ShowTooltip(); //show simple ToolTip when InitialDelay pased
                    if (ExtendedMode) { //if user stil have mouse on control and is ExtendMode

                        if (DebugMode) Console.WriteLine("\t\tset WAIT_EXPAND>");
                        MorphType = MorphTypes.WAIT_EXPAND;
                        DrawExtend = false;
                        MorphTimer.Interval = ExtendedDelay; //setup next interval // Math.Abs(ExtendedDelay - InitialDelay);
                    } else {
                        if (DebugMode) Console.WriteLine("\t\tset WAIT_HIDE\n\t\tset Wait to Hide>");
                        MorphType = MorphTypes.WAIT_HIDE;
                        MorphTimer.Interval = DurationSimple;
                    }
                    break;
                case MorphTypes.WAIT_EXPAND:
                    if (DebugMode) Console.WriteLine("\tcase Wait_Expand\n\t\tset WAIT_HIDE and Invalidate");
                    DrawExtend = true;
                    UpdateSizeAndPosition();
                    Invalidate(); //Method will cause a repaint. (invoke onPaint)
                    MorphTimer.Interval = DurationExtended;
                    MorphType = MorphTypes.WAIT_HIDE;
                    break;
                case MorphTypes.WAIT_HIDE:
                    if (DebugMode) Console.WriteLine("\tcase Wait_Hide");
                    if (!AutoHide) HideTooltip();
                    break;
            }
        }
        private void UpdateSizeAndPosition() {

            TotalSize = MaxSize;

            if (DrawExtend) {

                //Get component sizes
                headTextSize = TextRenderer.MeasureText(HeaderText, HeaderextFont);
                headTextSize.Width = TotalSize.Width - UiOffset * 2;
                footerTextSize = TextRenderer.MeasureText(FooterText, FooterTextFont);

                //Calculate total width of Tooltip
                TotalSize.Width = (
                    TotalSize.Width < headTextSize.Width + UiOffset * 2 &&
                    headTextSize.Width + UiOffset * 2 <= TotalSize.Width ?
                    headTextSize.Width + UiOffset * 2 : TotalSize.Width
                );
                // 100000  = max field height
                bodyTextSize = TextRenderer.MeasureText(BodyText, BodyTextFont, new Size(TotalSize.Width, 100000), TextFormatFlags.WordBreak);
                // scale up image or leave it small
                if (BodyImageStretch) {

                    bodyImageSize = ScaleSizeToFitWidth(BodyImage.Size, TotalSize.Width - UiOffset * 2);

                } else {

                    bodyImageSize = ScaleSizeToWidth(BodyImage.Size, TotalSize.Width - UiOffset * 2, TotalSize.Width - UiOffset * 2);
                }

                //Calculate total height of Tooltip
                TotalSize.Height = (
                    headTextSize.Height + UiOffset * 4 +
                    bodyTextSize.Height + UiOffset +
                    bodyImageSize.Height + UiOffset +
                    footerTextSize.Height + UiOffset
                );
                //Update form shape
                this.Region = new Region(new Rectangle(0, 0, TotalSize.Width, TotalSize.Height));

            } else {

                // 100000  = max field height
                bodyTextSize = TextRenderer.MeasureText(BodyText, BodyTextFont, new Size(TotalSize.Width, 100000), TextFormatFlags.WordBreak);
                TotalSize.Height = bodyTextSize.Height + UiOffset * 2;
                //Update form Shape
                GraphicsPath gp = McGra.RoundedRect(new Rectangle(0, 0, TotalSize.Width, TotalSize.Height), RoundCornersRadius);
                this.Region = new Region(gp);

            }
            //Update Form size
            Size = TotalSize;
            Rectangle button_area = ParentButtonControl.Bounds;

            /*Rectangle window_area = ParentButtonControl.Parent != null ? ParentButtonControl.Parent.Bounds : new Rectangle();
            Point location = new Point(
                window_area.Left + button_area.Left + button_area.Width + 2,
                window_area.Top + button_area.Bottom + button_area.Height + 2
            );*/

            // Set the picture location equal to the drop point.
            Point screen_piont = ParentButtonControl.PointToScreen(Point.Empty);
            Point location = new Point(
                screen_piont.X + button_area.Right,
                screen_piont.Y + button_area.Bottom
            );


            //calculate where ToolTip will be shown ( top, bottom, left, right )
            Rectangle screen = Screen.FromControl(ParentButtonControl).WorkingArea;
            if (location.X + Size.Width > (screen.Left + screen.Width)) {

                location.X = (screen.Left + screen.Width) - Size.Width;
            }
            if (location.Y + Size.Height > (screen.Top + screen.Height)) {

                location.Y -= Size.Height + button_area.Height;
            }
            this.Location = location;
        }

        private static Bitmap CreateBitmapPlaceholder(int w, int h, Color clr) {

            Bitmap bmp = new Bitmap(w, h);
            using (Graphics g = Graphics.FromImage(bmp)) { g.Clear(clr); }
            return bmp;
        }
        private Size ScaleSizeToFitWidth(Size size, int maxWidth) {

            var newWidth = maxWidth;
            var ratio = (double)maxWidth / size.Width;
            if (size.Width > maxWidth) newWidth = (int)(size.Width * ratio);
            int newHeight = (int)(size.Height * ratio);
            return new Size(newWidth, newHeight);
        }

        private Size ScaleSizeToWidth(Size size, int maxWidth, int maxHeight) {

            var ratioX = (double)maxWidth / size.Width;
            var ratioY = (double)maxHeight / size.Height;
            var ratio = Math.Min(ratioX, ratioY);

            var newWidth = (int)(size.Width * ratio);
            var newHeight = (int)(size.Height * ratio);

            return new Size(newWidth, newHeight);
        }

        #endregion


        #region Overridden Methods - Events

        protected override void OnPaint(PaintEventArgs e) {

            base.OnPaint(e);
            if (DebugMode) Console.WriteLine("OnPaint > DrawExtend:{0}\n", DrawExtend);

            //Else show extended tooltip
            e.Graphics.CompositingQuality = CompositingQuality.HighQuality;

            //Brushes
            Brush backColorBrush = new SolidBrush(BackColor);
            Brush headerTextBrush = new SolidBrush(HeaderTextColor);
            Brush headerTextBackBrush = new SolidBrush(HeaderTextBackColor);
            Brush footerTextBrush = new SolidBrush(FooterTextColor);
            Brush borderBrush = new SolidBrush(BorderColor);

            if (!DrawExtend) { // Show simple tooltip

                //e.Graphics.Clear(Color.Transparent);
                Rectangle rect = new Rectangle {
                    Width = TotalSize.Width,
                    Height = TotalSize.Height
                };
                //Draw background border
                e.Graphics.DrawRoundedRectangle(new Pen(BorderColor), rect, RoundCornersRadius);
                //Draw background
                e.Graphics.FillRoundedRectangle(backColorBrush,
                    Rectangle.Inflate(rect, -BorderThickness, -BorderThickness), RoundCornersRadius
                );
                Rectangle textRect = new Rectangle {
                    X = UiOffset,
                    Y = UiOffset,
                    Width = bodyTextSize.Width,
                    Height = bodyTextSize.Height
                };
                //Draw Body Text
                TextRenderer.DrawText(e.Graphics, BodyText, BodyTextFont, textRect, BodyTextColor, CenterFlags);
                return;
            }
            //Layout distribution
            Rectangle tltpRect = new Rectangle {
                Width = TotalSize.Width,
                Height = TotalSize.Height
            };
            Rectangle headTextRect = new Rectangle {
                X = UiOffset,
                Y = UiOffset,
                Width = TotalSize.Width - UiOffset * 2,
                Height = headTextSize.Height
            };
            Rectangle break1Rect = new Rectangle {
                X = 0,
                Y = headTextRect.Bottom + UiOffset,
                Width = TotalSize.Width,
                Height = headTextRect.Bottom + UiOffset
            };
            Rectangle bodyTextRect = new Rectangle {
                X = UiOffset,
                Y = break1Rect.Top + UiOffset,
                Width = TotalSize.Width,
                Height = bodyTextSize.Height
            };
            Rectangle bodyImageRect = new Rectangle {
                X = BodyImageStretch ? UiOffset : (TotalSize.Width - bodyImageSize.Width) / 2,
                Y = bodyTextRect.Bottom + UiOffset,
                Width = bodyImageSize.Width,
                Height = bodyImageSize.Height
            };
            Rectangle break2Rect = new Rectangle {
                X = 0,
                Y = bodyImageRect.Bottom + UiOffset,
                Width = TotalSize.Width,
                Height = bodyImageRect.Bottom + UiOffset,
            };
            Rectangle footerTextRect = new Rectangle {
                X = UiOffset,
                Y = break2Rect.Top + UiOffset,
                Width = TotalSize.Width,
                Height = footerTextSize.Height
            };

            //Draw background border
            e.Graphics.FillRectangle(borderBrush, tltpRect);
            //Draw background
            e.Graphics.FillRectangle(backColorBrush,
                Rectangle.Inflate(tltpRect, -BorderThickness, -BorderThickness)
            );
            //Draw head text background
            e.Graphics.FillRectangle(headerTextBackBrush, new Rectangle(

                headTextRect.X,
                headTextRect.Y,
                headTextRect.Width,
                headTextRect.Height + 2
            ));
            //Draw head text
            e.Graphics.DrawString(HeaderText, HeaderextFont, headerTextBrush, headTextRect, TextFormatHeader);
            //Draw separator 1
            e.Graphics.DrawLine(new Pen(BorderColor), break1Rect.Left, break1Rect.Top, break1Rect.Right, break1Rect.Top);
            //Draw Body Text
            TextRenderer.DrawText(e.Graphics, BodyText, BodyTextFont, bodyTextRect, BodyTextColor, TextFormatFlags.WordBreak);
            //Draw Image
            e.Graphics.DrawImage(BodyImage, bodyImageRect);
            //Draw separator 2
            e.Graphics.DrawLine(new Pen(BorderColor), break2Rect.Left, break2Rect.Top, break2Rect.Right, break2Rect.Top);
            //Draw Footer Text
            e.Graphics.DrawString(FooterText, BodyTextFont, footerTextBrush, footerTextRect, TextFormatFooter);
        }

        // Show a Form without stealing focus
        [DllImport("user32.dll")]
        private extern static IntPtr SetActiveWindow(IntPtr handle);
        // Keyboard Input Notifications
        // Activated by some method other than a mouse click(for example, by a call to the SetActiveWindow 
        // function or by use of the keyboard interface to select the window).
        private const int WM_ACTIVATE = 6;
        private const int WA_INACTIVE = 0; //Deactivated.
        protected override void WndProc(ref Message m) {
            if (m.Msg == WM_ACTIVATE) {
                if (((int)m.WParam & 0xFFFF) != WA_INACTIVE) {
                    if (m.LParam != IntPtr.Zero) {
                        SetActiveWindow(m.LParam);
                    } else {
                        // Could not find sender, just in-activate it.
                        SetActiveWindow(IntPtr.Zero);
                    }
                }
            }
            base.WndProc(ref m);
        }

        #endregion

        #region Windows Form Designer generated code

        private void InitializeComponent() {
            this.SuspendLayout();
            this.AccessibleRole = AccessibleRole.ToolTip;
            this.AutoScaleMode = AutoScaleMode.None;
            this.ClientSize = new Size(100, 100);
            this.FormBorderStyle = FormBorderStyle.None;
            this.Name = "McTooltip";
            this.StartPosition = FormStartPosition.Manual;
            this.Visible = false;
            this.BackColor = Color.Linen;
            this.HeaderTextColor = Color.MediumPurple;
            this.HeaderTextBackColor = Color.FromArgb(207, 184, 254);
            this.BodyTextColor = Color.DarkOliveGreen;
            this.FooterTextColor = Color.DarkGray;
            this.BorderColor = Color.DarkGray;
            this.BorderThickness = 2;
            this.TotalSize = this.MaxSize;
            this.ResumeLayout(false);
        }

        #endregion
    }
}
