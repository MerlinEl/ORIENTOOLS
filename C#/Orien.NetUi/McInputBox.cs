using System;
using System.Drawing;
using System.Windows.Forms;

namespace Orien.NetUi {
    public partial class McInputBox : Form {

        public McInputBox() {
            InitializeComponent();
        }
        public string Input {
            get { return textInput.Text; }
        }

        private void Button2_Click(object sender, EventArgs e) {
            DialogResult = DialogResult.OK;
        }

        private void Button1_Click(object sender, EventArgs e) {
            DialogResult = DialogResult.Cancel;
        }

        private void InputBox_Load(object sender, EventArgs e) {
            this.ActiveControl = textInput;
        }

        public static DialogResult Show(string title, string message, string inputTitle, out string inputValue, bool showAsPassword = false) {
            DialogResult results = DialogResult.None;

            McInputBox inputBox;
            using (inputBox = new McInputBox() { Text = title }) {
                if (showAsPassword) inputBox.textInput.PasswordChar = '*';
                inputBox.labelMessage.Text = message;
                inputBox.splitContainer2.SplitterDistance = inputBox.labelMessage.Width;
                inputBox.labelInput.Text = inputTitle;
                inputBox.splitContainer1.SplitterDistance = inputBox.labelInput.Width;
                inputBox.Size = new Size(
                    inputBox.Width,
                    8 + inputBox.labelMessage.Height +
                    inputBox.splitContainer2.SplitterWidth +
                    inputBox.splitContainer1.Height + 8 +
                    inputBox.button2.Height + 12 + (50)
                );

                results = inputBox.ShowDialog();
                inputValue = inputBox.Input;
            }
            return results;
        }

        void LabelInput_TextChanged(object sender, EventArgs e) {
        }

        private void OnTextBoxKeyDown(object sender, KeyEventArgs e) {
            if (e.KeyCode == Keys.Escape) {
                this.Close();
            }
        }

        private void OnFormShown(object sender, EventArgs e) {
            textInput.Focus();
        }

        private void OnTextBoxKeyPress(object sender, KeyPressEventArgs e) {

            if (e.KeyChar == (char)Keys.Enter) {
                e.Handled = true;
                button2.PerformClick();
            }
        }
    }
}
