package orien.tools {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcEffect extends MovieClip {
		
		/**
		 * The value used for the luminance of the Red Channel.
		 */
		public static const R_LUM:Number = 0.3086;
		
		/**
		 * The value used for the luminance of the Green Channel.
		 */
		public static const G_LUM:Number = 0.6094;
		
		/**
		 * The value used for the luminance of the Blue Channel.
		 */
		public static const B_LUM:Number = 0.0820;
		
		public function mcEffect() {
		
		}
		
		/*public static function adjustColors(obj:DisplayObject, h:int, s:int, b:int, c:int):void {
		
		   var colorFilter:AdjustColor = new AdjustColor();
		   colorFilter.hue = h;
		   colorFilter.saturation = s;
		   colorFilter.brightness = b;
		   colorFilter.contrast = c;
		
		   var mMatrix:Array = colorFilter.CalculateFinalFlatArray();
		   mColorMatrix: ColorMatrixFilter = new ColorMatrixFilter(mMatrix);
		
		   obj.filters = [mColorMatrix];
		   }*/
		
		/**
		 * Colorize object by given color and inensity
		 * @param	color uint
		 * @param	mul intensity percent 0 - 1
		 */
		public static function tint(obj:DisplayObject, color:uint, mul:Number):void {
			
			var ctMul:Number = (1 - mul);
			var ctRedOff:Number = Math.round(mul * extractRed(color));
			var ctGreenOff:Number = Math.round(mul * extractGreen(color));
			var ctBlueOff:Number = Math.round(mul * extractBlue(color));
			var ct:ColorTransform = new ColorTransform(ctMul, ctMul, ctMul, 1, ctRedOff, ctGreenOff, ctBlueOff, 0);
			
			obj.transform.colorTransform = ct;
		}
		
		/**
		 * sets brightness value available are -100 ~ 100 @default is 0
		 * @param 		value:int	brightness value
		 * @return		ColorMatrixFilter
		 * @usage	filters = [
		   mcEffect.setBrightness(-20),
		   mcEffect.setContrast(-10),
		   mcEffect.setSaturation( -100)
		   ]
		 */
		public static function setBrightness(value:Number):ColorMatrixFilter {
			
			value = value * (255 / 250);
			
			var matrix:Array = new Array();
			matrix = matrix.concat([1, 0, 0, 0, value]);	// red
			matrix = matrix.concat([0, 1, 0, 0, value]);	// green
			matrix = matrix.concat([0, 0, 1, 0, value]);	// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);		// alpha
			
			return new ColorMatrixFilter(matrix);
		}
		
		/**
		 * sets contrast value available are -100 ~ 100 @default is 0
		 * @param 		value:int	contrast value
		 * @return		ColorMatrixFilter
		 */
		public static function setContrast(value:Number):ColorMatrixFilter {
			
			value /= 100;
			var s:Number = value + 1;
			var o:Number = 128 * (1 - s);
			
			var matrix:Array = new Array();
			matrix = matrix.concat([s, 0, 0, 0, o]);	// red
			matrix = matrix.concat([0, s, 0, 0, o]);	// green
			matrix = matrix.concat([0, 0, s, 0, o]);	// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);	// alpha
			
			return new ColorMatrixFilter(matrix);
		}
		
		/**
		 * sets saturation value available are -100 ~ 100 @default is 0
		 * @param 		value:int	saturation value
		 * @return		ColorMatrixFilter
		 */
		public static function setSaturation(value:Number):ColorMatrixFilter {
			
			const lumaR:Number = 0.212671;
			const lumaG:Number = 0.71516;
			const lumaB:Number = 0.072169;
			
			var v:Number = (value / 100) + 1;
			var i:Number = (1 - v);
			var r:Number = (i * lumaR);
			var g:Number = (i * lumaG);
			var b:Number = (i * lumaB);
			
			var matrix:Array = new Array();
			matrix = matrix.concat([(r + v), g, b, 0, 0]);	// red
			matrix = matrix.concat([r, (g + v), b, 0, 0]);	// green
			matrix = matrix.concat([r, g, (b + v), 0, 0]);	// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);			// alpha
			
			return new ColorMatrixFilter(matrix);
		}
		
		/**
		 * Creates a colorMatrix that adjusts the hue
		 * @param h The hue of the bitmap.
		 * h values are expected between -180° and 180°.
		 * @return the hue modifying colorMatrix.
		 */
		public static function adjustHue(h:Number):ColorMatrixFilter {
			
			h *= Math.PI / 180;
			var c:Number = Math.cos(h);
			var s:Number = Math.sin(h);
			
			var r0:Number = R_LUM + c * (1 - R_LUM) - s * R_LUM;
			var g0:Number = G_LUM - c * G_LUM - s * G_LUM;
			var b0:Number = B_LUM - c * B_LUM + s * (1 - B_LUM);
			
			var r1:Number = R_LUM - c * R_LUM + s * 0.143;
			var g1:Number = G_LUM + c * (1 - G_LUM) + s * 0.14;
			var b1:Number = B_LUM - c * B_LUM - s * 0.283;
			
			var r2:Number = R_LUM - c * R_LUM - s * (1 - R_LUM);
			var g2:Number = G_LUM - c * G_LUM + s * G_LUM;
			var b2:Number = B_LUM + c * (1 - B_LUM) + s * B_LUM;
			
			var matrix:Array = [r0, g0, b0, 0, 0, r1, g1, b1, 0, 0, r2, g2, b2, 0, 0, 0, 0, 0, 1, 0];
			return new ColorMatrixFilter(matrix);
		}
		
		/**
		 * set passed clip to greyscale
		 * @param	obj
		 */
		public static function desaturate(obj:DisplayObject) {
			
			var r:Number = 0.21;
			var g:Number = 0.71;
			var b:Number = 0.07;
			
			var matrix:Array = [r, g, b, 0, 0, r, g, b, 0, 0, r, g, b, 0, 0, 0, 0, 0, 1, 0];
			obj.filters = [new ColorMatrixFilter(matrix)];
		}
		
		public static function extractRed(c:uint):uint {
			
			return ((c >> 16) & 0xFF);
		}
		
		public static function extractGreen(c:uint):uint {
			
			return ((c >> 8) & 0xFF);
		}
		
		public static function extractBlue(c:uint):uint {
			
			return (c & 0xFF);
		}
		
		/**
		 * Extracts the Alpha channel value from the 32-bit color:
		 * @param	c
		 * @return
		 */
		public static function extractAlpha(c:uint):uint { //not tested
			
			return ((c >> 24) & 0xFF);
		}
		
		public static function combineRGB(r:uint, g:uint, b:uint):uint {
			
			return ((r << 16) | (g << 8) | b);
		}
		
		/**
		 * Combines ARGB data into a color value looks as follows:
		 * @param	a
		 * @param	r
		 * @param	g
		 * @param	b
		 * @return
		 */
		public static function combineARGB(a:uint, r:uint, g:uint, b:uint):uint { //not tested
			
			return ((a << 24) | (r << 16) | (g << 8) | b);
		}
	}
}