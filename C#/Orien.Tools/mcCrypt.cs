using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Orien.Tools {
    public class mcCrypt {
        private string eng_pattern_default = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private string eng_pattern_mixed = "R81GXF5QDHKB4NZMJSAWUVTPCO293Y0I7LE6";

        public static List<string> test_chars = new List<string>(new string[]{

            "268*101*115*107*253*32*106*97*122*121*107*32*50",
            "268*101*115*107*253*32*106*97*122*121*107*32*51",
            "268*101*115*107*253*32*74*97*122*121*107*32*52",
            "381*105*118*225*32*65*98*101*99*101*100*97*32*45*110*112",
            "77*97*116*101*109*97*116*105*107*97*32*49*48*53*32*49*48*54"
        });

        public static List<string> test_names = new List<string>(new string[]{

            "Český jazyk 2",
            "Český jazyk 3",
            "Český Jazyk 4",
            "Živá Abeceda -np",
            "Matematika 105 106"
        });

        /*
        Convert a set of Unicode values into characters:
        var res = String.fromCharCode(72, 69, 76, 76, 79);

       Return the Unicode of the last character in a string (the Unicode value for "D"):
        var str = "HELLO WORLD";
        var n = str.charCodeAt(str.length-1);


       string result = "012345";
    Response.Write(result.ToCharArray()[3]); ;

            foreach (var a in str) Console.WriteLine("{0} ", Convert.ToUInt16(a).ToString("X4"));
            Console.WriteLine(str.ToCharArray()[0]);
           
            Convert.toUint16(char), Convert.toUint32(char) methods.

               byte[] result = Enumerable
              .Range(0, str.Length)
              .Select(index => Convert.ToByte(str.Substring(index * 2, 2), 16))
              .ToArray();
              return string.Join("", result.Select(b => $"*{b:X2}"));
         */


        public static string ToASCII(string str) {

            /*string code = "";
            char[] arr = str.ToCharArray();
            for (int i = 0; i < arr.Length; i++) {

                string uint_str = Convert.ToUInt32(arr[i]).ToString();
                code += (i < arr.Length - 1) ? uint_str + '*' : uint_str;
            }
            return code;*/

            //You can try using Linq:
            uint[] result = Enumerable
            .Range(0, str.Length)
            .Select(index => Convert.ToUInt32(str[index]))
            .ToArray();
            return string.Join("*", result); //result.Select(b => $"*{b:X2}")
        }

        public static string FromASCII(string str) {

            string[] str_arr = str.Split('*'); //parse string in to numbers
            byte[] bytes_back = new byte[str_arr.Length];
            for (int i = 0; i < str_arr.Length; i++) {

                bytes_back[i] = byte.Parse(str_arr[i]);
            }
            return Encoding.UTF8.GetString(bytes_back);

            /*string[] str_arr = str.Split('*'); //parse string in to numbers
            byte[] bytes = new byte[str_arr.Length];
            for (int i = 0; i < str_arr.Length; i++) bytes[i] = byte.Parse(str_arr[i]);
            return Convert.ToBase64String(bytes);*/
            //my_str += (char)(str_arr[c] ^ keys[cc]);
            //return new String(new char[] { 112, 108, 97, 110 });
            //return Encoding.UTF8.GetString(bytes_back);

            /*string[] str_arr = str.Split('*'); //parse string in to numbers
            string code = "";
            foreach (string s in str_arr) {

                code += Convert.ToChar(s);
            }
            return code;*/
        }


        /*
        function Decrypt(Data){ 
            output = new String;
            Temp = new Array();
            Temp2 = new Array();
            TextSize = Data.length;
            for (i = 0; i < TextSize; i++){
                Temp[i] = Data.charCodeAt(i);
                Temp2[i] = Data.charCodeAt(i + 1);
            }
            for (i = 0; i < TextSize; i = i+2){
                output += String.fromCharCode(Temp[i] - Temp2[i]);
            }
            return output;
         }
         */

        /*public static string Decrypt(string data) {
            string output = "";
            int[] Temp, Temp2;
            int size;
            size = data.Length;
            Temp = new int[size];
            Temp2 = new int[size];
            for (int i = 0; i < size; i++) {

                Temp[i] = Convert.ToInt32.((int)data[i]);
                if (i + 1 < size) {
                    Temp2[i] = Convert.ToInt32((int)data[i + 1]);
                }
            }
            for (int i = 0; i < size; i = i + 2) {
                int inttemp = 0;
                inttemp = Temp[i] - Temp2[i];
                output += Convert.ToChar(inttemp);
            }
            return output;
        }*/
    }
}


/*
Convert a string to ASCII codes and back in Flash
trace(String.fromCharCode(65))  // "A"
trace(("A").charCodeAt(0))      // 65
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
