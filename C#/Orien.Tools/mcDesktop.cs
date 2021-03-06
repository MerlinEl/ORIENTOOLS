﻿using System;
using System.Diagnostics;
using System.IO;

namespace Orien.Tools {
    public class McDesktop {
        // Load all suffixes in an array  
        private static readonly string[] suffixes = { "Bytes", "KB", "MB", "GB", "TB", "PB" };
        // That will return (normally) C:\
        public static readonly string System_Drive = Path.GetPathRoot(

            Environment.GetFolderPath(Environment.SpecialFolder.System)
        );
        public static bool DirectoryExists(string path) => Directory.Exists(path);
        public static bool FileExists(string fpath) => File.Exists(fpath);
        /// <summary>
        /// Get current user directory
        /// </summary>
        public static readonly string User_Directory = Path.GetDirectoryName(

            Environment.GetFolderPath(Environment.SpecialFolder.Personal)
        );

        public static readonly string App_Directory = Path.GetDirectoryName(

            System.Reflection.Assembly.GetExecutingAssembly().Location
        );

        public static string SizeToString(Int64 bytes) {
            int counter = 0;
            decimal number = bytes;
            while ( Math.Round(number / 1024) >= 1 ) {
                number /= 1024;
                counter++;
            }
            return string.Format("{0:n1}{1}", number, suffixes[counter]);
        }

        public static string GetLastDirectory(string path) {

            return new DirectoryInfo(path).Name;
        }

        public static long GetFileSize(string fpath) {
            if ( !File.Exists(fpath) ) {
                return 0;
            }

            try {
                FileInfo fileInfo = new FileInfo(fpath);
                return fileInfo.Length;
            } catch ( Exception e ) {
                Console.WriteLine("Failed to get file size for {0}. Exception: {1}", fpath, e.Message);
            }
            return 0;
        }

        public static bool DeleteFile(string fpath) {
            try {
                File.Delete(fpath);
            } catch ( Exception e ) {
                Console.WriteLine("Unable to delete file {0}. Exception: {1}", fpath, e.Message);
                return false;
            }
            return true;
        }

        public static void ShowInExporer(string dir) {
            if ( DirectoryExists(dir) ) {
                Process.Start(dir);
            }
        }
        // Todo implement back response to prevent double run
        public static int RunFile(string fpath, bool waitForExit = false) {
            int exitCode = 0;
            if ( !File.Exists(fpath) ) {
                return 0;
            }

            Process proc = new Process();
            proc.StartInfo.FileName = fpath;
            proc.StartInfo.Arguments = "-v -s -a";
            proc.Start();
            if ( waitForExit ) {
                proc.WaitForExit();
                exitCode = proc.ExitCode;
            }
            proc.Close();
            return exitCode;
        }

        /// <summary>
        /// Check if directory is exists, if not try to create one.
        /// </summary>
        /// <param name="dir"></param>
        /// <returns></returns>
        public static bool ProvideDirectory(string dir) {

            bool exists = Directory.Exists(dir);
            if ( exists ) { return true; } else {
                try {
                    Directory.CreateDirectory(dir);
                    return true;
                } catch { return false; }
            }
        }
        /// <summary>
        /// Replace one file(trgt_path) with another(src_path)
        /// </summary>
        /// <param name="fpath_src"></param>
        /// <param name="fpath_trgt"></param>
        /// <returns></returns>
        public static bool ReplaceFile(string fpath_src, string fpath_trgt) {
            if ( !fpath_trgt.Equals(fpath_src, StringComparison.InvariantCultureIgnoreCase) ) {
                try {
                    File.Delete(fpath_trgt);
                    File.Move(fpath_src, fpath_trgt);
                } catch ( Exception e ) {
                    Console.WriteLine("Unable replace local file {0} with {1}, {2}", fpath_trgt, fpath_src, e.Message);
                    return false;
                }
            }
            return true;
        }


    }
}

/*
 * Instaled antivirus check
// SELECT * FROM AntiVirusProduct
// SELECT * FROM FirewallProduct
// SELECT * FROM AntiSpywareProduct
ManagementObjectSearcher wmiData = new ManagementObjectSearcher(@"root\SecurityCenter2", "SELECT * FROM AntiVirusProduct");
ManagementObjectCollection data = wmiData.Get();

foreach (ManagementObject virusChecker in data)
{
    var virusCheckerName = virusChecker["displayName"];
}
 */
