using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml.Serialization;
using System.Reflection;

namespace ScriptEditor
{
    public class Config
    {
        public static string FolderPath
        {
            get
            {
                var basePath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
                return Path.Combine(basePath, "Autodesk", "3dsMax", "Samples", "CSharpScriptEditor");
            }
        }

        public static string FilePath 
        {
            get 
            {   
                return Path.Combine(FolderPath, "config.xml");
            }
        }

        public static Config Default = new Config();

        public static Config Load()
        {
            var xs = new XmlSerializer(typeof(Config));

            try
            {
                if (!File.Exists(FilePath))
                {
                    var r = new Config();
                    Directory.CreateDirectory(FolderPath);
                    var stream = File.OpenWrite(FilePath);
                    xs.Serialize(stream, r);
                    return r;
                }
                else
                {
                    var stream = File.OpenRead(FilePath);
                    var r = xs.Deserialize(stream) as Config;
                    return r;
                }
            }
            catch (Exception)
            {
                return new Config();
            }
        }

        public static string ApplicationFolder
        {
            get
            {
                return Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);
            }
        }

        public List<String> Assemblies = new List<String>()
        {
            Path.Combine(ApplicationFolder, "Autodesk.Max.dll"),
            Path.Combine(ApplicationFolder, "MaxCustomControls.dll"),
            Path.Combine(ApplicationFolder, "UiViewModels.dll"),
            Path.Combine(ApplicationFolder, "bin", "assemblies", "ScriptEditorPlugin.dll"),
            "System.dll",
            "System.Core.dll",
            "System.Data.dll",
            "System.Data.DataSetExtensions.dll",
            "System.Drawing.dll",
            "System.Windows.Forms.dll",
            "System.Xml.dll",
            "System.Xml.Linq.dll",
        };
    }
}
