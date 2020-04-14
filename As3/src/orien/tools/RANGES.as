package orien.tools {
	
	/**
	 * ...
	 * Collection of two Strings where first is min and second is max
	 * @author René Bača (Orien) 2018
	 */
	public final class RANGES {
		
		private var _min:String;
		private var _max:String;
		
		public function RANGES(min:String = "0", max:String = "0") {
			
			_min = min;
			_max = max;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'RANGES(min:' + this.min + ', max:' + this.max + ')';
		}
		
		/**
		 * Conversion as
		 * @return as Object
		 */
		public function toObject():Object{
            
			return {"min":_min, "max":_max};
        }
		
		public function get min():String {
			return _min;
		}
		
		public function set min(value:String):void {
			_min = value;
		}
		
		public function get max():String {
			return _max;
		}
		
		public function set max(value:String):void {
			_max = value;
		}
	}
}