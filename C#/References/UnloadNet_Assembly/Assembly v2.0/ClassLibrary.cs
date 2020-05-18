using System;
using System.Collections.Generic;
using System.Text;

namespace MyAssembly
{
    //this attribute is required for creation of instance in seperate appdomain.
    [Serializable]
    /*to enable the class to cross the appdomain limits we have 
        to inherit the class from Marshelby refe object.*/
    public class ClassLibrary : MarshalByRefObject, BaseInterface.IBaseInterface
    {
		#region BaseInterface Members

		public string ReturnBaseValue()
		{
            return "Value=Assembly Version 2.0";
		}

		public string ReverseValue(string Value)
		{
            return ReverseString(Value);
		}

		#endregion

        private string ReverseString(string Value)
        {
            StringBuilder tmp = new StringBuilder();
            for (int i = Value.Length - 1; i >= 0; i--)
            {
                tmp.Append(Value.Substring(i, 1));
            }
            return tmp.ToString();
        }
	}
}
