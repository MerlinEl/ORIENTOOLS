using System;
using System.Linq;
using System.Text.RegularExpressions;

namespace Orien.Tools {
    public class mcString {
        public static int LastIndexOf(string str, string find_str) => str.LastIndexOf(find_str);
        public static string CondenseTabsAndNewLines(string str) => Regex.Replace(str, @"\s\s+", "");
        public static string PackString(string[] str_arr, string delimiter) => string.Join(delimiter, str_arr);
        /// <summary>
        /// Repeat sting n times 
        /// Example >  mcString.Multiply("<item>a</item>", 2) => "<item>a</item><item>a</item>"
        /// </summary>
        public static string Multiply(string str, int cnt) => String.Concat(Enumerable.Repeat(str, cnt));
        public static string FilterStars(string str) => string.Join("", str.Split('*')); //filter stars from string
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


/*
using System.Linq;

...

string hex = "0123456789ABCDEFFEDCBA98765432100123456789ABCDEF";

// Eliminating white spaces
hex = string.Concat(hex.Where(c => !char.IsWhiteSpace(c))); 

// Let "binary data based on 0x01 0x23 0xDE..." be an array
byte[] result = Enumerable
.Range(0, hex.Length / 2) // we have hex.Length / 2 pairs
.Select(index => Convert.ToByte(hex.Substring(index * 2, 2), 16))
.ToArray();

// Test (let's print out the result array with items in the hex format)
Console.WriteLine(string.Join(" ", result.Select(b => $"0x{b:X2}")));
 */
