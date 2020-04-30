using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace ScriptEditor
{
    public static class PythonHostInterface
    {
        [DllImport("_maxplus.pyd")]
        private static extern int InitPythonInterpreter();

        [DllImport("_maxplus.pyd")]
        private static extern IntPtr GetLastPythonError();

        [DllImport("_maxplus.pyd")]
        private static extern int ExecutePythonString(string s);

        public static int Init() { return InitPythonInterpreter(); }

        public static string Error { get { return Marshal.PtrToStringAnsi(GetLastPythonError()); } }

        public static int Execute(string s) { return ExecutePythonString(s); }
    }
}
