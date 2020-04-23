/*[ Compilation unit ----------------------------------------------------------

   Component       : ToolTip With Image

   Name            : mcImageToolTip.cs

   Last Author     : Ravikant, Siemens Medical Solutions, Inc., MerlinEl

   Language        : C#

   Description     : Implementation of mcImageToolTip
 
   Copyright (C) ravikant.cse@gmail.com 2006-2010 All Rights Reserved

   URL             : https://www.codeproject.com/Articles/42050/ToolTip-With-Image-C

-----------------------------------------------------------------------------*/
/*] END */

/*
--C#
mcImageToolTip myToolTip1 = new mcImageToolTip();
myToolTip1.AutoSize = false;
myToolTip1.Size  = new Size(200, 64);
myToolTip1.SetFont("Imnpact", 14, FontStyle.Bold, Color.Green);
myToolTip1.SetToolTip(progBar, "Button 1. ToolTip with Image");
progBar.Tag = Resources.tltp_flatten_01;
PropertyGrid propertyGrid1 = new PropertyGrid();
propertyGrid1.Location = new System.Drawing.Point(114, 13);
propertyGrid1.Name = "propertyGrid1";
propertyGrid1.Size = new System.Drawing.Size(252, 375);
propertyGrid1.TabIndex = 4;
propertyGrid1.SelectedObject = myToolTip1;
propertyGrid1.PropertySort = PropertySort.Alphabetical;

--3DsMax
test_form = dotNetObject "MaxCustomControls.MaxForm"
test_btn = dotNetObject "button"
test_btn.text = "Tooltip Test"
test_tptp = mcDotnet.loadAssembly "Orien.NetUi.dll" "Orien.NetUi.mcImageTooltip" 
test_tptp.AutoSize = false
test_tptp.Size 400 128
test_tptp.SetToolTip test_btn "Button 1. ToolTip with Image"
test_btn.Tag = (dotNetClass "Drawing.Image").FromFile  (micra.ImagesPath + "TooltipIcons\\tltp_flatten_01.png")
test_form.controls.add test_btn
mcDotnet.dShow test_form
*/


using System;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;

namespace Orien.NetUi {
    /// <summary>
    /// mcImageToolTip to create tooltips with Image.
    /// </summary>
    public class mcImageToolTip : ToolTip {
        #region Constants

        private const int TOOLTIP_WIDTH = 400;
        private const int TOOLTIP_HEIGHT = 128;
        private const int BORDER_THICKNESS = 1;
        private const int PADDING = 6;
        private const int DEFAULT_IMAGE_WIDTH = 15;

        #endregion

        #region Fields

        private static Color _borderColor = Color.Red;
        private static Font _font = new Font("Arial", 8);
        private StringFormat _textFormat = new StringFormat();
        private Rectangle _imageRectangle = new Rectangle();
        private Rectangle _textRectangle = new Rectangle();
        private Rectangle _toolTipRectangle = new Rectangle();
        private Brush _backColorBrush = new SolidBrush(Color.LightYellow);
        private Brush _textBrush = new SolidBrush(Color.Black);
        private Brush _borderBrush = new SolidBrush(_borderColor);
        private Size _size = new Size(TOOLTIP_WIDTH, TOOLTIP_HEIGHT);
        private int _internalImageWidth = DEFAULT_IMAGE_WIDTH;
        private bool _autoSize = true;
        #endregion

        #region Properties

        /// <summary>
        /// Gets or sets a value indicating whether the ToolTip is drawn by the operating
        /// system or by code that you provide.
        /// If true, the properties 'ToolTipIcon' and 'ToolTipTitle' will set to their default values
        /// and the image will display in ToolTip otherwise only text will display.
        /// </summary>
        [CategoryAttribute("Custom Settings"), DescriptionAttribute(@"Gets or sets a value indicating whether the ToolTip is drawn by the operating system or by code that you provide. If true, the properties 'ToolTipIcon' and 'ToolTipTitle' will set to their default values and the image will display in ToolTip otherwise only text will display.")]
        public new bool OwnerDraw {
            get {
                return base.OwnerDraw;
            }
            set {
                if ( value ) {
                    this.ToolTipIcon = ToolTipIcon.None;
                    this.ToolTipTitle = string.Empty;
                }
                base.OwnerDraw = value;
            }
        }

