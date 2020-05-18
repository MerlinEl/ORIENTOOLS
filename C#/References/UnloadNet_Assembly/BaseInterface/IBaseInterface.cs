using System;
using System.Collections.Generic;
using System.Text;

namespace BaseInterface
{
    /* Interface to share Business model. This Interface should 
     * be implemented in all the versions and main application*/
    public interface IBaseInterface
    {
        string ReturnBaseValue();
        string ReverseValue(string Value);
    }
}
