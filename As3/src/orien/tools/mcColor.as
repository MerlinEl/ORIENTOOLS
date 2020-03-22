//copyright Ward De Langhe
//Very Interactive People
package orien.tools {
	import flash.filters.ColorMatrixFilter;
	
	public class mcColor {
		public function mcColor() {
		}
		
		public static function brightenColor(hexColor:Number, percent:Number):Number {
			
			if (isNaN(percent))
				percent = 0;
			if (percent > 100)
				percent = 100;
			if (percent < 0)
				percent = 0;
			
			var factor:Number = percent / 100;
			var rgb:Object = hexToRgb(hexColor);
			
			rgb.r += (255 - rgb.r) * factor;
			rgb.b += (255 - rgb.b) * factor;
			rgb.g += (255 - rgb.g) * factor;
			
			return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
		}
		
		public static function darkenColor(hexColor:Number, percent:Number):Number {
			
			if (isNaN(percent)) percent = 0;
			percent = mcMath.minMaxFrom(percent,   0, 100);
			
			var factor:Number = 1 - (percent / 100);
			var rgb:Object = hexToRgb(hexColor);
			
			rgb.r *= factor;
			rgb.b *= factor;
			rgb.g *= factor;
			
			return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
		}
		
		public static function rgbToHex(r:Number, g:Number, b:Number):Number {
			
			return (r << 16 | g << 8 | b);
		}
		
		public static function hexToRgb(hex:Number):Object {
			
			return {r: (hex & 0xff0000) >> 16, g: (hex & 0x00ff00) >> 8, b: hex & 0x0000ff};
		}
		
		public static function brightness(hex:Number):Number {
			
			var max:Number = 0;
			var rgb:Object = hexToRgb(hex);
			if (rgb.r > max)
				max = rgb.r;
			if (rgb.g > max)
				max = rgb.g;
			if (rgb.b > max)
				max = rgb.b;
			max /= 255;
			return max;
		}
	
		static public function randomHex():uint {
			
			var r:int = mcMath.randomRange(0, 255);
			var g:int = mcMath.randomRange(0, 255);
			var b:int = mcMath.randomRange(0, 255);
			return rgbToHex(r, g, b);
		}
		
		/**
		 * Brightness2
		 * @param	color
		 * @param	scale
		 * @return
		 */
		static public function scaleColor(color:uint, scale:Number):uint {
			
			var r:int = (color & 0xFF0000) >> 16;
			var g:int = (color & 0x00FF00) >> 8;
			var b:int = color & 0x0000FF;
			r += (255 * scale) * (r / (r + g + b));
			r = (r > 255) ? 255 : r;
			r = (r < 0) ? 0 : r;
			g += (255 * scale) * (g / (r + g + b));
			g = (g > 255) ? 255 : g;
			g = (g < 0) ? 0 : g;
			b += (255 * scale) * (b / (r + g + b));
			b = (b > 255) ? 255 : b;
			b = (b < 0) ? 0 : b;
			return (r << 16 & 0xff0000) + (g << 8 & 0x00ff00) + (b & 0x0000ff);
		}
	}
}