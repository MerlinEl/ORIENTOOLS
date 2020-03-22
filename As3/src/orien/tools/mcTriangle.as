package orien.tools 
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2015
	 */
	public class mcTriangle extends Object {
		
		private var _verts:Vector.<Number>;
		private var _x:Number;
		private var _y:Number;
		private var _a:Point;
		private var _b:Point;
		private var _c:Point;
		private var _w:Number;
		private var _h:Number;
		
		public function mcTriangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) {
			
			_x = x;
			_y = y;
			_w = width;
			_h = height;
			
			_a = new Point(x, y);
			_b = new Point(x + width, y);
			_c = new Point(x + width / 2, y - height);
			update();
		}
		
		private function update():void {
			
			_verts = Vector.<Number>([_a.x, _a.y, _b.x, _b.y, _c.x, _c.y]);
			_x = this.x;
			_y = this.y;
		}
		
		public function set x(value:Number):void {
			
			_x = value;
			move(value, 0);
		}
		
		public function set y(value:Number):void {
			
			_y = value;
			move(0, value);
		}
		
		public function get x():Number {
			
			//get min value from abc X
			return Math.min.apply(null, [_a.x, _b.x, _c.x]);
		}
		
		public function get y():Number {
			
			//get max value from abc Y
			return Math.max.apply(null, [_a.y, _b.y, _c.y]);
		}
		
		public function get verts():Vector.<Number> {
			
			return _verts;
		}
		
		public function get a():Point {
			
			return _a;
		}
		
		public function get b():Point {
			
			return _b;
		}
		
		public function get c():Point {
			
			return _c;
		}
		
		public function move(x:Number, y:Number):void {
			
			_a.x += x;
			_b.x += x;
			_c.x += x;
			
			_a.y += y;
			_b.y += y;
			_c.y += y;
			
			update();
		}
		
		public function rotate(deg:Number):void {

			var center:Point = mcTran.pointsCenter([_a, _b, _c]);
			for each (var point:Point in[_a, _b, _c]) {
				
				var new_pos:Point = rotatePointAroundOrigin(point.x, point.y, center.x, center.y, deg);
				point.x = new_pos.x;
				point.y = new_pos.y;
			}
			update();
		}
		
		public function pointAt(way:String):void {
			
			switch (way) {
			
			case "top": 
				break;
			case "bottom": 
				rotate(180);
				break;
			case "left": 
				rotate(-90);
				break;
			case "right": 
				rotate(90);
				break;
			}
		}
		
		private function rotatePointAroundOrigin(pointX:Number, pointY:Number, originX:Number, originY:Number, angle:Number):Point {
			
			var radians:Number = angle * Math.PI / 180.0;
			return new Point(Math.cos(radians) * (pointX - originX) - Math.sin(radians) * (pointY - originY) + originX, Math.sin(radians) * (pointX - originX) + Math.cos(radians) * (pointY - originY) + originY);
		}
	}
}