using System.Collections.Generic;

namespace Orien.Tools {
    public class McArray {

        public static void AddItem<T>(List<T> list, T item, bool unique = false) {

            if ( unique && !list.Contains(item) ) {
                list.Add(item);
            } else {

                list.Add(item);
            }
        }
        public static void Prepend<T>(List<T> list, T item) {

            list.Insert(0, item);
        }
    }
    public static class PrintExtension {
        /// <summary>
        /// Print char array to string
        /// example > Console.WriteLine(int[].DisplayResult());
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static string IntArrayToString(this int[] input, bool newLine = false) {
            var result_str = newLine ? "\n" : "";
            foreach ( int i in input ) {
                result_str += "\t" + i.ToString() + ( newLine ? "\n" : "" );
            }
            return result_str;
        }
        /// <summary>
        /// Print char array to string
        /// example > Console.WriteLine(char[].DisplayResult());
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        /*public static string DisplayResult(this string input) {
            var resultString = "\n";
            foreach (char ch in input.ToCharArray()) {
                resultString += "\t: " + ch.ToString() + "\n";
            }
            return resultString;
        }*/
    }
}
