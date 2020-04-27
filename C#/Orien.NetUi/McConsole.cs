using Orien.Tools;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Orien.NetUi {
    public partial class McConsole : Form {
        private readonly Form form;
        //private readonly ListBox autoCompleteBox;
        private enum CMD {
            Help = 0,
            Hide = 1,
            Close = 2,
            Clear = 3,
            ClearAll = 4
        }

        #region Constructor

        public McConsole(Form parent = null) {
            if ( parent != null ) {
                form = this;
                this.Owner = parent;
                parent.FormClosed += new FormClosedEventHandler(OnOwnerClosed);
            }
            InitializeComponent();
            //autoCompleteBox = new ListBox();
            //this.Controls.Add(autoCompleteBox);
        }

        #endregion

        #region Public Methods

        public void Log(string msg, string tabName = "Console") => Log(msg, tabName, null);
        public void Log(string msg, string tabName = "Console", params object[] args) {

            if ( args != null ) msg = string.Format(msg, args);
            if ( tabName == "Console" ) {

                GetCurrentTabPage().GetTextBox().AppendText(msg);

            } else {

                GetOrCreateTab(tabName).AppendText(msg);
            }
            //if (console_parent != null) this.ShowDialog(console_parent); else this.Show();
            this.Show();
        }

        #endregion

        #region Private Methods

        private void AutocompleteCheck() {

            string word = GetCommand();
            if ( word == null ) return;
            string[] list = Enum.GetNames(typeof(CMD));
            // search word in enum list (ignoreCase = true)
            List<string> localList = list.Where(z => z.StartsWith(word, true)).ToList();
            if ( localList.Any() && !string.IsNullOrEmpty(word) ) {
                Console.WriteLine("Items found:{0}\n", localList.Join("\n\t"));
                AutoCompleteBox.DataSource = localList;
                AutoCompleteBox.Show();
                AutoCompleteBox.Location = new Point(

                    0, CurrentRichTextBox.GetCaretPoint().Y + CurrentRichTextBox.GetLineHeight(word)
                );
                Focus();
                //AutoCompleteBox.BringToFront();
            }
        }

        internal string GetCommand() {

            if ( CurrentRichTextBox != null && CurrentRichTextBox.Lines.Any() ) {
                string lastLine = CurrentRichTextBox.Lines[CurrentRichTextBox.Lines.Length - 1];
                if ( lastLine.Length == 0 ) {
                    return null;
                }

                if ( lastLine[0] == ':' ) {
                    return lastLine.TrimStart(':');
                }
                //string lastword = lastLine.Split(' ').Last();
            }
            return null;
        }

        private void RunCmd(string cmd) {
            if ( cmd.Length == 0 ) {
                return;
            }

            if ( Enum.TryParse(cmd, true, out CMD n) ) { //parse the enum with ignoreCase flag 
                Console.WriteLine("n:{0}", n);
                switch ( n ) {

                    case CMD.Help: ShowCommands(); break;
                    case CMD.Hide: form.Hide(); break;
                    case CMD.Close: this.Close(); break;
                    case CMD.Clear: CurrentRichTextBox.Text = ""; break;
                    default: Log("\nCommand: ( " + cmd + " ) is not recognized."); break;
                }
            } else {
                Log("\nCommand: ( " + cmd + " ) is not recognized.");
            }
        }

        private void ShowCommands() {
            Log("\nCommands List:");
            foreach ( string s in Enum.GetNames(typeof(CMD)) ) {
                Log("\t" + s);
            }
        }

        private TabPage GetOrCreateTab(string tabName) {

            TabPage tp = GetTab(tabName);
            return tp != null ? tp : AddTab(tabName);
        }

        private TabPage GetTab(string tabName) {

            foreach ( TabPage tab in this.MainTab.TabPages ) {
                if ( tabName.Equals(tab.Name) ) {
                    return tab;
                }
            }
            return null;
        }

        private RichTextBox CurrentRichTextBox => GetCurrentTabPage().GetTextBox();

        private TabPage GetCurrentTabPage() {
            return this.MainTab.TabPages.Count > 0 ? this.MainTab.SelectedTab : null;
        }

        private TabPage AddTab(string tabName) {

            TabPage tp = new TabPage(tabName);
            RichTextBox rtb = new RichTextBox {
                AcceptsTab = false,
                ForeColor = Color.FromArgb(200, 200, 200),
                BackColor = Color.FromArgb(66, 66, 81),
                WordWrap = false,
                ReadOnly = true,
                Dock = DockStyle.Fill,
                Name = "rtb",
                Text = "..."
            };
            tp.Controls.Add(rtb);
            this.MainTab.TabPages.Add(tp);
            return tp;
        }

        private void RemoveTab(string tabName) {

            TabPage tp = GetTab(tabName);
            if ( tp != null ) MainTab.TabPages.Remove(tp);
        }

        private void ClearTabs() { //remove all except first one

            TabPage tp = MainTab.TabPages["Console"];
            this.MainTab.TabPages.Clear();
            this.MainTab.TabPages.Add(tp);
        }

        #endregion

        #region UI Events

        private void OnTitleMouseDown(object sender, MouseEventArgs e) {
            if ( e.Button == MouseButtons.Left ) {
                // Release the mouse capture started by the mouse down.
                ( sender as MenuStrip ).Capture = false;

                // Create and send a WM_NCLBUTTONDOWN message.
                const int WM_NCLBUTTONDOWN = 0x00A1;
                const int HTCAPTION = 2;
                Message msg =
                    Message.Create(this.Handle, WM_NCLBUTTONDOWN,
                        new IntPtr(HTCAPTION), IntPtr.Zero);
                this.DefWndProc(ref msg);
            }
        }

        private void BtnClose_Click(object sender, EventArgs e) {
            form.Close();
        }

        private void BtnMax_Click(object sender, EventArgs e) {
            form.WindowState = form.WindowState == FormWindowState.Maximized ? 
                FormWindowState.Normal : FormWindowState.Maximized;
        }

        private void BtnMin_Click(object sender, EventArgs e) {
            form.WindowState = FormWindowState.Minimized;
        }

        private void OnOwnerClosed(object sender, FormClosedEventArgs e) {
            form.Close();
        }

        private void OnConsoleKeyDown(object sender, KeyEventArgs e) {

            if ( e.KeyCode == Keys.Enter ) {
                string cmd = GetCommand();
                if ( cmd != null ) RunCmd(cmd);
            } else if ( e.KeyCode == Keys.Tab && AutoCompleteBox.Visible ) {

                e.SuppressKeyPress = true; //prevent tab to be inserted in textbox
                CurrentRichTextBox.ReplaceLastLine(AutoCompleteBox.SelectedItem.ToString());
            }
        }

        private void OnConsoleKeyUp(object sender, KeyEventArgs e) {

            if ( AutoCompleteBox.Visible ) {
                if ( e.KeyCode == Keys.Escape ) {

                    AutoCompleteBox.Hide();

                } else if ( e.KeyCode == Keys.Up ) {

                    AutoCompleteBox.SelectPrevItem();

                } else if ( e.KeyCode == Keys.Down ) {

                    AutoCompleteBox.SelectNextItem();

                } else if ( e.KeyCode == Keys.Tab ) {

                    AutoCompleteBox.Hide();
                }
            } else if ( //prevent popup Autocomplete ListBox in other sitution than Typing Letters
                e.KeyCode == Keys.Enter || e.KeyCode == Keys.Back ||
                e.KeyCode == Keys.Up || e.KeyCode == Keys.Down ||
                e.KeyCode == Keys.Left || e.KeyCode == Keys.Right
                ) { //do nothing

            } else {
                AutocompleteCheck();
            }
        }

        private void OnTabIndexChanged(object sender, EventArgs e) {
        }

        #endregion

        #region Menu Events
        private void OnexitToolStripMenuItem_Click(object sender, EventArgs e) {

            this.Close();
        }

        private void OnshowHelpToolStripMenuItem_Click(object sender, EventArgs e) {

            Log("\nTODO :-) ...........");
        }

        private void OnclearCurrentTabToolStripMenuItem1_Click(object sender, EventArgs e) {

            CurrentRichTextBox.Clear();
        }
        private void OnclearAllTabsToolStripMenuItem1_Click(object sender, EventArgs e) {

            foreach ( TabPage tp in MainTab.TabPages ) tp.GetTextBox().Clear();
        }

        private void OncopyCurrentToolStripMenuItem_Click(object sender, EventArgs e) {
            Clipboard.SetText(CurrentRichTextBox.Text);
        }

        private void OnsaveAsToolStripMenuItem_Click(object sender, EventArgs e) {

            TabPage tab = GetCurrentTabPage();
            // Initialize the SaveFileDialog to specify the RTF extention for the file.
            SaveFileDialog.InitialDirectory = McDesktop.User_Directory + "\\" + tab.Text + ".rtf";
            SaveFileDialog.DefaultExt = "*.rtf";
            SaveFileDialog.Filter = "RTF bestanden (*.rtf)|*.rtf|" + "Tekst Bestanden|*.txt";
            SaveFileDialog.FileName = tab.Text;
            // Determine whether the user selected a file name from the saveFileDialog.
            SaveFileDialog.ShowDialog();
        }
        private void OnaboutMcConsoleToolStripMenuItem_Click(object sender, EventArgs e) {
            McConsoleAbout f = new McConsoleAbout {
                StartPosition = FormStartPosition.Manual
            };
            f.SetDesktopLocation(Cursor.Position.X, Cursor.Position.Y);
            f.ShowDialog();
        }

        #endregion


    }


    #region RichTextBox Extensions
    internal static class RichTextBoxExtensions {

        internal static Point GetCaretPoint(this RichTextBox tb) {
            int start = tb.SelectionStart;
            if ( start == tb.TextLength )
                start--;
            return tb.GetPositionFromCharIndex(start);
        }

        internal static int GetLineHeight(this RichTextBox tb, string word) {

            int textHeight;
            using ( Graphics g = tb.CreateGraphics() ) {
                textHeight = TextRenderer.MeasureText(g, word, tb.Font).Height;
            }
            return textHeight;
        }

        internal static bool ReplaceLastLine(this RichTextBox tb, string word) {

            int index = tb.SelectionStart;
            int lineNumber = tb.GetLineFromCharIndex(index);
            int first = tb.GetFirstCharIndexFromLine(lineNumber);
            if ( first < 0 ) return false;
            int last = tb.GetFirstCharIndexFromLine(lineNumber + 1);
            tb.Select(first,
                last < 0 ? int.MaxValue : last - first - Environment.NewLine.Length);
            tb.SelectedText = ":" + word;
            return true;
        }
    }

    #endregion

    #region ListBox Extensions

    internal static class ListBoxExtensions {

        internal static bool SelectNextItem(this ListBox lbx) {

            int next = lbx.SelectedIndex + 1;
            if ( next < lbx.Items.Count ) {

                lbx.SelectedIndex = next;
                return true;
            };
            return false;
        }
        internal static bool SelectPrevItem(this ListBox lbx) {

            int prev = lbx.SelectedIndex - 1;
            if ( prev >= 0 ) {

                lbx.SelectedIndex = prev; return true;
            };
            return false;
        }
    }

    #endregion

    #region Tab Extensions

    internal static class TabExtensions {

        internal static RichTextBox GetTextBox(this TabPage tp) {
            foreach ( Control c in tp.Controls ) if ( c is RichTextBox ) return c as RichTextBox;
            return null;
        }
        internal static void AppendText(this TabPage tp, string str) {

            tp.GetTextBox().AppendText(str);
        }
    }

    #endregion
}
