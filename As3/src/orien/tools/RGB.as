package orien.tools {
	
	/**
	 * DO NOT USE THIS CLASS SEPARATELY. BETTER WAY IS TO USE MASTER CLASS > orien.tools.COLOR
	 * ...
	 * @author René Bača (Orien) 2016 - 2018
	 */
	public class RGB {
		private var _r:int = 0; //red
		private var _g:int = 0; //green
		private var _b:int = 0; //blue
		
		/**
		 * Contructs an RGB object for containing Red Blue and Gree values
		 * @param	r Red (0-255)
		 * @param	g Green (0-255)
		 * @param	b Blue (0-255)
		 */
		public function RGB(red:int = 0, green:int = 0, blue:int = 0) {
			//min and max values limit
			_r = mcMath.minMaxFrom(red,   0, 255);
			_g = mcMath.minMaxFrom(green, 0, 255);
			_b = mcMath.minMaxFrom(blue,  0, 255);
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString():String {
			
			return '{RGB(r:' + this.r + ', g:' + this.g + ', b:' + this.b + ')}';
		}

		public function get r():int {
			return _r;
		}
		
		public function set r(value:int):void {
			_r = value;
		}
		
		public function get g():int {
			return _g;
		}
		
		public function set g(value:int):void {
			_g = value;
		}
		
		public function get b():int {
			return _b;
		}
		
		public function set b(value:int):void {
			_b = value;
		}
	}
}