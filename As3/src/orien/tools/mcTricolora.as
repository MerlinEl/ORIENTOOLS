package orien.tools {
	import flash.display.Graphics;
	
	/**
	 * It is three colors generated from one. (fill, border, glow)
	 * @usage e:\Work\NováŠkola\@Flash_Research\Colors\HappyColorsTester.fla 
	 * @author René Bača (Orien) 2018
	 */
	public class mcTricolora {
		
		private var _fill:uint
		private var _border:uint
		private var _glow:uint
		
		/**
		 * Generate 2 darken corols from one to get (3 gradient colors) 
		 * @param	clr
		 * @param	border_bri
		 * @param	border_sat
		 * @param	glow_bri
		 * @param	glow_sat
		 */
		public function mcTricolora(clr:uint, border_bri:Number = 28, border_sat:Number = 88, glow_bri:Number = 51, glow_sat:Number = 77):void {
			
			_fill = clr;
			_border = transformColor(clr, border_bri, border_sat);
			_glow = transformColor(clr, glow_bri, glow_sat); 
		}
		
		private function transformColor(clr:uint, brightness:Number, saturation:Number, hue:Number = NaN):uint {
			
			var c:COLOR = new COLOR(clr);
			c.darken = brightness;
			//c.brightness = brightness; //not same result on all colors
			c.saturation = saturation;
			if (hue) c.hue = hue;
			return c.hex;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return '{object mcTricolora(fill:' + this.fill + ', border:' + this.border + ', glow:' + this.glow + ')}';
		}
		
		/**
		 * Collect input settings
		 * @return settings Object
		 */
		public function toObject():Object {
			
			return { "fill":this.fill, "border":this.border, "glow":this.glow };
		}
		
		/*public function draw(gra:Graphics, pos_x:Number, pos_y:Number, size_w:Number, siz_h:Number):void{
			
			
			
		}*/
		
		public function get fill():uint {
			
			return _fill;
		}
		
		public function set fill(value:uint):void {
			
			_fill = value;
		}
		
		public function get border():uint {
			
			return _border;
		}
		
		public function set border(value:uint):void {
			
			_border = value;
		}
		
		public function get glow():uint {
			
			return _glow;
		}
		
		public function set glow(value:uint):void {
			
			_glow = value;
		}
	}
}