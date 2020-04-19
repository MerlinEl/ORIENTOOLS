using System;
using System.Collections.Generic;
using System.Linq;

namespace Orien.Tools {
    public class mcCrypt {

        //CultureInfo cultures = new CultureInfo("cs-CZ"); // creating object of CultureInfo
        private static char[] eng_pattern_default = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".ToCharArray();
        private static char[] eng_pattern_mixed = "R81GXF5QDHKB4NZMJSAWUVTPCO293Y0I7LE6".ToCharArray();
        /// <summary>
        /// Encode string in to number pattern
        /// Example > mcCrypt.EncodeToNumPattern("Český jazyk 2");
        ///         > "268*101*115*107*253*32*106*97*122*121*107*32*50"
        /// </summary>
        public static string EncodeToNumPattern(string str) {

            uint[] result = str.Select(s => Convert.ToUInt32(s)).ToArray();
            return string.Join("*", result); //result.Select(b => $"*{b:X2}")
        }
        /// <summary>
        /// Decode number pattern in to string
        /// Example > mcCrypt.DecodeFromNumPattern("48*54*47*50*48*47*50*48*49*56");
        ///         > "06/20/2018"
        /// </summary>
        public static string DecodeFromNumPattern(string str) {

            char[] result = str.Split('*')
                .Select(s => Convert.ToChar(Int32.Parse(s)))
                .ToArray();
            return string.Join("", result);
        }
        public static string DecodeKey(string str) {

            string[] result = str.Select(ch => {

                int char_index = mcString.IndexOfChar(eng_pattern_default, ch); //get char number from pttern
                return eng_pattern_mixed[char_index].ToString(); //get characeter equivalent as integer 
            })
            .ToArray();
            return string.Join("", result);
        }
        public static string[] UnmixEncodeKey(string[] shuffled_arr, int block_length = 4) {

            string mixer = shuffled_arr[shuffled_arr.Length - 1];
            int[] mixer_array = DecodeKey(mixer).ToCharArray() // 1,2,3,4 or 4,3,2,1 or 2,3,1,4...
                                .Select(ch => Int32.Parse(ch.ToString()))
                                .ToArray();
            //Console.WriteLine("UnmixEncodeKey > mixer:{0} arr:{1}", mixer, mixer_array.IntArrayToString());
            // unshuffle blocks according mixer
            // prepare blocks as multistring slots
            List<string[]> result_input = new List<string[]> {

                new string[block_length],
                new string[block_length],
                new string[block_length]
            };
            for (var i = 0; i < result_input.Count; i++) { //for all blocks except last one

                int num = mixer_array[i];
                string in_block = shuffled_arr[i];
                result_input[0][num] = in_block[0].ToString();
                result_input[1][num] = in_block[1].ToString();
                result_input[2][num] = in_block[2].ToString();
                if (i == 0) { //insert last char (one time)

                    num = mixer_array[mixer_array.Length - 1];
                    //replace strings
                    result_input[0][num] = shuffled_arr[0][3].ToString();
                    result_input[1][num] = shuffled_arr[1][3].ToString();
                    result_input[2][num] = shuffled_arr[2][3].ToString();
                }
            }
            // condense string blocks
            var result = new List<string> ( result_input.Select(s => String.Join("", s)) );
            result.Add(shuffled_arr[shuffled_arr.Length - 1]); //insert unshuffled encoded mixer
            return result.ToArray();
        }
    }
}



/**
string code = "";
char[] arr = str.ToCharArray();
for (int i = 0; i < arr.Length; i++) {

    string uint_str = Convert.ToUInt32(arr[i]).ToString();
    code += (i < arr.Length - 1) ? uint_str + '*' : uint_str;
}
return code;
*/

/**
private static var base64chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
// Encodes a base64 string.
public static function encode(src:String):String {
    var i:Number = 0;
    var output:String = new String("");
var chr1:Number, chr2:Number, chr3:Number;
    var enc1:Number, enc2:Number, enc3:Number, enc4:Number;
    while (i<src.length) {
        chr1 = src.charCodeAt(i++);
        chr2 = src.charCodeAt(i++);
        chr3 = src.charCodeAt(i++);
        enc1 = chr1 >> 2;
        enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
        enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
        enc4 = chr3 & 63;
        if(isNaN(chr2)) enc3 = enc4 = 64;
        else if(isNaN(chr3)) enc4 = 64;
        output += base64chars.charAt(enc1)+base64chars.charAt(enc2);
        output += base64chars.charAt(enc3)+base64chars.charAt(enc4)
    }
    return output;
}
*/
