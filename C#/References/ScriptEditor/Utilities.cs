using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ScriptEditor
{
    public static class Utilities
    {
        public static Autodesk.Max.IInterface14 Interface
        {
            get { return Global.COREInterface14; }
        }

        public static Autodesk.Max.IGlobal Global
        {
            get { return Autodesk.Max.GlobalInterface.Instance; }
        }

        public static void Write(string s, params string[] args)
        {
            Write(String.Format(s, args));
        }

        public static void Write(string s)
        {
            Global.TheListener.EditStream.Wputs(s);
            Global.TheListener.EditStream.Flush();
        }

        public static void WriteLine(string s)
        {
            Write(s);
            Write("\n");
        }

        public static void WriteLine(string s, params string[] args)
        {
            WriteLine(String.Format(s, args));
        }
    }
}
