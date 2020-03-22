package orien.tools {
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class COMPASS {
		
		private var _top:Boolean = false; 
		private var _btm:Boolean = false;
		private var _west:Boolean = false;
		private var _east:Boolean = false;
		private var _north:Boolean = false;
		private var _south:Boolean = false;
	
		public function COMPASS() {
		
		}
		
		public function get top():Boolean {
			return _top;
		}
		
		public function set top(value:Boolean):void {
			_top = value;
		}
		
		public function get btm():Boolean {
			return _btm;
		}
		
		public function set btm(value:Boolean):void {
			_btm = value;
		}
		
		public function get west():Boolean {
			return _west;
		}
		
		public function set west(value:Boolean):void {
			_west = value;
		}
		
		public function get east():Boolean {
			return _east;
		}
		
		public function set east(value:Boolean):void {
			_east = value;
		}
		
		public function get north():Boolean {
			return _north;
		}
		
		public function set north(value:Boolean):void {
			_north = value;
		}
		
		public function get south():Boolean {
			return _south;
		}
		
		public function set south(value:Boolean):void {
			_south = value;
		}
	}
}