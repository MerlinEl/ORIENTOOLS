using System.Drawing;
using System.Windows.Forms;

namespace Orien.NetUi {

    public class mcPopup {

        private static string _msg;
        private static string _title;
        private static WindowType _type;
        private static float _delay;
        private static Point _pos;
        private static bool _crypt;
        /// <summary>
        /// Define PopUp Windows Type
        /// </summary>
        public enum WindowType {
            E_Default   = 0, // window with text message                (bordercolor green)
            E_Warning   = 1, // window with text message                (bordercolor orange)
            E_Error     = 2, // window with text message                (bordercolor red)
            E_Confirm   = 3, // window with text message and OK button  (bordercolor green)
            E_YesNo     = 4, // window with text message and YES NO buttons
            E_Input     = 5, // window with text message and YES NO buttons and Edit Field
            E_Progress  = 6  // window with text message and Circular Progressbar
        }
        public static Form Create (
            WindowType type = WindowType.E_Default,
            string msg = "",
            string title = "",
            float delay = 0, 
            Point pos = new Point(), 
            bool crypt = false
        ) {
            _msg = msg;
            _title = title;
            _type = type;
            _delay = delay;
            _pos = pos;
            _crypt = crypt;
            Form form = new mcPopUpProgressBar(msg, true, true, true);
            return form;
        }
    }
}
/*::mcPopUp.show ">< Is Done ><" delay:2000
::mcPopUp.show "<< abc >>\ncde" title:"ABC:" delay:2000 pos:[90, 313]
::mcPopUp.show "Micra instalation was Finished"
::mcPopUp.show "Select some Objects to Continue" type:#Warning
::mcPopUp.show "But this also aligns the label control to the centre" title:"Info:" pos:[90, 313]
::mcPopUp.show "DotNet controls cannot only be placed inside 3ds Max Dialogs and Rollouts, but they can also be used to generate user interfaces implemented completely using DotNet Forms." title:"Info:" pos:[90, 313]
if (::mcPopUp.show "Do you want create a 'New Scene'?." title:"Micra:" type:#YesNo) == true then (format "Accepted\n") else (format "Canceled:\n")

::mcPopUp.show "Tpe new object Name" title:"Collapse stack:" type:#Input*/
