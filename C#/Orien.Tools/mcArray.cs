using System;
using System.Collections.Generic;

namespace Orien.Tools {
    public class McArray {

        public static void AddItem<T>(List<T> list, T item, bool unique = false) {

            if (unique && !list.Contains(item)) {
                list.Add(item);
            } else {

                list.Add(item);
            }
        }
        public static void Prepend<T>(List<T> list, T item) {

            list.Insert(0, item);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="array1"></param>
        /// <param name="array2"></param>
        /// <returns></returns>
        public static T[] ConcatTwoArrays<T>(T[] array1, T[] array2) {

            T[] new_arr = new T[array1.Length + array2.Length];
            Array.Copy(array1, new_arr, array1.Length);
            Array.Copy(array2, 0, new_arr, array1.Length, array2.Length);
            return new_arr;
        }

        /* Not Tested
        var header = new byte[] { 0, 1, 2};
        var data = new byte[] { 3, 4, 5, 6 };
        var checksum = new byte[] {7, 0};
        var newArray = ConcatArrays(header, data, checksum);
        output > byte[9] { 0, 1, 2, 3, 4, 5, 6, 7, 0 }

         * public static T[] ConcatArrays<T>(params T[][] args) {
            if (args == null)
                throw new ArgumentNullException();

            var offset = 0;
            var newLength = args.Sum(arr => arr.Length);
            var newArray = new T[newLength];

            foreach (var arr in args) {
                Buffer.BlockCopy(arr, 0, newArray, offset, arr.Length);
                offset += arr.Length;
            }
            return newArray;
        }*/

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
            foreach (int i in input) {
                result_str += "\t" + i.ToString() + (newLine ? "\n" : "");
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
