using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Reflection;
using System.Windows.Forms;

namespace MySpace
{
    internal class AssemblyCore
    {
		/// <summary>
		/// Returns the Filename that is originaly refered by the application.
		/// </summary>
        const string OriginalAssemblyFileName = "DefaultAssembly.dll";

        private string _activeAssemblyFile;
        /// <summary>
        /// Gets the Original name of assembly file that is currenlty used as DefaultAssemblyFile
        /// </summary>
        public string ActiveAssemblyFile
        {
            get { return _activeAssemblyFile; }
        }


		private string _CurrentType;
        // Gets the currently used type
		public string CurrentType
		{
			get { return _CurrentType; }
			set { _CurrentType = value; }
		}
		/// <summary>
		/// returns the currently Active Assembly File. The name will be same but 
		/// the file will different and if we create an .Net Assembly Reference from this 
		/// it will be different.
		/// </summary>
		public string DefaultAssemblyFileName
		{
			get { return OriginalAssemblyFileName; }
		}

        private FileInfo _DefaultAssemblyFile;
        /// <summary>
        /// Returns the currently Active Assembly File's FileInfo Object.
        /// </summary>
        public FileInfo DefaultAssemblyFile
        {
            get { return _DefaultAssemblyFile; }
        }


		public AssemblyCore(string AssemblyFileName,string TypeName)
		{
            CurrentType = TypeName;
            SetDefaultAssemblyFile(AssemblyFileName);	
		}

		/// <summary>
        /// Sets a reference to the Specified Assembly file. 
        /// File Should be in Bin folder of the application. If not, it should be an absolute path
        /// </summary>
        /// <param name="AssemblyName">Name of Assembly file without FilePath</param>
        /// <returns></returns>
        public bool SetDefaultAssemblyFile(string AssemblyFileName)
        {
            try
            {
                //saves the original file name.
                _activeAssemblyFile = AssemblyFileName;
                File.Copy(AssemblyFileName, OriginalAssemblyFileName, true);
                _DefaultAssemblyFile = new FileInfo(OriginalAssemblyFileName);
				return true;
            }
            catch(Exception Err)
            {
                MessageBox.Show("An Error Occured. Versioning Failed. Details : " + Err.Message);
				return false;
            }
        }

    }
}
