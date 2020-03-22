package orien.tools {
	
	/**
	 * DO NOT USE THIS CLASS SEPARATELY. BETTER WAY IS TO USE MASTER CLASS > orien.tools.COLOR
	 * ...
	 * @author René Bača (Orien) 2018
	 */
	public final class HSB {
		
		private var _h:Number;
		private var _s:Number;
		private var _b:Number;
		
		/**
		 *  Constructs an HSB with optional parameters.
		 *  @param hue The hue.
		 *  @param saturation The saturation.
		 *  @param brightness The brightness.
		 */
		public function HSB(hue:Number = 0, saturation:Number = 0, brightness:Number = 0) {
			
			this.h = hue;
			this.s = saturation;
			this.b = brightness;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return '{object HSB(h:' + this.h + ', s:' + this.s + ', b:' + this.b + ')}';
		}
		
		/**
		 * Conversion as
		 * @return as Object
		 */
		public function toObject():Object{
            
			return {"h":_h, "s":_s, "b":_b};
        }
		
		/**
		 * Angle, in degrees, around the HSB cone. The supplied value will be modulated
		 * by 360 so that the stored value of hue will be in the range [0,360).
		 */
		public function get h():Number {
			
			return _h;
		}
		
		public function set h(value:Number):void {
			
			_h = value % 360;
		}
		
		/**
		 * Value between 0 (black) and 1 (full saturation), 
		 * which represents the distance from the center in the HSB cone.
		 */
		public function get s():Number {
			
			return _s;
		}
		
		public function set s(value:Number):void {
			
			_s = value;
		}
		
		/**
		 * Value between 0 (black) and 1 (full brightness),
		 * which represents the distance from the apex of the HSB cone.
		 */
		public function get b():Number {
			
			return _b;
		}
		
		public function set b(value:Number):void {
			
			_b = value;
		}
	}
}