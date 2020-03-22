package orien.tools { //used at mcs.MultiSlotSwapCage
	import flash.geom.Point;

	/**
	 * ...
	 * @author René Bača (Orien) 2017
	 */
	public class ROWDATA {
		
		private var _arr:mcArray;
		private var _index:int;
		private var _pos:Point;
		private var _x:Number;
		private var _y:Number;
		
		public function ROWDATA(mc_array:mcArray = null, index:int = 0, pos:Point = null) {
			
			//ftrace("Create ROWDATA with card:% and index:%", mc_array.getFistItem().name, index)
			_arr = mc_array;
			_index = index;
			_pos = pos ? pos : new Point();
			_x = pos.x;
			_y = pos.y;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString():String {
			
			return 'ROWDATA(index:' + this.index + ', pos:' + this.pos + ')';
		}
		
		public function addItem(item:*):void{
			
			_arr.addItem(item);
		}
		
		public function toMcArray():mcArray {
			return _arr;
		}
		
		public function toArray():Array {
			return _arr.source;
		}
		
		public function get index():int {
			return _index;
		}
		
		public function get pos():Point {
			return _pos;
		}
		
		public function set pos(value:Point):void {
			_pos = value;
			this.x = value.x;
			this.y = value.y;
		}
		
		public function get x():Number {
			return _x;
		}
		
		public function set x(value:Number):void {
			_x = value;
			_arr.setParam("x", value);
		}
		
		public function get y():Number {
			return _y;
		}
		
		public function set y(value:Number):void {
			_y = value;
			_arr.setParam("y", value);
		}
		
	}
}