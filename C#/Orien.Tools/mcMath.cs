using System;
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
    public static class mcMath {
        /// <summary>
        /// Keep given value between min - max range
        /// </summary>
        /// <param name="value">int input number</param>
        /// <param name="min">int minimum value</param>
        /// <param name="max">int maximum value</param>
        /// <returns>int min, max or value</returns>
        /// <example>
        /// mcMath.minMax 100	1	50	--> 50
        /// mcMath.minMax -1	1	50	--> 1
        /// mcMath.minMax 100	1	200	--> 100
        /// </example>
        public static int MinMax(int value, int min, int max) {

            int val = Math.Max(value, min); //min
            val = Math.Min(val, max); //max
            return val;
        }
    }
}



//old comments As3 style
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
