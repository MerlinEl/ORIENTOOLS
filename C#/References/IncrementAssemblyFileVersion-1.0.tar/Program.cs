using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace IncrementFileVersion
{
    class Program
    {
        /* This program increments the file version of the provided AssemblyInfo file
         * 
         * Written by Telson Alva
         * 
         * 
         */
        static void Main(string[] args)
        {
            try
            {
                if (args.Length > 0)
                {
                    //the first argument must be the assembly info file
                    string assemblyInfoFile = args[0];
                    string assemblyFileVersionOld = string.Empty;
                    string assemblyFileVersionNew = string.Empty;
                    string oldline = string.Empty;
                    string newline = string.Empty;

                    if (File.Exists(assemblyInfoFile))
                    {
                        string[] AllLines = File.ReadAllLines(assemblyInfoFile);

                        //now loop through each line to find 'AssemblyFileVersion'

                        foreach (string line in AllLines)
                        {
                            if (line.Contains("AssemblyFileVersion"))
                            {
                                oldline = line;
                                break;
                            }
                        }

                        if (!string.IsNullOrEmpty(oldline))
                        {
                            //this will usually be in the format [assembly: AssemblyFileVersion("1.0.1.0")]
                            //we need just the version
                            string[] splits = oldline.Split(':');
                            assemblyFileVersionOld = splits[1];
                            string[] splits2 = assemblyFileVersionOld.Split(new char[] { '(', ')' }); //this will split in 3 parts, middle is the version number

                            string[] oldversionNum = splits2[1].Split('.');

                            //we have to increment the build number, which is the third position

                            string newversionNum = oldversionNum[0] + "." + oldversionNum[1] + "." + (int.Parse(oldversionNum[2]) + 1).ToString() + "." + oldversionNum[3];

                            assemblyFileVersionNew = assemblyFileVersionOld.Replace(splits2[1], newversionNum);

                            newline = splits[0] + ":" + assemblyFileVersionNew; //combile to make a new line which can replace the old line

                            //once the new line is generated, relplace the old line with the new line
                            string OldText = File.ReadAllText(assemblyInfoFile);
                            string NewText = OldText.Replace(oldline, newline);

                            //write the text back into the file
                            File.WriteAllText(assemblyInfoFile, NewText,Encoding.UTF8);

                            Console.WriteLine("Completed Successfully");

                        }
                        else
                        {
                            Console.WriteLine("Unable to locate 'AssemblyFileVersion' text in file");
                            Console.Read();
                        }

                    }
                    else
                    {
                        Console.WriteLine("Either the passed parameter is incorrect or the file doesnt exist");
                        Console.WriteLine("Passed : " + args[0]);
                        Console.Read();
                    }
                }
                else
                {
                    Console.WriteLine("Please pass the complete path to AssemblyInfo.cs as the first arguement");
                    Console.Read();
                }
            }
            catch (Exception Ex)
            {
                Console.WriteLine("An Error has occured, please reach out to the developer (telson_alva@yahoo.com) with the below details");
                Console.WriteLine(" ");
                Console.WriteLine("Error Message : " + Ex.Message);
                Console.WriteLine(Ex.StackTrace);
            }
        }
    }
}
