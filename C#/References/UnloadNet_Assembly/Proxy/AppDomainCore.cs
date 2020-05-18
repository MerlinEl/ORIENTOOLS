using System;
using System.Collections.Generic;
using System.Text;

namespace MySpace
{
    internal class AppDomainCore 
    {

        /// <summary>
        /// creates an instance of Appdomain in the Specified Name
        /// </summary>
        /// <param name="AppDoaminName"></param>
        public AppDomainCore(string AppDoaminName)
		{
            _DefaultAppdomainName = AppDoaminName;
            LoadAppDomain();
		}

		private AppDomain _DefaultAppDomain;
		/// <summary>
		/// Gets the Currently Active Appdomain
		/// </summary>
		public AppDomain DefaultAppDomain
		{
			get { return _DefaultAppDomain; }
		}

		private string _DefaultAppdomainName;

		public string DefaultAppdomainName
		{
			get { return _DefaultAppdomainName; }
		}


		/// <summary>
        /// Creates a new Application Domain instance
        /// </summary>
        /// <param name="AppDoaminName">Name for the new Application Domain</param>
        /// <returns></returns>
		private bool LoadAppDomain()
        {
            // Construct and initialize settings for a second AppDomain.
            AppDomainSetup ads = new AppDomainSetup();

            // Create the second AppDomain.
			_DefaultAppDomain = AppDomain.CreateDomain(DefaultAppdomainName, null, ads);
            
            /* this statement makes the App to copy the Dll to an alternative location and loads form there 
             * and thus leaves the original file's locking for replacement.*/
            _DefaultAppDomain.SetShadowCopyFiles();
			return true;
        }

        /// <summary>
        /// Clears the currently used Application domain if exists.
        /// </summary>
        /// <returns>Boolean regarding operation sucessfull or not</returns>
        private bool ClearAppDomain()
        {
			try
			{
				AppDomain.Unload(DefaultAppDomain);
				_DefaultAppDomain = null;
				return true;
			}
			catch
			{
				return false;
			}
        }

		~AppDomainCore()
		{
			ClearAppDomain();
		}
	}
}
