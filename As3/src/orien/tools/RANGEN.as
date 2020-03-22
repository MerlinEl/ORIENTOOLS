package orien.tools {
	
	/**
	 * ...
	 * Collection of two Numbers where first is min and second is max
	 * @author René Bača (Orien) 2018
	 */
	public final class RANGEN {
		
		private var _min:Number;
		private var _max:Number;
		
		public function RANGEN(min:Number = 0, max:Number = 0) {
			
			_min = min;
			_max = max;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'RANGEN(min:' + this.min + ', max:' + this.max + ')';
		}
		
		/**
		 * Conversion as
		 * @return as Object
		 */
		public function toObject():Object{
            
			return {"min":_min, "max":_max};
        }
		
		public function get min():Number {
			return _min;
		}
		
		public function set min(value:Number):void {
			_min = value;
		}
		
		public function get max():Number {
			return _max;
		}
		
		public function set max(value:Number):void {
			_max = value;
		}
	}
}