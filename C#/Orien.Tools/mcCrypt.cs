using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace Orien.Tools {
    public class mcCrypt {

        CultureInfo cultures = new CultureInfo("cs-CZ"); // creating object of CultureInfo
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
        //using Linq:
        public static string EncodeToCharCode(string str) {


            uint[] result = Enumerable
            .Range(0, str.Length)
            .Select(index => Convert.ToUInt32(str[index])) //conver sting number into equivalent 32 bit unsigned integer.
            .ToArray();
            return string.Join("*", result); //result.Select(b => $"*{b:X2}")
        }
        //using Linq:
        public static string DecodeFromCharCode(string str) {

            string[] str_arr = str.Split('*'); //parse string in to numbers
            char[] result = Enumerable
                .Range(0, str_arr.Length)
                .Select(index => Convert.ToChar(Int32.Parse(str_arr[index])))
                .ToArray();
            return string.Join("", result);
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
