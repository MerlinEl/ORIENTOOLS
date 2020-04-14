using System.Windows.Forms;

namespace Orien.NetUi {
    class mcThreadHelper {
        delegate void SetTextCallback(Form f, Control ctrl, string text);
        /// <summary>
        /// Set text property of various controls
        /// </summary>
        /// <param name="form">The calling form</param>
        /// <param name="ctrl"></param>
        /// <param name="text"></param>
        public static void SetText(Form form, Control ctrl, string text) {
            // InvokeRequired required compares the thread ID of the 
            // calling thread to the thread ID of the creating thread. 
            // If these threads are different, it returns true. 
            if (ctrl.InvokeRequired) {
                SetTextCallback d = new SetTextCallback(SetText);
                form.Invoke(d, new object[] { form, ctrl, text });
            } else {
                ctrl.Text = text;
            }
        }
        delegate void SetValueCallback(Form f, ProgressBar ctrl, int value);
        /// <summary>
        /// Set value property of various controls
        /// </summary>
        /// <param name="form"></param>
        /// <param name="ctrl"></param>
        /// <param name="value"></param>
        public static void SetValue(Form form, ProgressBar ctrl, int value) {

            if (ctrl.InvokeRequired) {
                SetValueCallback d = new SetValueCallback(SetValue);
                form.Invoke(d, new object[] { form, ctrl, value });
            } else {
                ctrl.Value = value < 100 ? value : 100;
            }
        }
    }
}
