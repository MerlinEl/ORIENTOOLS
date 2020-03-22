package orien.tools {
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class Rect {
		
		private var _w:Number;
		private var _h:Number;
		
		public function Rect(width:Number, height:Number) {
			
			_w = width;
			_h = height;
		}
		
		public function get width():Number {
			return _w;
		}
		
		public function set width(value:Number):void {
			_w = value;
		}
		
		public function get height():Number {
			return _h;
		}
		
		public function set height(value:Number):void {
			_h = value;
		}
	}
}