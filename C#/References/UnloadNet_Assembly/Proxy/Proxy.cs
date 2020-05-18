using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Windows.Forms;

namespace MySpace
{
	public class Proxy:BaseInterface.IBaseInterface
	{
		//main controller for Appdomain
        AppDomainCore _appDomainController;

        //main controller for Assembly
		AssemblyCore _assemblyController;
        
        //base business rules
        BaseInterface.IBaseInterface _proxy;

        /// <summary>
        /// Gets the currenlty Active Appdomain Name
        /// </summary>
        public string DefaultAppDomain
        {
            get { return _appDomainController.DefaultAppdomainName; }
        }

        /// <summary>
        /// Gets the Default Assembly's FileName
        /// </summary>
        public string DefaultAssemblyFileName
        {
            get { return _assemblyController.ActiveAssemblyFile; }
        }

        /// <summary>
        /// Creates an instance of the proxy.
        /// </summary>
        /// <param name="AssemblyFileName">Name of Assembly File to be loaded</param>
        /// <param name="AppDomainName">Friendly Name for the new Appdomain</param>
		public Proxy(string AssemblyFileName,string AppDomainName)
		{
            Init(AssemblyFileName, AppDomainName, "MyAssembly.ClassLibrary");
		}

		/// <summary>
        /// /// <summary>
        /// Creates an instance of the proxy.
        /// </summary>
        /// <param name="AssemblyFileName">Name of Assembly File to be loaded</param>
        /// <param name="AppDomainName">Friendly Name for the new Appdomain</param>
		/// <param name="CurrentType">Name of Object type that is to loaded from the Assembly</param>
        public Proxy(string AssemblyFileName, string AppDomainName,string CurrentType)
		{
			Init(AssemblyFileName, AppDomainName, CurrentType);
		}

		private bool Init(string AssemblyFileName, string AppDomainName, string CurrentType)
		{
			//Creates an instance of Assembly controller and Appdomain controller
            _assemblyController = new AssemblyCore(AssemblyFileName, CurrentType);
			_appDomainController = new AppDomainCore(AppDomainName);
			return true;
		}

		/* defining the business rules. serving these fucntions are the actual purpose of oue application. 
         * These functionalities are so critical so that application cannot be unloaded or reinstalled
         * or these functions are changing on each minute*/
        #region BaseInterface Members

        /// <summary>
        /// This function returns a build in value from the dll like version information etc.
        /// </summary>
        /// <returns>A string information regarding the current version of the file.</returns>
		public string ReturnBaseValue()
		{
            //creates an instance of the assembly in the second appdomain and unwraps the remote object instance of the specified type.
            _proxy = (BaseInterface.IBaseInterface)_appDomainController.DefaultAppDomain.
                CreateInstanceFromAndUnwrap(_assemblyController.DefaultAssemblyFileName,
                _assemblyController.CurrentType);
			if (_proxy != null)
            {
                /* calling the base function which in turn calls into 
                 * the dynamically loaded library file using cross 
                 * appdomain communication mechanisums with help of remoting object */
                return _proxy.ReturnBaseValue();
            }
            return null;
		}


        /// <summary>
        /// Returns a reversed value of the passed string
        /// </summary>
        /// <param name="Value">String to be reversed</param>
        /// <returns>Reversed Value</returns>
		public string ReverseValue(string Value)
		{
            //_proxy = (BaseInterface.IBaseInterface)_appDomainController.DefaultAppDomain.CreateInstanceFromAndUnwrap
            //(_assemblyController.DefaultAssemblyFileName, _assemblyController.CurrentType);
            //if (_proxy != null)
            //{
            //    return _proxy.ReverseValue(Value);
            //}
            //return null;

            //the above commended code will also work. I just tried a refection alternative.
            
            return ((string)GetReversedString("ReverseString", new object[] { Value }));
		}

        //an alternative method for invoking the method using refelction. Useful if we don't have an interface to implement
        private object GetReversedString(string MethodName,object[] Arguments)
        {
            //creates an instance of the assembly in the second appdomain and unwraps the remote object instance of the specified type.
            object proxy = (BaseInterface.IBaseInterface)_appDomainController.DefaultAppDomain.CreateInstanceFromAndUnwrap
                (_assemblyController.DefaultAssemblyFileName, _assemblyController.CurrentType);
            if (proxy != null)
            {
                //query for the specified method using reflection libraries
                MethodInfo mi = proxy.GetType().GetMethod(MethodName, BindingFlags.DeclaredOnly | 
                    BindingFlags.NonPublic | BindingFlags.Instance);
				//if the method is not found then the object mi will be null.
                if (mi != null)
                {
                    //invokes the function
                    object rv = mi.Invoke(proxy, Arguments);
                    return rv;
                }
                else
                {
                    MessageBox.Show("Oops. Such a method not found...!", ".Net Reflection", 
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            return null;
        }

		#endregion
	}
}
