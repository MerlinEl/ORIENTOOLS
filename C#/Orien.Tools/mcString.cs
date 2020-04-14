using System;
using System.Text.RegularExpressions;

namespace Orien.Tools {
    public class mcString {
        public static int LastIndexOf(string str, string find_str) => str.LastIndexOf(find_str);
        public static string CondenseTabsAndNewLines(string str) => Regex.Replace(str, @"\s\s+", "");
        public static string PackString(string[] str_arr, string delimiter) => string.Join(delimiter, str_arr);
        public static void ExtensionsTest() {

        }
    }
    /// <summary>
    /// Replace Extension > replace all occurences(separators) in string
    /// char[] separators = new char[]{' ',';',',','\r','\t','\n'};
    /// string s = "this;is,\ra\t\n\n\ntest";
    /// s = s.Replace(separators, "\n");
    /// </summary>
    public static class ExtensionMethods {
        public static string Replace(this string s, char[] separators, string new_str) {
            string[] arr;

            arr = s.Split(separators, StringSplitOptions.RemoveEmptyEntries);
            return String.Join(new_str, arr);
        }
    }
}


/*
Regex >
--replace all tabs
str = Regex.Replace(str, @"\s+", " ");
--
str = Regex.Replace(str, @"\s\s+", "");
str = Regex.Replace(str, @"\t|\n|\r", "")
--
Environment.NewLine == \n
String.Empty == ""
 */
