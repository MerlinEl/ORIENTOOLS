using System.Windows.Forms;

namespace Orien.Tools {
    public class McThreadHelper {
        delegate void SetTextCallback(Form f, TextBox ctrl, string text, bool append);
        public void SetText(Form form, TextBox ctrl, string text, bool append = true) {
            // InvokeRequired required compares the thread ID of the 
            // calling thread to the thread ID of the creating thread. 
            // If these threads are different, it returns true. 
            if (ctrl == null) return;
            if (ctrl.InvokeRequired) {
                SetTextCallback d = new SetTextCallback(SetText);
                form.Invoke(d, new object[] { form, ctrl, text });
            } else {
                if (append) { ctrl.AppendText(text); } else { ctrl.Text = text; };
            }
        }
    }
}