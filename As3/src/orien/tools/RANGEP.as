package orien.tools {
	import flash.geom.Point;
	
	/**
	 * ...
	 * Collection of two Points where first is min and second is max
	 * @author René Bača (Orien) 2018
	 */
	public final class RANGEP {
		
		private var _min:Point;
		private var _max:Point;
		
		public function RANGEP(min:Point = null, max:Point = null) {
			
			_min = min == null ? new Point() : min;
			_max = max == null ? new Point() : max;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'RANGEP(min:' + this.min + ', max:' + this.max + ')';
		}
		
		/**
		 * Conversion as
		 * @return as Object
		 */
		public function toObject():Object{
            
			return {"min":_min, "max":_max};
        }
		
		public function get min():Point {
			return _min;
		}
		
		public function set min(value:Point):void {
			_min = value;
		}
		
		public function get max():Point {
			return _max;
		}
		
		public function set max(value:Point):void {
			_max = value;
		}
	}
}