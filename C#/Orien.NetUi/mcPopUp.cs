using System;
using System.IO;
using System.Reflection;
using System.Windows.Forms;

namespace Orien.NetUi {

    public class McPopup {
        public const string Awesome = "Awesome";
        static void OrienTools() {
            AppDomain.CurrentDomain.AssemblyResolve += new ResolveEventHandler(AssemblyResolver);
        }

        static Assembly AssemblyResolver(object sender, ResolveEventArgs args) {
            Assembly thisAssembly = Assembly.GetExecutingAssembly();

            //this is the resource name of the assembly I want to load
            string resourceName = "Orien.NetUi.Orien.Tools.dll";
            Stream resourceStream = thisAssembly.GetManifestResourceStream(resourceName);

            //convert the stream to something we can load as an assembly
            byte[] buffer = new byte[resourceStream.Length];
            resourceStream.Read(buffer, 0, buffer.Length);
            Assembly referencedAssembly = Assembly.Load(buffer);
            return referencedAssembly;
        }
        /// <summary>
        /// Define PopUp Windows Type
        /// </summary>
        public class Options {
            public bool ConfirmToClose { get; set; } = true;
            public bool ShowButtonOnDone { get; set; } = true;
        }

        public enum WindowType {
            E_Default = 0, // window with text message                (bordercolor green)
            E_Warning = 1, // window with text message                (bordercolor orange)
            E_Error = 2, // window with text message                (bordercolor red)
            E_Confirm = 3, // window with text message and OK button  (bordercolor green)
            E_YesNo = 4, // window with text message and YES NO buttons
            E_Input = 5, // window with text message and YES NO buttons and Edit Field
            E_Progress = 6  // window with text message and Circular Progressbar
        }

        public static Form Create(string msg, string title) { //default confirm box
            return GetWindow(msg, title, WindowType.E_Default, new Options()); // use default options
        }

        public static Form Create(string msg, string title, WindowType type, Options options) { //for progressbar
            //Array.CreateInstance(typeof(Int32),1, 2)
            return GetWindow(msg, "", type, options);
        }

        public static object GetTypes() => new WindowType();
        public static object GetOptions() => new Options();

        /*public static Form Create(
            WindowType type,
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
            return GetWindow(WindowType.E_Default, msg, title);
        }*/

        private static Form GetWindow(string msg, string title, WindowType type, Options options) {
            Form form = new Form();
            //var map = EnumNamedValues<WindowType>();
            switch (type) {
                case WindowType.E_Default:
                    break;

                case WindowType.E_Warning:
                    break;

                case WindowType.E_Error:
                    break;

                case WindowType.E_Confirm:
                    break;

                case WindowType.E_YesNo:
                    break;

                case WindowType.E_Input:
                    break;

                case WindowType.E_Progress:
                    form = new McPopUpProgressBar(msg, options.ConfirmToClose, options.ShowButtonOnDone, true); //turn off last bool(Debug)
                    break;
            }
            return form;
        }
    }

    /**/

    /*public interface IPopup {
        enum WindowType { get; }
        Form Create();
    }*/
}

/*
public static object GetTypes() => Enum.ToObject(typeof(WindowType), 0);
*
*
 * ::mcPopUp.show ">< Is Done ><" delay:2000
::mcPopUp.show "<< abc >>\ncde" title:"ABC:" delay:2000 pos:[90, 313]
::mcPopUp.show "Micra instalation was Finished"
::mcPopUp.show "Select some Objects to Continue" type:#Warning
::mcPopUp.show "But this also aligns the label control to the centre" title:"Info:" pos:[90, 313]
::mcPopUp.show "DotNet controls cannot only be placed inside 3ds Max Dialogs and Rollouts, but they can also be used to generate user interfaces implemented completely using DotNet Forms." title:"Info:" pos:[90, 313]
if (::mcPopUp.show "Do you want create a 'New Scene'?." title:"Micra:" type:#YesNo) == true then (format "Accepted\n") else (format "Canceled:\n")

::mcPopUp.show "Tpe new object Name" title:"Collapse stack:" type:#Input*/
