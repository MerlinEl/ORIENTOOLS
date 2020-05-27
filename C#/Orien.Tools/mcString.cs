using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Orien.Tools {
    public class McString {
        public static int LastIndexOf(string str, string find_str) => str.LastIndexOf(find_str);
        public static string CondenseTabsAndNewLines(string str) => Regex.Replace(str, @"\s\s+", "");
        public static string PackString(string[] str_arr, string delimiter) => string.Join(delimiter, str_arr);
        /// <summary>
        /// Repeat sting n times 
        /// Example >  McString.Multiply("<item>a</item>", 2) => "<item>a</item><item>a</item>"
        /// </summary>
        public static string Multiply(string str, int cnt) => String.Concat(Enumerable.Repeat(str, cnt));
        /// <summary>
        /// Repeat sting n times 
        /// Example >  McString.MultiplyToArray("XXXX", 2) => {"XXXX", "XXXX"}
        /// </summary>
        public static string[] MultiplyAsArray(string str, int cnt) => Enumerable.Repeat(str, cnt).ToArray();
        public static string FilterStars(string str) => string.Join("", str.Split('*')); //rename to FilterChars(string str, char character)
        public static int IndexOfChar(char[] array, char ch) {

            for ( int i = 0; i < array.Length; i++ ) {

                if ( array[i] == ch ) {
                    return i;
                }
            }
            return -1;
        }
        //source = "[0, 0, 0]"
        //source = McString.RemoveChars(source, new string[] { "[", "]", "(", ")", " "}); //remove brackets and empty spaces
        public static string RemoveChars(string str, string[] charsToRemove) {

            foreach ( string c in charsToRemove ) {
                str = str.Replace(c, String.Empty);
            }
            return str;
        }
        public static bool Contains(string src_str, string find_str, bool ignoreCase = false) { //not used
            StringComparison type = ignoreCase ?
                StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal;
            return src_str.IndexOf(find_str, type) >= 0;
        }
        /*internal static int GetCharAt(char[] char_arr, int index) {
            
            from ch in char_arr
            where ch == 
        }*/
    }
    // Test
    public static class McStringExtensions {
        public static bool StartsWith(this string src_str, string find_str, bool ignoreCase = false) {
            StringComparison type = ignoreCase ?
                StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal;
            return src_str.StartsWith(find_str, type);
        }
        public static string Join(this string[] rows, string separator) {
            return String.Join(separator, rows);
        }
        public static string Join(this List<string> rows, string separator) {
            return String.Join(separator, rows);
        }
        /// <summary>
        /// Replace Extension > replace all occurences(separators) in string
        /// char[] separators = new char[]{' ',';',',','\r','\t','\n'};
        /// string s = "this;is,\ra\t\n\n\ntest";
        /// s = s.Replace(separators, "\n");
        /// </summary>
        /*public static string Replace(this string s, char[] separators, string new_str) {
            string[] arr;

            arr = s.Split(separators, StringSplitOptions.RemoveEmptyEntries);
            return String.Join(new_str, arr);
        }*/
        //filter stars from string
        //// str - the source string
        //// index- the start location to replace at (0-based)
        //// length - the number of characters to be removed before inserting
        //// replace - the string that is replacing characters
        /// Example > "0123456789".ReplaceAt(7, 5, "Hello") > "0123Hello456789"
        /*public static string ReplaceAt(this string str, int index, int length, string replace) {
            return str.Remove(index, Math.Min(length, str.Length - index))
                        .Insert(index, replace);
        }*/
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