        /// <summary>
        /// Gets or sets a value that defines the type of icon to be displayed alongside
        /// the ToolTip text.
        /// Cannot set if the property 'OwnerDraw' is true.
        /// </summary>
        [CategoryAttribute("Custom Settings"), DescriptionAttribute(@"Gets or sets a value that defines the type of icon to be displayed alongside the ToolTip text. Cannot set if the property 'OwnerDraw' is true.")]
        public new ToolTipIcon ToolTipIcon {
            get {
                return base.ToolTipIcon;
            }
            set {
                if ( !OwnerDraw ) {
                    base.ToolTipIcon = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets a title for the ToolTip window.
        /// Cannot set if the property 'OwnerDraw' is true.
        /// </summary>
        [CategoryAttribute("Custom Settings"), DescriptionAttribute(@"Gets or sets a title for the ToolTip window. Cannot set if the property 'OwnerDraw' is true.")]
        public new string ToolTipTitle {
            get {
                return base.ToolTipTitle;
            }
            set {
                if ( !OwnerDraw ) {
                    base.ToolTipTitle = value;
                }
            }
        }

        /// <summary>
        /// Gets or sets the background color for the ToolTip.
        /// </summary>
        [CategoryAttribute("Custom Settings"), DescriptionAttribute(@"Gets or sets the background color for the ToolTip.")]
        public new Color BackColor {
            get {
                return base.BackColor;
            }
            set {
                base.BackColor = value;
                Brush temp = _backColorBrush;
                _backColorBrush = new SolidBrush(value);
                temp.Dispose();
            }
        }

        /// <summary>
        /// Gets or sets the foreground color for the ToolTip.
        /// </summary>
        [CategoryAttribute("Custom Settings"), DescriptionAttribute(@"Gets or sets the foreground color for the ToolTip.")]
        public new Color ForeColor {
            get {
                return base.ForeColor;
            }
            set {
                base.ForeColor = value;
                Brush temp = _textBrush;
                _textBrush = new SolidBrush(value);
                temp.Dispose();
            }
        }

        /// <summary>
        /// Gets or sets a value that indicates whether the ToolTip resizes based on its text.
        /// true if the ToolTip automatically resizes based on its text; otherwise, false. The default is true.
        /// </summary>
        [CategoryAttribute("Custom Settings"), DescriptionAttribute(@"Gets or sets a value that indicates whether the ToolTip resizes based on its text. true if the ToolTip automatically resizes based on its text; otherwise, false. The default is true.")]
        public bool AutoSize {
            get { return _autoSize; }
            set {
                _autoSize = value;
                if ( _autoSize ) {
                    _textFormat.Trimming = StringTrimming.None;
                } else {
                    _textFormat.Trimming = StringTrimming.EllipsisCharacter;
                }
            }
        }

        /// <summary>
        /// Gets or sets the size of the ToolTip.
        /// Valid only if the Property 'AutoSize' is false.
        /// </summary>
        [CategoryAttribute("Custom Settings"), DescriptionAttribute(@"Gets or sets the size of the ToolTip. Valid only if the Property 'AutoSize' is false.")]
        public Size Size {
            get { return _size; }
            set {
                if ( !_autoSize ) {
                    _size = value;
                    _toolTipRectangle.Size = _size;
                }
            }
        }

        /// <summary>
        /// Gets or sets the border color for the ToolTip.
        /// </summary>
        [CategoryAttribute("Custom Settings"), DescriptionAttribute(@"Gets or sets the border color for the ToolTip.")]
        public Color BorderColor {
            get {
                return _borderColor;
            }
            set {
                _borderColor = value;
                Brush temp = _borderBrush;
                _borderBrush = new SolidBrush(value);
                temp.Dispose();
            }
        }

        #endregion

        #region Constructor

        /// <summary>
        /// Constructor to create instance of mcImageToolTip class that can display Thumbnails/Images in it.
        /// </summary>
        public mcImageToolTip() {
            try {
                this.OwnerDraw = true;

                _textFormat.FormatFlags = StringFormatFlags.LineLimit;
                _textFormat.Alignment = StringAlignment.Center;
                _textFormat.LineAlignment = StringAlignment.Center;
                _textFormat.Trimming = StringTrimming.None;

                this.Popup += new PopupEventHandler(CustomizedToolTip_Popup);
                this.Draw += new DrawToolTipEventHandler(CustomizedToolTip_Draw);
            } catch ( Exception ex ) {
                string logMessage = "Exception in mcImageToolTip.mcImageToolTip () " + ex.ToString();
                Trace.TraceError(logMessage);
                throw;
            }
        }

        #endregion

        #region Implementation for 3DsMax

        public void SetFont(string family, float size, FontStyle style, Color color) {

            ForeColor = color;
            _font = new Font(family, size, style);
        }

        #endregion

        #region Methods

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            try {
                //Dispose of the disposable objects.
                try {
                    if ( disposing ) {
                        if ( _font != null ) {
                            _font.Dispose();
                        }
                        if ( _textBrush != null ) {
                            _textBrush.Dispose();
                        }
                        if ( _backColorBrush != null ) {
                            _backColorBrush.Dispose();
                        }
                        if ( _borderBrush != null ) {
                            _borderBrush.Dispose();
                        }
                        if ( _textFormat != null ) {
                            _textFormat.Dispose();
                        }
                    }
                } finally {
                    base.Dispose(disposing);
                }
            } catch ( Exception ex ) {
                string logMessage = "Exception in mcImageToolTip.Dispose (bool) " + ex.ToString();
                Trace.TraceError(logMessage);
                throw;
            }
        }

        /// <summary>
        /// CustomizedToolTip_Draw raised when tooltip is drawn.
        /// </summary>
        /// <param name="sender">sender</param>
        /// <param name="e">e</param>
        void CustomizedToolTip_Draw(object sender, DrawToolTipEventArgs e) {
            try {
                e.Graphics.CompositingQuality = CompositingQuality.HighQuality;
                _toolTipRectangle.Size = e.Bounds.Size;
                e.Graphics.FillRectangle(_borderBrush, _toolTipRectangle);
                _imageRectangle = Rectangle.Inflate(_toolTipRectangle, -BORDER_THICKNESS, -BORDER_THICKNESS);
                e.Graphics.FillRectangle(_backColorBrush, _imageRectangle);

                Control parent = e.AssociatedControl;
                Image toolTipImage = parent.Tag as Image;
                if ( toolTipImage != null ) {
                    _imageRectangle.Width = _internalImageWidth;
                    _textRectangle = new Rectangle(_imageRectangle.Right, _imageRectangle.Top,
                        ( _toolTipRectangle.Width - _imageRectangle.Right - BORDER_THICKNESS ), _imageRectangle.Height);
                    _textRectangle.Location = new Point(_imageRectangle.Right, _imageRectangle.Top);

                    e.Graphics.FillRectangle(_backColorBrush, _textRectangle);
                    e.Graphics.DrawImage(toolTipImage, _imageRectangle);
                    e.Graphics.DrawString(e.ToolTipText, _font, _textBrush, _textRectangle, _textFormat);
                } else {
                    e.Graphics.DrawString(e.ToolTipText, _font, _textBrush, _imageRectangle, _textFormat);
                }
            } catch ( Exception ex ) {
                string logMessage = "Exception in mcImageToolTip.BlindHeaderToolTip_Draw (object, DrawToolTipEventArgs) " + ex.ToString();
                Trace.TraceError(logMessage);
                throw;
            }
        }

        /// <summary>
        /// CustomizedToolTip_Popup raised when tooltip pops up.
        /// </summary>
        /// <param name="sender">sender</param>
        /// <param name="e">e</param>
        void CustomizedToolTip_Popup(object sender, PopupEventArgs e) {
            try {
                if ( OwnerDraw ) {
                    if ( !_autoSize ) {
                        e.ToolTipSize = _size;
                        _internalImageWidth = _size.Height;
                    } else {
                        Size oldSize = e.ToolTipSize;
                        Control parent = e.AssociatedControl;
                        Image toolTipImage = parent.Tag as Image;
                        if ( toolTipImage != null ) {
                            _internalImageWidth = oldSize.Height;
                            oldSize.Width += _internalImageWidth + PADDING;
                        } else {
                            oldSize.Width += PADDING;
                        }
                        e.ToolTipSize = oldSize;
                    }
                }
            } catch ( Exception ex ) {
                string logMessage = "Exception in mcImageToolTip.CustomizedToolTip_Popup (object, PopupEventArgs) " + ex.ToString();
                Trace.TraceError(logMessage);
                throw;
            }
        }

        #endregion
    }
}
