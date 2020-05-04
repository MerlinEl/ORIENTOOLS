using System;
using System.Drawing;

namespace Orien.Tools {
    public class McGet {

        #region Objects

        public static object FontStyles = Enum.ToObject(typeof(FontStyle), 0);

        #endregion

        #region Methods

        public static Font NewFont(string family, float size, FontStyle style) => new Font(family, size, style);
        public static Size NewSize(int w, int h) => new Size(w, h);
        public static Color NewColor(int r, int g, int b) => Color.FromArgb(r, g, b);
        public static Color ColorFromName(string clr_str) => Color.FromName(clr_str);

        #endregion
    }
}
