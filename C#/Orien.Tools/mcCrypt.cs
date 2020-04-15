using System;
using System.Text;

namespace Orien.Tools {
    public class mcCrypt {
        private string eng_pattern_default = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private string eng_pattern_mixed = "R81GXF5QDHKB4NZMJSAWUVTPCO293Y0I7LE6";

        public static string EncodeToASCII(string str) {

            string code = "";
            byte[] ascii = Encoding.ASCII.GetBytes(str);

            //https://stackoverflow.com/questions/5348844/how-to-convert-a-string-to-ascii
            /*byte[] bytes = Encoding.ASCII.GetBytes(str);
            int result = BitConverter.ToInt32(bytes, 0);
            Console.WriteLine("bytes result:" + result);*/

            for (int i = 0; i < ascii.Length; i++) {

                string byte_str = ascii[i].ToString("X"); //convert Byte in to String
                code += (i < ascii.Length - 1) ? byte_str + '*' : byte_str;
            }
            /*foreach (Byte b in ascii) {

                code += b.ToString("X") + "*";
            }*/
            return code;
        }

        public static string DecodeFromASCII(string str) {

            string code = "";
            int num = 0;
            string[] str_arr = str.Split('*');
            Console.WriteLine("str_arr:\n" + String.Join("\n", str_arr));
            foreach (string s in str_arr) {

                int unicode = Int32.Parse(s);
                code += Char.ConvertFromUtf32(unicode);

                //char character = (char)unicode;
                // code += character.ToString();

                //code += Int32.Parse(s).ToString();
                /*num = num * 10 + (Int32.Parse(s) - '0'); // Append the current digit 
                if (num >= 32 && num <= 122) {

                    char ch = (char)num; // Convert num to char 
                    code += ch.ToString();
                    num = 0; // Reset num to 0 
                }*/
            }
            return code;
        }
    }
    /* public class ASCIIConverter : TypeConverter {
         // Overrides the CanConvertFrom method of TypeConverter.
         // The ITypeDescriptorContext interface provides the context for the
         // conversion. Typically, this interface is used at design time to 
         // provide information about the design-time container.
         public override bool CanConvertFrom(ITypeDescriptorContext context,
            Type sourceType) {
             if (sourceType == typeof(string)) {
                 return true;
             }
             return base.CanConvertFrom(context, sourceType);
         }

         public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType) {
             if (destinationType == typeof(int)) {
                 return true;
             }
             return base.CanConvertTo(context, destinationType);
         }


         // Overrides the ConvertFrom method of TypeConverter.
         public override object ConvertFrom(ITypeDescriptorContext context,
            CultureInfo culture, object value) {

             if (value is int) {
                 //you can validate a range of int values here
                 //for instance 
                 //if (value >= 48 && value <= 57)
                 //throw error
                 //end if

                 return char.ConvertFromUtf32(65);
             }
             return base.ConvertFrom(context, culture, value);
         }

         // Overrides the ConvertTo method of TypeConverter.
         public override object ConvertTo(ITypeDescriptorContext context,
            CultureInfo culture, object value, Type destinationType) {
             if (destinationType == typeof(int)) {
                 return char.ConvertToUtf32((string)value, 0);
             }
             return base.ConvertTo(context, culture, value, destinationType);
         }
     }*/
}


/*
Convert a string to ASCII codes and back in Flash
trace(String.fromCharCode(65))  // "A"
trace(("A").charCodeAt(0))      // 65
 */
