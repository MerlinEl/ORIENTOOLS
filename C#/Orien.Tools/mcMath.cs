using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//--------------------------------------------------------------------------------//
//                                mcMath by Orien 2019                            //
//--------------------------------------------------------------------------------//
/*
*@Used Structures

*
*@Used Objects

*
*/
namespace Orien.Tools {
    public class mcMath {
        /**
        *@Usage
            value   :int input number
            min     :int minimum value	
            max     :int maximum value
            return  :int min, max or value
        *@Example
            mcMath.minMax 100	1	50	--> 50
            mcMath.minMax -1	1	50	--> 1
            mcMath.minMax 100	1	200	--> 100
        */
        public int MinMax(int value, int min, int max) {

            int val = Math.Max(value, min); //min
            val = Math.Min(val, max); //max
            return val;
        }
    }
}
