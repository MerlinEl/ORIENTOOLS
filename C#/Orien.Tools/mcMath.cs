using System;
using System.Drawing;
//--------------------------------------------------------------------------------//
//                                McMath by Orien 2020                            //
//--------------------------------------------------------------------------------//
/*
*@Used Structures

*
*@Used Objects

*
*/
namespace Orien.Tools {
    public class McMath {
        /// <summary>
        /// Keep given value between min - max range
        /// </summary>
        /// <param name="value">int input number</param>
        /// <param name="min">int minimum value</param>
        /// <param name="max">int maximum value</param>
        /// <returns>int min, max or value</returns>
        /// <example>
        /// McMath.minMax 100	1	50	--> 50
        /// McMath.minMax -1	1	50	--> 1
        /// McMath.minMax 100	1	200	--> 100
        /// </example>
        public static int MinMax(int value, int min, int max) {

            int val = Math.Max(value, min); //min
            val = Math.Min(val, max); //max
            return val;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="bounds1"></param>
        /// <param name="bounds2"></param>
        /// <param name="archonPoint">Archon Point of bounds2</param>
        /// <returns></returns>
        public static Point GetBoundsCenter(Rectangle bounds1, Rectangle bounds2, Point offset = new Point()) { //, string archonPoint = "left"

            int center_x = bounds1.X + ( bounds1.Width / 2 );
            int center_y = bounds1.Y + ( bounds1.Height / 2 );
            center_x -= ( bounds2.Width / 2 ) + offset.X;
            center_y -= ( bounds2.Height / 2 ) + offset.Y;
            return new Point(center_x, center_y);
        }
        /// <summary>
        /// Fit proportioally size1 in to size2
        /// </summary>
        /// <param name="size1">src</param>
        /// <param name="size2">trgt</param>
        /// <param name="offset">margins</param>
        /// <returns>new Size</returns>
        public static Size FitSizeProportionally(Size size1, Size size2, Size offset = new Size()) {
            Size new_size = new Size();
            int diff = size2.Width / size1.Width;
            new_size.Width = size2.Width - offset.Width;
            new_size.Height = size2.Height * diff - offset.Height;
            return new_size;
        }
    }
}