using System.Drawing;

namespace Orien.NetUi {
    partial class McConsole {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if (disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        protected void InitializeComponent() {
            this.MainMenu = new System.Windows.Forms.MenuStrip();
            this.FileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.SaveAsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ExitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.EditToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.copyCurrentToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ClearCurrentTabToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.ClearAllTabsToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.acceleratorsSwitchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.AboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ShowHelpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.AboutMcConsoleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.BtnTopmost = new System.Windows.Forms.Button();
            this.BtnMin = new System.Windows.Forms.Button();
            this.BtnMax = new System.Windows.Forms.Button();
            this.BtnClose = new System.Windows.Forms.Button();
            this.SaveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.MainTab = new Orien.NetUi.McTabs();
            this.TabPage1 = new System.Windows.Forms.TabPage();
            this.AutoCompleteBox = new System.Windows.Forms.ListBox();
            this.ProgressBar1 = new Orien.NetUi.McProgressBar();
            this.RichTextBox1 = new System.Windows.Forms.RichTextBox();
            this.MainMenu.SuspendLayout();
            this.MainTab.SuspendLayout();
            this.TabPage1.SuspendLayout();
            this.SuspendLayout();
            // 
            // MainMenu
            // 
            this.MainMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.FileToolStripMenuItem,
            this.EditToolStripMenuItem,
            this.AboutToolStripMenuItem});
            this.MainMenu.Location = new System.Drawing.Point(0, 0);
            this.MainMenu.Name = "MainMenu";
            this.MainMenu.Size = new System.Drawing.Size(992, 24);
            this.MainMenu.TabIndex = 4;
            this.MainMenu.Text = "menuStrip1";
            this.MainMenu.MouseDown += new System.Windows.Forms.MouseEventHandler(this.OnTitleMouseDown);
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
            this.copyCurrentToolStripMenuItem.Size = new System.Drawing.Size(174, 22);
            this.copyCurrentToolStripMenuItem.Text = "Copy";
            this.copyCurrentToolStripMenuItem.Click += new System.EventHandler(this.OncopyCurrentToolStripMenuItem_Click);
            // 
            // ClearCurrentTabToolStripMenuItem1
            // 
            this.ClearCurrentTabToolStripMenuItem1.Name = "ClearCurrentTabToolStripMenuItem1";
            this.ClearCurrentTabToolStripMenuItem1.Size = new System.Drawing.Size(174, 22);
            this.ClearCurrentTabToolStripMenuItem1.Text = "Clear";
            this.ClearCurrentTabToolStripMenuItem1.Click += new System.EventHandler(this.OnclearCurrentTabToolStripMenuItem1_Click);
            // 
            // ClearAllTabsToolStripMenuItem1
            // 
            this.ClearAllTabsToolStripMenuItem1.Name = "ClearAllTabsToolStripMenuItem1";
            this.ClearAllTabsToolStripMenuItem1.Size = new System.Drawing.Size(174, 22);
            this.ClearAllTabsToolStripMenuItem1.Text = "Clear All";
            this.ClearAllTabsToolStripMenuItem1.Click += new System.EventHandler(this.OnclearAllTabsToolStripMenuItem1_Click);
            // 
            // acceleratorsSwitchToolStripMenuItem
            // 
            this.acceleratorsSwitchToolStripMenuItem.Name = "acceleratorsSwitchToolStripMenuItem";
            this.acceleratorsSwitchToolStripMenuItem.Size = new System.Drawing.Size(174, 22);
            this.acceleratorsSwitchToolStripMenuItem.Text = "AcceleratorsSwitch";
            this.acceleratorsSwitchToolStripMenuItem.Click += new System.EventHandler(this.OnacceleratorsSwitchToolStripMenuItem_Click);
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
            // BtnTopmost
            // 
            this.BtnTopmost.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnTopmost.Location = new System.Drawing.Point(860, 1);
            this.BtnTopmost.Name = "BtnTopmost";
            this.BtnTopmost.Size = new System.Drawing.Size(28, 23);
            this.BtnTopmost.TabIndex = 12;
            this.BtnTopmost.Text = "∇";
            this.BtnTopmost.UseVisualStyleBackColor = true;
            this.BtnTopmost.Click += new System.EventHandler(this.BtnTopMost_Click);
            // 
            // BtnMin
            // 
            this.BtnMin.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnMin.Location = new System.Drawing.Point(894, 1);
            this.BtnMin.Name = "BtnMin";
            this.BtnMin.Size = new System.Drawing.Size(28, 23);
            this.BtnMin.TabIndex = 11;
            this.BtnMin.Text = "-";
            this.BtnMin.UseVisualStyleBackColor = true;
            this.BtnMin.Click += new System.EventHandler(this.BtnMin_Click);
            // 
            // BtnMax
            // 
            this.BtnMax.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnMax.Location = new System.Drawing.Point(928, 0);
            this.BtnMax.Name = "BtnMax";
            this.BtnMax.Size = new System.Drawing.Size(28, 23);
            this.BtnMax.TabIndex = 10;
            this.BtnMax.Text = "☐";
            this.BtnMax.UseVisualStyleBackColor = true;
            this.BtnMax.Click += new System.EventHandler(this.BtnMax_Click);
            // 
            // BtnClose
            // 
            this.BtnClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.BtnClose.Location = new System.Drawing.Point(962, 1);
            this.BtnClose.Name = "BtnClose";
            this.BtnClose.Size = new System.Drawing.Size(28, 23);
            this.BtnClose.TabIndex = 9;
            this.BtnClose.Text = "X";
            this.BtnClose.UseVisualStyleBackColor = true;
            this.BtnClose.Click += new System.EventHandler(this.BtnClose_Click);
            // 
            // MainTab
            // 
            this.MainTab.ActiveTabEndColor = System.Drawing.Color.DarkOrange;
            this.MainTab.ActiveTabStartColor = System.Drawing.Color.Yellow;
            this.MainTab.CloseButtonColor = System.Drawing.Color.Red;
            this.MainTab.Controls.Add(this.TabPage1);
            this.MainTab.Dock = System.Windows.Forms.DockStyle.Fill;
            this.MainTab.DrawMode = System.Windows.Forms.TabDrawMode.OwnerDrawFixed;
            this.MainTab.GradientAngle = 90;
            this.MainTab.Location = new System.Drawing.Point(0, 24);
            this.MainTab.Name = "MainTab";
            this.MainTab.NonActiveTabEndColor = System.Drawing.Color.DarkOliveGreen;
            this.MainTab.NonActiveTabStartColor = System.Drawing.Color.LightGreen;
            this.MainTab.Padding = new System.Drawing.Point(22, 4);
            this.MainTab.SelectedIndex = 0;
            this.MainTab.Size = new System.Drawing.Size(992, 340);
            this.MainTab.TabIndex = 5;
            this.MainTab.TextColor = System.Drawing.Color.Navy;
            this.MainTab.Transparent1 = 150;
            this.MainTab.Transparent2 = 150;
            // 
            // TabPage1
            // 
            this.TabPage1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(165)))), ((int)(((byte)(115)))), ((int)(((byte)(215)))));
            this.TabPage1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.TabPage1.Controls.Add(this.AutoCompleteBox);
            this.TabPage1.Controls.Add(this.ProgressBar1);
            this.TabPage1.Controls.Add(this.RichTextBox1);
            this.TabPage1.ForeColor = System.Drawing.SystemColors.ControlText;
            this.TabPage1.Location = new System.Drawing.Point(4, 24);
            this.TabPage1.Name = "TabPage1";
            this.TabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.TabPage1.Size = new System.Drawing.Size(984, 312);
            this.TabPage1.TabIndex = 0;
            this.TabPage1.Text = "Console";
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
            this.ProgressBar1.BackColor = System.Drawing.Color.MediumAquamarine;
            this.ProgressBar1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ProgressBar1.ForeColor = System.Drawing.Color.Aquamarine;
            this.ProgressBar1.HideBar = false;
            this.ProgressBar1.Location = new System.Drawing.Point(3, 297);
            this.ProgressBar1.Name = "ProgressBar1";
            this.ProgressBar1.Size = new System.Drawing.Size(976, 10);
            this.ProgressBar1.TabIndex = 7;
            this.ProgressBar1.TextColor = System.Drawing.SystemColors.ControlText;
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
            this.RichTextBox1.Size = new System.Drawing.Size(976, 304);
            this.RichTextBox1.TabIndex = 5;
            this.RichTextBox1.Text = "";
            this.RichTextBox1.WordWrap = false;
            this.RichTextBox1.KeyDown += new System.Windows.Forms.KeyEventHandler(this.OnConsoleKeyDown);
            this.RichTextBox1.KeyUp += new System.Windows.Forms.KeyEventHandler(this.OnConsoleKeyUp);
            // 
            // McConsole
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(992, 364);
            this.Controls.Add(this.BtnTopmost);
            this.Controls.Add(this.BtnMin);
            this.Controls.Add(this.BtnMax);
            this.Controls.Add(this.BtnClose);
            this.Controls.Add(this.MainTab);
            this.Controls.Add(this.MainMenu);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "McConsole";
            this.Text = "McConsoleC";
            this.MainMenu.ResumeLayout(false);
            this.MainMenu.PerformLayout();
            this.MainTab.ResumeLayout(false);
            this.TabPage1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip MainMenu;
        private System.Windows.Forms.ToolStripMenuItem FileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem SaveAsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ExitToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem EditToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem copyCurrentToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ClearCurrentTabToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem ClearAllTabsToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem acceleratorsSwitchToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem AboutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ShowHelpToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem AboutMcConsoleToolStripMenuItem;
        private System.Windows.Forms.TabPage TabPage1;
        protected System.Windows.Forms.ListBox AutoCompleteBox;
        protected System.Windows.Forms.RichTextBox RichTextBox1;
        private System.Windows.Forms.Button BtnTopmost;
        private System.Windows.Forms.Button BtnMin;
        private System.Windows.Forms.Button BtnMax;
        private System.Windows.Forms.Button BtnClose;
        private System.Windows.Forms.SaveFileDialog SaveFileDialog;
        private McTabs MainTab;
        private McProgressBar ProgressBar1;
    }
}