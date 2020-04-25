using Microsoft.Win32;
using System;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;

namespace Orien.Tools {
    public class McRegistry {
        /// <summary>
        /// Get Registry Value from given Path
        /// </summary>
        /// <example>
        /// string install_date = McRegistry.ReadValue(@"Software\Unicorn\Encoded_Book_Name", "date");
        /// </example>
        /// <param name="key_path"></param>
        /// <param name="key_name"></param>
        /// <returns>String Value</returns>
        public static string ReadValue(string key_path, string key_name) {
            RegistryKey root_key;
            if (Environment.Is64BitOperatingSystem)
                root_key = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Registry64);
            else
                root_key = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Registry32);
            RegistryKey sub_key = root_key.OpenSubKey(key_path, RegistryKeyPermissionCheck.ReadSubTree);
            if (sub_key == null) return "";
            object val = sub_key.GetValue(key_name);
            return (val == null) ? "" : val.ToString();
        }
        /// <summary>
        /// Collect folder names in path
        /// </summary>
        /// <param name="key_path"></param>
        /// <returns>string array of folder names</returns>
        /// <example>McRegistry.GetKeys(@"Software\Unicorn");
        public static string[] GetFolders(string key_path) {

            RegistryKey root_key;
            if (Environment.Is64BitOperatingSystem)
                root_key = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Registry64);
            else
                root_key = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Registry32);
            RegistryKey sub_key = root_key.OpenSubKey(key_path, RegistryKeyPermissionCheck.ReadSubTree);
            string[] key_names = new string[] { };
            if (sub_key == null) return key_names;
            /*foreach (string keyname in sub_key.GetSubKeyNames()) {
                try {
                    using (RegistryKey key = sub_key.OpenSubKey(keyname)) {
                        Console.WriteLine("Registry key found : {0} contains {1} values", key.Name, key.ValueCount);
                        key_names.Append(key.Name);
                    }
                } catch (System.Security.SecurityException) {
                }
            }*/
            //ReadSubKeys(root_key, @"Software\Unicorn");
            key_names = sub_key.GetSubKeyNames();
            return key_names;
        }
        /// <summary>
        /// McRegistry.PrintContent(@"Software\Unicorn");
        /// </summary>
        /// <param name="key_path"></param>
        public static void PrintContent(string key_path) {

            RegistryKey root_key;
            if (Environment.Is64BitOperatingSystem)
                root_key = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Registry64);
            else
                root_key = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Registry32);
            RegistryKey sub_key = root_key.OpenSubKey(key_path, RegistryKeyPermissionCheck.ReadSubTree);
            if (sub_key == null) return;
            foreach (string keyname in sub_key.GetSubKeyNames()) {
                try {
                    using (RegistryKey key = sub_key.OpenSubKey(keyname)) {
                        Console.WriteLine("Registry key found : {0} contains {1} values", key.Name, key.ValueCount);
                    }
                } catch (System.Security.SecurityException) {
                }
            }
        }


        /*public static bool WriteValue(string path, string key) {

            string path = @"Software\Microsoft\Office"
            RegKey regkey = Registry.LocalMachine.OpenSubKey(path);

        }*/
        /*const string PARENT_KEY_PATH = @"SOFTWARE\Unicorn\268*101*115*107*253*32*106*97*122*121*107*32*50";
        const string SUB_KEY_NAME = @"C:|Program Files (x86)|Microsoft SDKs|Windows|v8.1|E1234567|Microsoft.VisualStudio.TestPlatform.UnitTestFramework.AppContainer{0:0000}.dll"; // 14.45s ; total chars=178 ; key name chars=134
        private static void CreateSubKeys(RegistryKey regHive, int count) {
            // create sub-keys
            regHive.DeleteSubKeyTree(PARENT_KEY_PATH, false);   // just for sure
            RegistryKey parentKey;
            parentKey = regHive.CreateSubKey(PARENT_KEY_PATH);
            for (int i = 0; i < count; i++) {
                string subKeyName;
                subKeyName = string.Format(SUB_KEY_NAME, i);
                RegistryKey subKey = parentKey.CreateSubKey(subKeyName);
                subKey.Close();
            }
            parentKey.Close();
        }

        private static void ReadSubKeys(RegistryKey regHive, string root_path) {
            // retrieve sub-key names
            RegistryKey parentKey;
            parentKey = regHive.OpenSubKey(root_path);
            string[] subKeyNames = new string[] { };
            DateTime start = DateTime.Now;
            Console.WriteLine(String.Format("Started at: {0}", GetTimestampString(start)));

            if (parentKey != null) {
                subKeyNames = parentKey.GetSubKeyNames();
            } else return;

            DateTime end = DateTime.Now;
            Console.WriteLine(String.Format("Finished at: {0}", GetTimestampString(end)));
            Console.WriteLine(String.Format("There were {0} sub key names retrieved in {1}.", subKeyNames.Length, end.Subtract(start).ToString()));

            string longestName = "";
            foreach (string subKeyName in subKeyNames) {
                if (subKeyName.Length > longestName.Length) {
                    longestName = subKeyName;
                }
            }
            Console.WriteLine(String.Format("The longest key name was {0}\nKey length={1}\nTotal key length={2}",
                parentKey.Name + "\\" + longestName,
                longestName.Length,
                parentKey.Name.Length + longestName.Length + 1));
        }
        /// <summary>        
        /// Gets a timestamp info with milliseconds.
        /// </summary>
        private static string GetTimestampString(DateTime timestamp) {
            // Append millisecond pattern to current culture's full date time pattern
            string pattern = DateTimeFormatInfo.CurrentInfo.LongTimePattern;
            pattern = Regex.Replace(pattern, "(:ss|:s)", "$1.fff");
            return timestamp.ToShortDateString() + " " + timestamp.ToString(pattern);
        }*/
    }
}


/*
  RMO.writeValue(REG_PATH, o.key, o.val);       
    RMO.readValue(REG_PATH);
    RMO.writeValue( REG_PATH, "lrd", MOD.encode(local_time) );

    if (!String.IsNullOrEmpty(value)){


    }
    if (key.Length == 0 ) {

                //RegistryKey keys[] = Registry.CurrentUser.GetSubKeyNames()

            } else {

            }
 */
