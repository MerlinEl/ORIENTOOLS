using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Reflection;
using System.IO;
using Microsoft.CSharp;
using System.CodeDom.Compiler;

namespace ScriptEditor
{
    public partial class EditorForm : MaxCustomControls.MaxForm
    {
        public static string DefaultFileName { get { return "<untitled>"; } }
        
        public string FileName = DefaultFileName;

        public EditorForm()
        {
            InitializeComponent();

            New();
        }

        void OpenFile(string fileName)
        {
            richTextBox1.Text = File.ReadAllText(fileName);
            richTextBox1.Modified = false;
            FileName = fileName;
        }

        bool Open()
        {
            if (!ModifiedCheckCanContinue())
                return false;
            if (openFileDialog1.ShowDialog() != DialogResult.OK)
                return false;
            OpenFile(openFileDialog1.FileName);
            return true;
        }

        void New()
        {
            if (cToolStripMenuItem.Checked)
                SetTextToDefaultCSharpScript();
            else
                SetTextToDefaultPythonScript();
        }

        bool Save(bool bForceShowDialog = false)
        {
            if (FileName == DefaultFileName || bForceShowDialog)
            {
                if (saveFileDialog1.ShowDialog() != DialogResult.OK)
                    return false;
                FileName = saveFileDialog1.FileName;
            }
            File.WriteAllText(FileName, richTextBox1.Text);
            richTextBox1.Modified = false;
            return true;
        }

        bool ModifiedCheckCanContinue()
        {
            if (!richTextBox1.Modified)
                return true;
            var r = MessageBox.Show("Text modified, save?", "Save and continue", MessageBoxButtons.YesNoCancel);

            if (r == DialogResult.Cancel)
                return false;
            else if (r == DialogResult.No)
                return true;
            else
                return Save();
        }

        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Open();
        }

        private void EditorForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            e.Cancel = true; // Never really close.
            if (ModifiedCheckCanContinue())
                Hide();
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void saveToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Save();
        }

        public void CompileAndRun(CodeDomProvider provider)
        {
            richTextBox2.Clear();
            OutputLine("-= Executing C# script =-");
            try
            {
                var config = Config.Default;
                var result = DotNetCompilers.Compile(provider, config.Assemblies, richTextBox1.Text);
                if (result.Errors.Count > 0)
                {
                    OutputLine("Compilation failed");
                    foreach (var e in result.Errors)
                        OutputLine(String.Format("Compilation error : {0}", e.ToString()));
                    return;
                }
                else
                {
                    OutputLine("Compilation succeeded");
                    DotNetCompilers.RunMain(result.CompiledAssembly);
                }
            }
            catch (System.Exception ex)
            {
                OutputLine("Exception occurred " + ex.Message);
            }
            OutputLine("-= Completed executing script =-");
            Utilities.Interface.ForceCompleteRedraw(false);
        }

        public void Output(string s)
        {
            richTextBox2.AppendText(s);
        }

        public void OutputLine(string s = "")
        {
            Output(s);
            Output("\n");
        }

        private void SetTextToDefaultCSharpScript()
        {
            if (ModifiedCheckCanContinue())
            {
                richTextBox1.Text = @"using System;
using System.Collections.Generic;
using Autodesk.Max;
using ScriptEditor;

namespace Test
{
    public class Program
    {
        public static void Main(string[] args)
        {
            ScriptEditor.Utilities.WriteLine(""Hello World from the MAXScript listener window!"");
        }
    }
}
";
                richTextBox1.Modified = false;
            }
        }

        private void SetTextToDefaultPythonScript()
        {
            if (ModifiedCheckCanContinue())
            {
                richTextBox1.Text = @"import sys, os
import MaxPlus

MaxPlus.Core.WriteLine(""Hello from the MAXScript listener"")
";
                richTextBox1.Modified = false;
            }
        }

        private void richTextBox1_KeyDown(object sender, KeyEventArgs e)
        {
            switch (e.KeyCode)
            {
                case Keys.Tab:
                    {
                        richTextBox1.SelectedText = "    ";
                        e.Handled = true;
                        break;
                    }
                case Keys.Enter:
                    {
                        int a = richTextBox1.GetFirstCharIndexOfCurrentLine();
                        int b = richTextBox1.SelectionStart;
                        string tmp = richTextBox1.Text.Substring(a, b - a);
                        int n = tmp.Length - tmp.TrimStart().Length;
                        string indent = tmp.Substring(0, n);
                        richTextBox1.SelectedText = "\n" + indent;
                        e.Handled = true;
                    }
                    break;
            }
        }

        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == Keys.Tab)
            {
                richTextBox1.SelectedText = "    ";
                return true;
            }

            return base.ProcessCmdKey(ref msg, keyData);
        }

        private int CurrentCharIndex
        {
            get { return richTextBox1.SelectionStart - richTextBox1.GetFirstCharIndexOfCurrentLine();  }
        }

        private int CurrentLineIndex
        {
            get { return richTextBox1.GetLineFromCharIndex(richTextBox1.SelectionStart); }
        }

        private void richTextBox1_SelectionChanged(object sender, EventArgs e)
        {
            this.toolStripStatusLabel1.Text = String.Format("Column {0}, Line {1}", CurrentCharIndex, CurrentLineIndex);
        }

        private void richTextBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == '\t')
                e.Handled = true;
        }

        private void saveToolStripMenuItem1_Click_1(object sender, EventArgs e)
        {
            Save(true);
        }

        private void openConfigurationToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!ModifiedCheckCanContinue())
                return;
            OpenFile(Config.FilePath);
        }

        private void runToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (cToolStripMenuItem.Checked)
            {
                CompileAndRun(new CSharpCodeProvider());
            }
            else if (pythonToolStripMenuItem.Checked)
            {
                PythonHostInterface.Init();
                richTextBox2.Clear();
                OutputLine("-= Executing Python script =-");
                try
                {
                    // Check for error code
                    if (PythonHostInterface.Execute(richTextBox1.Text) != 0)
                        OutputLine(String.Format("Error: {0}", PythonHostInterface.Error));
                }
                catch (Exception ex)
                {
                    OutputLine(String.Format("Exception: {0}", ex.Message));
                }
                OutputLine("-= Completed executing script =-");
            }
            else
            {
                MessageBox.Show("Could not determine what language to use.");
            }
        }

        private void pythonToolStripMenuItem_Click(object sender, EventArgs e)
        {
            pythonToolStripMenuItem.Checked = true;
            cToolStripMenuItem.Checked = false;
        }

        private void cToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cToolStripMenuItem.Checked = true;
            pythonToolStripMenuItem.Checked = false;
        }

        private void newPythonScriptToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SetTextToDefaultPythonScript();
        }

        private void newToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            if (!ModifiedCheckCanContinue())
                return;
            New();
        }

        private void EditorForm_Shown(object sender, EventArgs e)
        {
            pythonToolStripMenuItem.Visible = File.Exists(Path.Combine(Application.StartupPath, "_MaxPlus.pyd"));
        }
	}
}