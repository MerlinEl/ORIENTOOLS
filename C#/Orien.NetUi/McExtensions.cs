
using System;
using System.Drawing;
using System.Windows.Forms;

namespace Orien.NetUi {
    public static class McExtensions {
    }

    #region RichTextBox Extensions
    public static class RichTextBoxExtensions {

        public static Point GetCaretPoint(this RichTextBox tb) {
            int start = tb.SelectionStart;
            if (start == tb.TextLength)
                start--;
            return tb.GetPositionFromCharIndex(start);
        }

        public static int GetLineHeight(this RichTextBox tb, string word) {

            int textHeight;
            using (Graphics g = tb.CreateGraphics()) {
                textHeight = TextRenderer.MeasureText(g, word, tb.Font).Height;
            }
            return textHeight;
        }

        public static bool ReplaceLastLine(this RichTextBox tb, string word) {

            int index = tb.SelectionStart;
            int lineNumber = tb.GetLineFromCharIndex(index);
            int first = tb.GetFirstCharIndexFromLine(lineNumber);
            if (first < 0) return false;
            int last = tb.GetFirstCharIndexFromLine(lineNumber + 1);
            tb.Select(first,
                last < 0 ? int.MaxValue : last - first - Environment.NewLine.Length);
            tb.SelectedText = ":" + word;
            return true;
        }
    }

    #endregion
}
