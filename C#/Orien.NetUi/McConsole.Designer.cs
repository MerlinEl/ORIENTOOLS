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
            this.mainMenu = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveAsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.clearAllTabsToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.clearCurrentTabToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.showHelpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutMcConsoleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.mainTab = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.autoCompleteBox = new System.Windows.Forms.ListBox();
            this.richTextBox1 = new System.Windows.Forms.RichTextBox();
            this.mainMenu.SuspendLayout();
            this.mainTab.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.SuspendLayout();
            // 
            // mainMenu
            // 
            this.mainMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.aboutToolStripMenuItem});
            this.mainMenu.Location = new System.Drawing.Point(0, 0);
            this.mainMenu.Name = "mainMenu";
            this.mainMenu.Size = new System.Drawing.Size(1008, 24);
            this.mainMenu.TabIndex = 3;
            this.mainMenu.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.saveAsToolStripMenuItem,
            this.clearCurrentTabToolStripMenuItem1,
            this.clearAllTabsToolStripMenuItem1,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(62, 20);
            this.fileToolStripMenuItem.Text = "Console";
            // 
            // saveAsToolStripMenuItem
            // 
            this.saveAsToolStripMenuItem.Name = "saveAsToolStripMenuItem";
            this.saveAsToolStripMenuItem.Size = new System.Drawing.Size(180, 22);
            this.saveAsToolStripMenuItem.Text = "Save As...";
            this.saveAsToolStripMenuItem.Click += new System.EventHandler(this.OnsaveAsToolStripMenuItem_Click);
            // 
            // clearAllTabsToolStripMenuItem1
            // 
            this.clearAllTabsToolStripMenuItem1.Name = "clearAllTabsToolStripMenuItem1";
            this.clearAllTabsToolStripMenuItem1.Size = new System.Drawing.Size(180, 22);
            this.clearAllTabsToolStripMenuItem1.Text = "Clear All";
            this.clearAllTabsToolStripMenuItem1.Click += new System.EventHandler(this.OnclearAllTabsToolStripMenuItem1_Click);
            // 
            // clearCurrentTabToolStripMenuItem1
            // 
            this.clearCurrentTabToolStripMenuItem1.Name = "clearCurrentTabToolStripMenuItem1";
            this.clearCurrentTabToolStripMenuItem1.Size = new System.Drawing.Size(180, 22);
            this.clearCurrentTabToolStripMenuItem1.Text = "Clear Current";
            this.clearCurrentTabToolStripMenuItem1.Click += new System.EventHandler(this.OnclearCurrentTabToolStripMenuItem1_Click);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(180, 22);
            this.exitToolStripMenuItem.Text = "Exit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.OnexitToolStripMenuItem_Click);
            // 
            // aboutToolStripMenuItem
            // 
            this.aboutToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.showHelpToolStripMenuItem,
            this.aboutMcConsoleToolStripMenuItem});
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Size = new System.Drawing.Size(44, 20);
            this.aboutToolStripMenuItem.Text = "Help";
            // 
            // showHelpToolStripMenuItem
            // 
            this.showHelpToolStripMenuItem.Name = "showHelpToolStripMenuItem";
            this.showHelpToolStripMenuItem.Size = new System.Drawing.Size(127, 22);
            this.showHelpToolStripMenuItem.Text = "View Help";
            this.showHelpToolStripMenuItem.Click += new System.EventHandler(this.OnshowHelpToolStripMenuItem_Click);
            // 
            // aboutMcConsoleToolStripMenuItem
            // 
            this.aboutMcConsoleToolStripMenuItem.Name = "aboutMcConsoleToolStripMenuItem";
            this.aboutMcConsoleToolStripMenuItem.Size = new System.Drawing.Size(127, 22);
            this.aboutMcConsoleToolStripMenuItem.Text = "About";
            this.aboutMcConsoleToolStripMenuItem.Click += new System.EventHandler(this.OnaboutMcConsoleToolStripMenuItem_Click);
            // 
            // mainTab
            // 
            this.mainTab.Controls.Add(this.tabPage1);
            this.mainTab.Dock = System.Windows.Forms.DockStyle.Fill;
            this.mainTab.Location = new System.Drawing.Point(0, 24);
            this.mainTab.Name = "mainTab";
            this.mainTab.SelectedIndex = 0;
            this.mainTab.Size = new System.Drawing.Size(1008, 338);
            this.mainTab.TabIndex = 4;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.autoCompleteBox);
            this.tabPage1.Controls.Add(this.richTextBox1);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(1000, 312);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "General";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // autoCompleteBox
            // 
            this.autoCompleteBox.FormattingEnabled = true;
            this.autoCompleteBox.Location = new System.Drawing.Point(8, 30);
            this.autoCompleteBox.Name = "autoCompleteBox";
            this.autoCompleteBox.Size = new System.Drawing.Size(179, 277);
            this.autoCompleteBox.TabIndex = 6;
            this.autoCompleteBox.Visible = false;
            // 
            // richTextBox1
            // 
            this.richTextBox1.AcceptsTab = true;
            this.richTextBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.richTextBox1.Location = new System.Drawing.Point(3, 3);
            this.richTextBox1.Name = "richTextBox1";
            this.richTextBox1.Size = new System.Drawing.Size(994, 306);
            this.richTextBox1.TabIndex = 5;
            this.richTextBox1.Text = "";
            this.richTextBox1.KeyDown += new System.Windows.Forms.KeyEventHandler(this.OnConsoleKeyDown);
            this.richTextBox1.KeyUp += new System.Windows.Forms.KeyEventHandler(this.OnConsoleKeyUp);
            // 
            // McConsole
            // 
            this.ClientSize = new System.Drawing.Size(1008, 362);
            this.Controls.Add(this.mainTab);
            this.Controls.Add(this.mainMenu);
            this.Name = "McConsole";
            this.mainMenu.ResumeLayout(false);
            this.mainMenu.PerformLayout();
            this.mainTab.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private MenuStrip mainMenu;
        private ToolStripMenuItem fileToolStripMenuItem;
        private ToolStripMenuItem saveAsToolStripMenuItem;
        private ToolStripMenuItem clearAllTabsToolStripMenuItem1;
        private ToolStripMenuItem clearCurrentTabToolStripMenuItem1;
        private ToolStripMenuItem exitToolStripMenuItem;
        private ToolStripMenuItem aboutToolStripMenuItem;
        private ToolStripMenuItem showHelpToolStripMenuItem;
        private ToolStripMenuItem aboutMcConsoleToolStripMenuItem;
        private SaveFileDialog saveFileDialog;
        private TabControl mainTab;
        private TabPage tabPage1;
        private RichTextBox richTextBox1;
        private ListBox autoCompleteBox;
    }
}
