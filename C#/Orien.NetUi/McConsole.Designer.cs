using System.Drawing;
using System.Windows.Forms;

namespace Orien.NetUi {
    partial class McConsole {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing) {
            if (disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        private void InitializeComponent() {
            this.SaveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.MainTab = new System.Windows.Forms.TabControl();
            this.TabPage1 = new System.Windows.Forms.TabPage();
            this.AutoCompleteBox = new System.Windows.Forms.ListBox();
            this.ProgressBar1 = new System.Windows.Forms.ProgressBar();
            this.RichTextBox1 = new System.Windows.Forms.RichTextBox();
            this.BtnClose = new System.Windows.Forms.Button();
            this.BtnMax = new System.Windows.Forms.Button();
            this.BtnMin = new System.Windows.Forms.Button();
            this.FileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.SaveAsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ExitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.AboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ShowHelpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.AboutMcConsoleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.MainMenu = new System.Windows.Forms.MenuStrip();
            this.EditToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.copyCurrentToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ClearCurrentTabToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.ClearAllTabsToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.BtnTopmost = new System.Windows.Forms.Button();
            this.acceleratorsSwitchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.MainTab.SuspendLayout();
            this.TabPage1.SuspendLayout();
            this.MainMenu.SuspendLayout();
            this.SuspendLayout();
            // 
            // MainTab
            // 
            this.MainTab.Controls.Add(this.TabPage1);
            this.MainTab.Dock = System.Windows.Forms.DockStyle.Fill;
            this.MainTab.Location = new System.Drawing.Point(0, 24);
            this.MainTab.Name = "MainTab";
            this.MainTab.SelectedIndex = 0;
            this.MainTab.Size = new System.Drawing.Size(1008, 338);
            this.MainTab.TabIndex = 4;
            // 
            // TabPage1
            // 
            this.TabPage1.Controls.Add(this.AutoCompleteBox);
            this.TabPage1.Controls.Add(this.ProgressBar1);
            this.TabPage1.Controls.Add(this.RichTextBox1);
            this.TabPage1.Location = new System.Drawing.Point(4, 22);
            this.TabPage1.Name = "TabPage1";
            this.TabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.TabPage1.Size = new System.Drawing.Size(1000, 312);
            this.TabPage1.TabIndex = 0;
            this.TabPage1.Text = "Console";
            this.TabPage1.UseVisualStyleBackColor = true;
            // 
            // AutoCompleteBox
            // 
            this.AutoCompleteBox.FormattingEnabled = true;
            this.AutoCompleteBox.Location = new System.Drawing.Point(8, 16);
            this.AutoCompleteBox.Name = "AutoCompleteBox";
            this.AutoCompleteBox.Size = new System.Drawing.Size(179, 277);
            this.AutoCompleteBox.TabIndex = 6;
            this.AutoCompleteBox.Visible = false;
            // 
            // ProgressBar1
            // 
            this.ProgressBar1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ProgressBar1.Location = new System.Drawing.Point(3, 299);
            this.ProgressBar1.Name = "ProgressBar1";
            this.ProgressBar1.Size = new System.Drawing.Size(994, 10);
            this.ProgressBar1.TabIndex = 7;
            this.ProgressBar1.Value = 45;
            // 
            // RichTextBox1
            // 
            this.RichTextBox1.AcceptsTab = true;
            this.RichTextBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(66)))), ((int)(((byte)(66)))), ((int)(((byte)(81)))));
            this.RichTextBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.RichTextBox1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(200)))), ((int)(((byte)(200)))), ((int)(((byte)(200)))));
            this.RichTextBox1.Location = new System.Drawing.Point(3, 3);
            this.RichTextBox1.Name = "RichTextBox1";
            this.RichTextBox1.Size = new System.Drawing.Size(994, 306);
            this.RichTextBox1.TabIndex = 5;
            this.RichTextBox1.Text = "";
            this.RichTextBox1.WordWrap = false;
            this.RichTextBox1.KeyDown += new System.Windows.Forms.KeyEventHandler(this.OnConsoleKeyDown);
            this.RichTextBox1.KeyUp += new System.Windows.Forms.KeyEventHandler(this.OnConsoleKeyUp);
            // 
            // BtnClose
            // 
            this.BtnClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnClose.Location = new System.Drawing.Point(976, 1);
            this.BtnClose.Name = "BtnClose";
            this.BtnClose.Size = new System.Drawing.Size(28, 23);
            this.BtnClose.TabIndex = 5;
            this.BtnClose.Text = "X";
            this.BtnClose.UseVisualStyleBackColor = true;
            this.BtnClose.Click += new System.EventHandler(this.BtnClose_Click);
            // 
            // BtnMax
            // 
            this.BtnMax.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnMax.Location = new System.Drawing.Point(942, 0);
            this.BtnMax.Name = "BtnMax";
            this.BtnMax.Size = new System.Drawing.Size(28, 23);
            this.BtnMax.TabIndex = 6;
            this.BtnMax.Text = "☐";
            this.BtnMax.UseVisualStyleBackColor = true;
            this.BtnMax.Click += new System.EventHandler(this.BtnMax_Click);
            // 
            // BtnMin
            // 
            this.BtnMin.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnMin.Location = new System.Drawing.Point(908, 1);
            this.BtnMin.Name = "BtnMin";
            this.BtnMin.Size = new System.Drawing.Size(28, 23);
            this.BtnMin.TabIndex = 7;
            this.BtnMin.Text = "-";
            this.BtnMin.UseVisualStyleBackColor = true;
            this.BtnMin.Click += new System.EventHandler(this.BtnMin_Click);
            // 
            // FileToolStripMenuItem
            // 
            this.FileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.SaveAsToolStripMenuItem,
            this.ExitToolStripMenuItem});
            this.FileToolStripMenuItem.Name = "FileToolStripMenuItem";
            this.FileToolStripMenuItem.Size = new System.Drawing.Size(46, 20);
            this.FileToolStripMenuItem.Text = "Main";
            // 
            // SaveAsToolStripMenuItem
            // 
            this.SaveAsToolStripMenuItem.Name = "SaveAsToolStripMenuItem";
            this.SaveAsToolStripMenuItem.Size = new System.Drawing.Size(123, 22);
            this.SaveAsToolStripMenuItem.Text = "Save As...";
            this.SaveAsToolStripMenuItem.Click += new System.EventHandler(this.OnsaveAsToolStripMenuItem_Click);
            // 
            // ExitToolStripMenuItem
            // 
            this.ExitToolStripMenuItem.Name = "ExitToolStripMenuItem";
            this.ExitToolStripMenuItem.Size = new System.Drawing.Size(123, 22);
            this.ExitToolStripMenuItem.Text = "Exit";
            this.ExitToolStripMenuItem.Click += new System.EventHandler(this.OnexitToolStripMenuItem_Click);
            // 
            // AboutToolStripMenuItem
            // 
            this.AboutToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ShowHelpToolStripMenuItem,
            this.AboutMcConsoleToolStripMenuItem});
            this.AboutToolStripMenuItem.Name = "AboutToolStripMenuItem";
            this.AboutToolStripMenuItem.Size = new System.Drawing.Size(44, 20);
            this.AboutToolStripMenuItem.Text = "Help";
            // 
            // ShowHelpToolStripMenuItem
            // 
            this.ShowHelpToolStripMenuItem.Name = "ShowHelpToolStripMenuItem";
            this.ShowHelpToolStripMenuItem.Size = new System.Drawing.Size(127, 22);
            this.ShowHelpToolStripMenuItem.Text = "View Help";
            this.ShowHelpToolStripMenuItem.Click += new System.EventHandler(this.OnshowHelpToolStripMenuItem_Click);
            // 
            // AboutMcConsoleToolStripMenuItem
            // 
            this.AboutMcConsoleToolStripMenuItem.Name = "AboutMcConsoleToolStripMenuItem";
            this.AboutMcConsoleToolStripMenuItem.Size = new System.Drawing.Size(127, 22);
            this.AboutMcConsoleToolStripMenuItem.Text = "About";
            this.AboutMcConsoleToolStripMenuItem.Click += new System.EventHandler(this.OnaboutMcConsoleToolStripMenuItem_Click);
            // 
            // MainMenu
            // 
            this.MainMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.FileToolStripMenuItem,
            this.EditToolStripMenuItem,
            this.AboutToolStripMenuItem});
            this.MainMenu.Location = new System.Drawing.Point(0, 0);
            this.MainMenu.Name = "MainMenu";
            this.MainMenu.Size = new System.Drawing.Size(1008, 24);
            this.MainMenu.TabIndex = 3;
            this.MainMenu.Text = "menuStrip1";
            this.MainMenu.MouseDown += new System.Windows.Forms.MouseEventHandler(this.OnTitleMouseDown);
            // 
            // EditToolStripMenuItem
            // 
            this.EditToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.copyCurrentToolStripMenuItem,
            this.ClearCurrentTabToolStripMenuItem1,
            this.ClearAllTabsToolStripMenuItem1,
            this.acceleratorsSwitchToolStripMenuItem});
            this.EditToolStripMenuItem.Name = "EditToolStripMenuItem";
            this.EditToolStripMenuItem.Size = new System.Drawing.Size(39, 20);
            this.EditToolStripMenuItem.Text = "Edit";
            // 
            // copyCurrentToolStripMenuItem
            // 
            this.copyCurrentToolStripMenuItem.Name = "copyCurrentToolStripMenuItem";
            this.copyCurrentToolStripMenuItem.Size = new System.Drawing.Size(180, 22);
            this.copyCurrentToolStripMenuItem.Text = "Copy";
            this.copyCurrentToolStripMenuItem.Click += new System.EventHandler(this.OncopyCurrentToolStripMenuItem_Click);
            // 
            // ClearCurrentTabToolStripMenuItem1
            // 
            this.ClearCurrentTabToolStripMenuItem1.Name = "ClearCurrentTabToolStripMenuItem1";
            this.ClearCurrentTabToolStripMenuItem1.Size = new System.Drawing.Size(180, 22);
            this.ClearCurrentTabToolStripMenuItem1.Text = "Clear";
            this.ClearCurrentTabToolStripMenuItem1.Click += new System.EventHandler(this.OnclearCurrentTabToolStripMenuItem1_Click);
            // 
            // ClearAllTabsToolStripMenuItem1
            // 
            this.ClearAllTabsToolStripMenuItem1.Name = "ClearAllTabsToolStripMenuItem1";
            this.ClearAllTabsToolStripMenuItem1.Size = new System.Drawing.Size(180, 22);
            this.ClearAllTabsToolStripMenuItem1.Text = "Clear All";
            this.ClearAllTabsToolStripMenuItem1.Click += new System.EventHandler(this.OnclearAllTabsToolStripMenuItem1_Click);
            // 
            // BtnTopmost
            // 
            this.BtnTopmost.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnTopmost.Location = new System.Drawing.Point(874, 1);
            this.BtnTopmost.Name = "BtnTopmost";
            this.BtnTopmost.Size = new System.Drawing.Size(28, 23);
            this.BtnTopmost.TabIndex = 8;
            this.BtnTopmost.Text = "∇";
            this.BtnTopmost.UseVisualStyleBackColor = true;
            this.BtnTopmost.Click += new System.EventHandler(this.BtnTopMost_Click);
            // 
            // acceleratorsSwitchToolStripMenuItem
            // 
            this.acceleratorsSwitchToolStripMenuItem.Name = "acceleratorsSwitchToolStripMenuItem";
            this.acceleratorsSwitchToolStripMenuItem.Size = new System.Drawing.Size(180, 22);
            this.acceleratorsSwitchToolStripMenuItem.Text = "AcceleratorsSwitch";
            this.acceleratorsSwitchToolStripMenuItem.Click += new System.EventHandler(this.acceleratorsSwitchToolStripMenuItem_Click);
            // 
            // McConsole
            // 
            this.ClientSize = new System.Drawing.Size(1008, 362);
            this.Controls.Add(this.BtnTopmost);
            this.Controls.Add(this.BtnMin);
            this.Controls.Add(this.BtnMax);
            this.Controls.Add(this.BtnClose);
            this.Controls.Add(this.MainTab);
            this.Controls.Add(this.MainMenu);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "McConsole";
            this.Text = "Proces:";
            this.MainTab.ResumeLayout(false);
            this.TabPage1.ResumeLayout(false);
            this.MainMenu.ResumeLayout(false);
            this.MainMenu.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private SaveFileDialog SaveFileDialog;
        private TabControl MainTab;
        private TabPage TabPage1;
        private RichTextBox RichTextBox1;
        private ListBox AutoCompleteBox;
        private ProgressBar ProgressBar1;
        private Button BtnClose;
        private Button BtnMax;
        private Button BtnMin;
        private ToolStripMenuItem FileToolStripMenuItem;
        private ToolStripMenuItem SaveAsToolStripMenuItem;
        private ToolStripMenuItem ExitToolStripMenuItem;
        private ToolStripMenuItem AboutToolStripMenuItem;
        private ToolStripMenuItem ShowHelpToolStripMenuItem;
        private ToolStripMenuItem AboutMcConsoleToolStripMenuItem;
        private MenuStrip MainMenu;
        private ToolStripMenuItem EditToolStripMenuItem;
        private ToolStripMenuItem ClearCurrentTabToolStripMenuItem1;
        private ToolStripMenuItem ClearAllTabsToolStripMenuItem1;
        private ToolStripMenuItem copyCurrentToolStripMenuItem;
        private Button BtnTopmost;
        private ToolStripMenuItem acceleratorsSwitchToolStripMenuItem;
    }
}
