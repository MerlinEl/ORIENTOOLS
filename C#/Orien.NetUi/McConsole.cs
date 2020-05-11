using Orien.Tools;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Orien.NetUi {
    public partial class McConsole : Form {
        private bool Suppres_Keypress = false;
        public bool Inivisible = false;
        public enum CMD {
            Help = 0,
            Close = 1,
            Clear = 2,
            ClearAll = 3
        }

        #region Constructor

        public McConsole() => Init();
        public McConsole(Form parent) => Init(parent);
        public McConsole(Form parent, bool topMost) => Init(parent, topMost);
        public McConsole(Form parent, bool topMost, bool inivisible) => Init(parent, topMost, inivisible);

        private void Init(Form parent = null, bool topMost = true, bool inivisible = false) {

            TopMost = topMost;
            Inivisible = inivisible;
            if (parent != null) {
                this.Owner = parent;
                parent.FormClosed += new FormClosedEventHandler(OnOwnerClosed);
            }
            InitializeComponent();
        }

        #endregion

        #region Public Methods

        /// <summary>
        /// CConsole = new McConsole(progBar);
        /// CConsole.Log("hello!"); // main console tab
        /// CConsole.Log("", "The {0} is {1} years old.", "Tifany", 12); // main console tab
        /// CConsole.Log("The {0} is {1} years old.", new object[] {"Tifany", 12}); // main console tab
        /// CConsole.Log("Console", "The {0} is {1} years old.", "Tifany", 12); // main console tab
        /// CConsole.Log("The {0} is {1} years old.", new object[] {"John", 33});
        /// CConsole.Log("Personal", "hello Body"); //ok
        /// CConsole.Log("Formated", "The {0} is {1} years old.", new object[] { "Monika", 22});
        /// </summary>
        public void Log(string msg) => AddConsoleText("Console", msg);
        public void Log(string msg, params object[] args) => AddConsoleText("Console", msg, args);
        public void Log(string tabName, string msg) => AddConsoleText(tabName, msg);
        public void Log(string tabName, string msg, params object[] args) => AddConsoleText(tabName, msg, args);

        #endregion

        #region Protected Methods

        protected RichTextBox CurrentRichTextBox => GetCurrentTabPage().GetTextBox();

        protected void AddConsoleText(string tabName, string msg, params object[] args) {

            if (args.Length > 0) msg = string.Format(msg, args);
            //if (!this.Visible &&) this.Visible = true;
            if (tabName == "Console" || tabName == "") {

                RichTextBox1.AppendText(msg + "\n");

            } else {

                GetOrCreateTab(tabName).AppendText(msg + "\n");
            }
            if (!Visible && !Inivisible) Show();
        }
        protected string GetCommand() {

            if (CurrentRichTextBox != null && CurrentRichTextBox.Lines.Any()) {
                string lastLine = CurrentRichTextBox.Lines[CurrentRichTextBox.Lines.Length - 1];
                if (lastLine.Length == 0) {
                    return null;
                }

                if (lastLine[0] == ':') {
                    return lastLine.TrimStart(':');
                }
                //string lastword = lastLine.Split(' ').Last();
            }
            return null;
        }

        #endregion

        #region Virtual Methods

        virtual protected void RunCmd(string cmd) {
            if (cmd.Length == 0) return;
            if (Enum.TryParse(cmd, true, out CMD n)) { //parse the enum with ignoreCase flag 
                Console.WriteLine("n:{0}", n);
                switch (n) {

                    case CMD.Help: ShowCommands(); break;
                    case CMD.Close: Hide(); break;
                    case CMD.Clear: CurrentRichTextBox.Text = ""; break;
                    case CMD.ClearAll: ClearAllTabs(); break;
                    default: Log("\nCommand: ( " + cmd + " ) is not recognized."); break;
                }
            } else {
                Log("\nCommand: ( " + cmd + " ) is not recognized.");
            }
        }
        virtual protected void AutocompleteCheck() {

            string word = GetCommand();
            if (word == null) return;
            string[] list = Enum.GetNames(typeof(CMD));
            // search word in enum list (ignoreCase = true)
            List<string> localList = list.Where(z => z.StartsWith(word, true)).ToList();
            if (localList.Any() && !string.IsNullOrEmpty(word)) {
                Console.WriteLine("Items found:{0}\n", localList.Join("\n\t"));
                AutoCompleteBox.DataSource = localList;
                AutoCompleteBox.Show();
                AutoCompleteBox.Location = new Point(

                    0, RichTextBox1.GetCaretPoint().Y + RichTextBox1.GetLineHeight(word)
                );
                //AutoCompleteBox.BringToFront();
            }
            RichTextBox1.Focus();
        }

        #endregion

        #region Private Methods

        private void ShowCommands() {
            Log("\nCommands List:");
            foreach (string s in Enum.GetNames(typeof(CMD))) {
                Log("\t" + s);
            }
        }

        public void ShowConsole(long hwnd) {

            NativeWindow parentWindow = McGet.GetWindowFromHwnd(hwnd);
            try {
                ShowDialog(parentWindow);
            }
            finally {
                parentWindow.DestroyHandle(); //yea this will kill 3DsMax Aplication. Do not use!
            }
        }

        #endregion

        #region UI Methods

        public void ClearAllTabs() {
            foreach (TabPage tp in MainTab.TabPages) tp.GetTextBox().Clear();
        }

        /*private void RemoveTabByName(string tabName) {

            TabPage tp = GetTab(tabName);
            if (tp != null) MainTab.TabPages.Remove(tp);
        }*/

        /*public void RemoveAllTabs() {
            /foreach (TabPage tab in MainTab.TabPages) {
                if (tab.Name != "Console") MainTab.TabPages.Remove(tab);
            }
            TabPage tp = MainTab.TabPages["Console"];
            this.MainTab.TabPages.Clear();
            this.MainTab.TabPages.Add(tp);
        }*/

        protected TabPage GetOrCreateTab(string tabName) {

            TabPage tp = GetTab(tabName);
            return tp ?? AddTab(tabName);
        }

        private TabPage GetTab(string tabName) {

            foreach (TabPage tab in this.MainTab.TabPages) {
                if (tabName.Equals(tab.Name)) {
                    return tab;
                }
            }
            return null;
        }

        private TabPage GetCurrentTabPage() {
            return this.MainTab.TabPages.Count > 0 ? this.MainTab.SelectedTab : null;
        }

        private TabPage AddTab(string tabName) {

            TabPage tp = new TabPage(tabName) {
                Name = tabName
            };
            RichTextBox rtb = new RichTextBox {
                AcceptsTab = false,
                ForeColor = Color.FromArgb(200, 200, 200),
                BackColor = Color.FromArgb(66, 66, 81),
                WordWrap = false,
                ReadOnly = true,
                Dock = DockStyle.Fill,
                Name = "rtb"
            };
            tp.Controls.Add(rtb);
            this.MainTab.TabPages.Add(tp);
            return tp;
        }

        #endregion

        #region UI Events

        private void BtnTopMost_Click(object sender, EventArgs e) {
            TopMost = !TopMost;
        }

        private void OnTitleMouseDown(object sender, MouseEventArgs e) {
            if (e.Button == MouseButtons.Left) {
                // Release the mouse capture started by the mouse down.
                (sender as MenuStrip).Capture = false;

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
            Hide();
        }

        private void BtnMax_Click(object sender, EventArgs e) {
            WindowState = WindowState == FormWindowState.Maximized ?
                FormWindowState.Normal : FormWindowState.Maximized;
        }

        private void BtnMin_Click(object sender, EventArgs e) {
            WindowState = FormWindowState.Minimized;
        }

        protected void OnOwnerClosed(object sender, FormClosedEventArgs e) {
            Close(); //only here is realy closed
        }

        private void OnConsoleKeyDown(object sender, KeyEventArgs e) {

            e.SuppressKeyPress = Suppres_Keypress;
            if (e.KeyCode == Keys.Escape) {

                Hide();

            } else if (e.KeyCode == Keys.Enter) {

                string cmd = GetCommand();
                if (cmd != null) RunCmd(cmd);

            } else if (AutoCompleteBox.Visible) {

                if (e.KeyCode == Keys.Tab) {

                    e.SuppressKeyPress = true; //prevent tab to be inserted in textbox
                    CurrentRichTextBox.ReplaceLastLine(AutoCompleteBox.SelectedItem.ToString());

                } else if ( //prevent popup Autocomplete ListBox in other sitution than Typing Letters
                e.KeyCode == Keys.Up || e.KeyCode == Keys.Down ||
                e.KeyCode == Keys.Left || e.KeyCode == Keys.Right
                ) {
                    e.SuppressKeyPress = true;
                }
            }
        }

        private void OnConsoleKeyUp(object sender, KeyEventArgs e) {

            if (AutoCompleteBox.Visible) {
                if (e.KeyCode == Keys.Escape) {

                    AutoCompleteBox.Hide();

                } else if (e.KeyCode == Keys.Up) {

                    AutoCompleteBox.SelectPrevItem();

                } else if (e.KeyCode == Keys.Down) {

                    AutoCompleteBox.SelectNextItem();

                } else if (e.KeyCode == Keys.Tab) {

                    AutoCompleteBox.Hide();
                }
            } else if ( //prevent popup Autocomplete ListBox in other sitution than Typing Letters
                e.KeyCode == Keys.Enter || e.KeyCode == Keys.Back ||
                e.KeyCode == Keys.Up || e.KeyCode == Keys.Down ||
                e.KeyCode == Keys.Left || e.KeyCode == Keys.Right
                ) { //do nothing
                e.SuppressKeyPress = true;
            } else {
                AutocompleteCheck();
            }
        }

        #endregion

        #region Menu Events

        private void OnexitToolStripMenuItem_Click(object sender, EventArgs e) {

            Hide();
        }

        private void OnshowHelpToolStripMenuItem_Click(object sender, EventArgs e) {

            Log("\nTODO :-) ...........");
        }

        private void OnclearCurrentTabToolStripMenuItem1_Click(object sender, EventArgs e) {

            CurrentRichTextBox.Clear();
        }
        private void OnclearAllTabsToolStripMenuItem1_Click(object sender, EventArgs e) {

            ClearAllTabs();
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
            f.ShowDialog(this);
        }

        #endregion

        #region TEST
        private void OnacceleratorsSwitchToolStripMenuItem_Click(object sender, EventArgs e) {
            Suppres_Keypress = !Suppres_Keypress;
        }

        #endregion

    }

    #region ListBox Extensions

    internal static class ListBoxExtensions {

        internal static bool SelectNextItem(this ListBox lbx) {

            int next = lbx.SelectedIndex + 1;
            if (next < lbx.Items.Count) {

                lbx.SelectedIndex = next;
                return true;
            };
            return false;
        }
        internal static bool SelectPrevItem(this ListBox lbx) {

            int prev = lbx.SelectedIndex - 1;
            if (prev >= 0) {

                lbx.SelectedIndex = prev; return true;
            };
            return false;
        }
    }

    #endregion

    #region Tab Extensions

    internal static class TabExtensions {

        internal static RichTextBox GetTextBox(this TabPage tp) {
            foreach (Control c in tp.Controls) if (c is RichTextBox) return c as RichTextBox;
            return null;
        }
        internal static void AppendText(this TabPage tp, string str) {

            tp.GetTextBox().AppendText(str);
        }
    }

    #endregion
}
