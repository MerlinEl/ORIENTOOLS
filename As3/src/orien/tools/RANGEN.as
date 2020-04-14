package orien.tools {
	
	/**
	 * ...
	 * Collection of two Numbers where first is min and second is max
	 * @author René Bača (Orien) 2018
	 */
	public final class RANGEN {
		
		private var _min:Number;
		private var _max:Number;
		private var _by:Number;
		private var _dec:int;
		private var _range:Array = [];
		
		public function RANGEN(min:Number = 0, max:Number = 0, by:Number = 0, dec:int = 0) {
			
			_min = min;
			_max = max;
			_by = by;
			_dec = dec;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'RANGEN(min:' + this.min + ', max:' + this.max + ' by:' + this.by + ' dec:' + this.dec + ')';
		}
		
		/**
		 * Conversion as
		 * @return as Object
		 */
		public function toObject():Object{
            
			return {"min":this.min, "max":this.max, "by":this.by, "dec":this.dec};
        }
		
		/**
		 * Convert object to RANGEN
		 * @example 
		 * cage["range_a"] = {min:1000, max:9000 by:10 dec:0};
		 * var range_a:RANGEN = new RANGEN().fromObject(cage["range_a"]);
		 * @param	obj
		 * @return	RANGEN
		 */
		public function fromObject(obj:Object):RANGEN{
			
			_min = obj.min;
			_max = obj.max;
			_by = obj.by;
			_dec = obj.dec;
			return this;
		}
		
		public function build():Array{
			
			_range = mcMath.numbersInRange(min, max, "all", by);
			return _range;
		}
		
		/*public function getRandomNumber():Number{
			
			if (_range.length == 0) return 0;
			mcArray.shuffle(_range);
			return _range[0];
		}*/
		
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
		
		public function get by():Number {
			return _by;
		}
		
		public function set by(value:Number):void {
			_by = value;
		}
		
		public function get dec():int {
			return _dec;
		}
		
		public function set dec(value:int):void {
			_dec = value;
		}
		
		public function random():Number{
			
			var r:Number = mcMath.randomRange(_min, _max);
			//ftrace("RANGEN > random:%", r);
			return r;
			//return mcMath.randomRange(_min, _max);
		}
	}
}