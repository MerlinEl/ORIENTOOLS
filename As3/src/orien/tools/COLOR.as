package orien.tools {
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016 - 2018
	 */
	public class COLOR {
		
		private var _hex:uint;
		private var _rgb:RGB;
		private var _hsb:HSB;
		
		public function COLOR(... args):void {
			
			//input values [r:Number, g:Number, b:Number]
			if (args.length == 3) {
				
				_rgb = new RGB(args[0], args[1], args[2]);
				
					//input values [clr:RGB] or [clr:uint]
			} else if (args.length == 1) {
				
				var color:* = args[0];
				if (color is RGB) {
					
					_rgb = color as RGB;
					
				} else if (color is uint) {
					
					_hex = color as uint;
				}
					//input null
			} else {
				
				_rgb = new RGB();
				_hex = 0x000000;
			}
			//ftrace("pass hex:% rgb:% hsb:%", _hex, _rgb, _hsb)
			if (!_rgb && _hex) _rgb = rgbFromHex(_hex);
			if (!_hex && _rgb) _hex = hexFromRGB(_rgb);
			_hsb = hsbFromRGB(_rgb);
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'COLOR(hex:' + _hex + ' r:' + this.r + ', g:' + this.g + ', b:' + this.b + ' hsb:' + this._hsb + ')';
		}
		
		//getters and setters
		public function get hex():uint {
			
			return _hex;
		}
		
		public function set hex(value:uint):void {
			
			_hex = value;
			_rgb = rgbFromHex(_hex);
			_hsb = hsbFromRGB(_rgb);
		}
		
		public function get rgb():RGB {
			
			return _rgb;
		}
		
		public function set rgb(value:RGB):void {
			
			_rgb = value;
			_hex = hexFromRGB(_rgb);
			_hsb = hsbFromRGB(_rgb);
		}
		
		public function get r():int {
			
			return _rgb.r;
		}
		
		public function set r(value:int):void {
			
			_rgb.r = value;
			_hex = hexFromRGB(_rgb);
			_hsb = hsbFromRGB(_rgb);
		}
		
		public function get g():int {
			
			return _rgb.g;
		}
		
		public function set g(value:int):void {
			
			_rgb.g = value;
			_hex = hexFromRGB(_rgb);
			_hsb = hsbFromRGB(_rgb);
		}
		
		public function get b():int {
			
			return _rgb.b;
		}
		
		public function set b(value:int):void {
			
			_rgb.b = value;
			_hex = hexFromRGB(_rgb);
			_hsb = hsbFromRGB(_rgb);
		}
		
		public function set darken(percent:Number):void {
			
			percent = mcMath.minMaxFrom(percent,   0, 100);
			var factor:Number = 1 - (percent / 100);
			_rgb.r *= factor;
			_rgb.b *= factor;
			_rgb.g *= factor;
			_hex = hexFromRGB(_rgb);
			_hsb = hsbFromRGB(_rgb);
		}
		
		/**
		 * Angle, in degrees, around the HSB cone. The supplied value will be modulated
		 * by 360 so that the stored value of hue will be in the range [0,360).
		 */
		public function get hue():Number {
			
			return _hsb.h;
		}
		
		public function set hue(value:Number):void {
			
			_hsb.h = value % 360;
			_rgb = rgbFromHSB(_hsb);
			_hex = hexFromRGB(_rgb);
		}
		
		/**
		 * Value between 0 (black) and 1 (full saturation),
		 * which represents the distance from the center in the HSB cone.
		 */
		public function get saturation():Number {
			
			return _hsb.s;
		}
		
		public function set saturation(value:Number):void {
			
			_hsb.s = value;
			_rgb = rgbFromHSB(_hsb);
			_hex = hexFromRGB(_rgb);
		}
		
		/**
		 * Value between 0 (black) and 1 (full brightness),
		 * which represents the distance from the apex of the HSB cone.
		 */
		public function get brightness():Number {
			
			return _hsb.b;
		}
		
		public function set brightness(value:Number):void {
			
			_hsb.b = value;
			_rgb = rgbFromHSB(_hsb);
			_hex = hexFromRGB(_rgb);
		}
		
		//CONVERTERS
		private function hexFromRGB(rgb:RGB):uint {
			
			return rgb.r << 16 | rgb.g << 8 | rgb.b;
		}
		
		public function rgbFromHex(hex:uint):RGB {
			
			return new RGB((hex & 0xff0000) >> 16, (hex & 0x00ff00) >> 8, hex & 0x0000ff);
		}
		
		public function rgbFromHSB(hsb:HSB):RGB {
			
			var rgb:RGB = new RGB();
			var max:Number = (hsb.b * 0.01) * 255;
			var min:Number = max * (1 - (hsb.s * 0.01));
			
			if (hsb.h == 360) {
				hsb.h = 0;
			}
			
			if (hsb.s == 0) {
				rgb.r = rgb.g = rgb.b = hsb.b * (255 * 0.01);
			} else {
				var _h:Number = Math.floor(hsb.h / 60);
				
				switch (_h) {
				case 0: 
					rgb.r = max;
					rgb.g = min + hsb.h * (max - min) / 60;
					rgb.b = min;
					break;
				case 1: 
					rgb.r = max - (hsb.h - 60) * (max - min) / 60;
					rgb.g = max;
					rgb.b = min;
					break;
				case 2: 
					rgb.r = min;
					rgb.g = max;
					rgb.b = min + (hsb.h - 120) * (max - min) / 60;
					break;
				case 3: 
					rgb.r = min;
					rgb.g = max - (hsb.h - 180) * (max - min) / 60;
					rgb.b = max;
					break;
				case 4: 
					rgb.r = min + (hsb.h - 240) * (max - min) / 60;
					rgb.g = min;
					rgb.b = max;
					break;
				case 5: 
					rgb.r = max;
					rgb.g = min;
					rgb.b = max - (hsb.h - 300) * (max - min) / 60;
					break;
				case 6: 
					rgb.r = max;
					rgb.g = min + hsb.h * (max - min) / 60;
					rgb.b = min;
					break;
				}
				
				rgb.r = Math.min(255, Math.max(0, Math.round(rgb.r)))
				rgb.g = Math.min(255, Math.max(0, Math.round(rgb.g)))
				rgb.b = Math.min(255, Math.max(0, Math.round(rgb.b)))
			}
			return rgb;
		}
		
		public function hsbFromRGB(col:RGB):HSB {
			
			var hsb:HSB = new HSB();
			var _max:Number = Math.max(col.r, col.g, col.b);
			var _min:Number = Math.min(col.r, col.g, col.b);
			
			hsb.s = (_max != 0) ? (_max - _min) / _max * 100 : 0;
			hsb.b = _max / 255 * 100;
			
			if (hsb.s == 0) {
				hsb.h = 0;
			} else {
				switch (_max) {
				case col.r: 
					hsb.h = (col.g - col.b) / (_max - _min) * 60 + 0;
					break;
				case col.g: 
					hsb.h = (col.b - col.r) / (_max - _min) * 60 + 120;
					break;
				case col.b: 
					hsb.h = (col.r - col.g) / (_max - _min) * 60 + 240;
					break;
				}
			}
			
			hsb.h = Math.min(360, Math.max(0, Math.round(hsb.h)))
			hsb.s = Math.min(100, Math.max(0, Math.round(hsb.s)))
			hsb.b = Math.min(100, Math.max(0, Math.round(hsb.b)))
			
			return hsb;
		}
		
		//OTHER FUNCTIONS
		/**
		 * Generate random color
		 */
		public function random():void {
			
			r = mcMath.randomRange(0, 255);
			g = mcMath.randomRange(0, 255);
			b = mcMath.randomRange(0, 255);
		}
		
		//Static Functions
		static public function hexFromUINT(dec:uint):String {
     
			var digits:String = "0123456789ABCDEF";
			var hex:String = '';
			while (dec > 0) {
		 
				var next:uint = dec & 0xF;
				dec >>= 4;
				hex = digits.charAt(next) + hex;
		 
			}
			if (hex.length == 0) hex = '0'
			return hex;
		}
	
	/*
	   public function setARGB(a:Number, r:Number, g:Number, b:Number):uint
	   {
	   var argb:uint = 0;
	   argb += (a << 24);
	   argb += (r << 16);
	   argb += (g << 8);
	   argb += (b);
	   return argb;
	   }
	 */
	
	/**
	 * not tested
	 * @param color_alpha 0 - 100
	 */
	/*public function set alpha(color_alpha:Number):void {
	
	   //hex = ( (color_alpha << 24) | ( _rgb.r << 16 ) | ( _rgb.g << 8 ) | _rgb.b );
	   var colorTransform = new ColorTransform();
	   colorTransform.color = _hex;
	   colorTransform.alphaMultiplier = color_alpha;
	   hex = colorTransform.color;
	   }*/
	
	/*public function lighten(percent:Number):void {
	
	   if (isNaN(percent) || percent <= 0) return;
	   if (percent >= 100) hex = 0xFFFFFF;
	
	   var factor:Number = percent / 100;
	   var channel:Number = factor * 255;
	   factor = 1 - factor;
	
	   _rgb.r = Math.round(channel + _rgb.r * factor);
	   _rgb.g = Math.round(channel + _rgb.r * factor);
	   _rgb.b = Math.round(channel + _rgb.b * factor);
	   }
	
	   public function darken(percent:Number):void {
	
	   if (isNaN(percent) || percent <= 0) return;
	   if (percent >= 100) hex = 0x000000;
	
	   var factor:Number = 1 - (percent / 100);
	
	   _rgb.r = Math.round(_rgb.r * factor);
	   _rgb.g = Math.round(_rgb.r * factor);
	   _rgb.b = Math.round(_rgb.r * factor);
	   }*/
	}
}