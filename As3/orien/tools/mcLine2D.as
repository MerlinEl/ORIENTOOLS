package orien.tools {
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcLine2D {
		
		//instance properties
		private var _p1:Point;
		private var _p2:Point;
		
		/**
		 * constructor for mcLine2D
		 * @param	p1:Point, p2:Point
		 * @return	reference to the new instance
		 */
		public function mcLine2D(p1:Point = null, p2:Point = null) {
			
			_p1 = p1 || new Point();
			_p2 = p2 || new Point();
		}
		
		public function get length():Number {
			
			return mcTran.twoPointsDistance(_k1.pos, _k2.pos);
		}
		
		public function get center():Point {
			
			return new Point((_p1.x + _p2.x) / 2, (_p1.y + _p2.y) / 2);
		}
		
		private function centerShiftLocal(offset:Number = 0):Point {
			
			var v2:mcVector2D = new mcVector2D(_p2, center);
			if (offset != 0) v2.length = offset; //if u want 0 use center instead of centerShiftLocal
			var v3:mcVector2D = v2.rotate(-90);
			return v3.toPoint();
		}
		
		/**
		 * Move line to Zero [p1 -p1, p2 - p1]
		 */
		/*public function moveToZero():void{ //experimental
		
		   //yValue -= xValue;
		   //xValue -= yValue;
		}*/
	
		/*public function rotate(rotationAngle:Number):mcVector2D {
			
			var currentLength:Number = Math.sqrt(Math.pow(this.xValue, 2) + Math.pow(this.yValue, 2));
			var newAngleRadians:Number = ((Math.atan2(this.yValue, this.xValue) * (180 / Math.PI)) + Number(rotationAngle)) * (Math.PI / 180);
			this.xValue = this.fixNumber(currentLength * Math.cos(newAngleRadians));
			this.yValue = this.fixNumber(currentLength * Math.sin(newAngleRadians));
			return this;
		}*/
		
		
		/*public function get length():Number{
			
			
			
		}*/
		
		/**
		 * Not used not tested
		 * @param	line_a
		 * @param	line_b
		 * @return
		 */
		public function twoLinesIntersection(line_a:mcLine2D, line_b:mcLine2D):Point {
			
			var a:Point = line_a._p1;
			var b:Point = line_a._p2;
			var c:Point = line_b._p1;
			var d:Point = line_b._p2;
			var distAB:Number, cos:Number, sin:Number, newX:Number, ABpos:Number;
			if ((a.x == b.x && a.y == b.y) || (c.x == d.x && c.y == d.y)) return null;
			
			if (a == c || a == d || b == c || b == d) return null;
			
			b = b.clone();
			c = c.clone();
			d = d.clone();
			
			b.offset(-a.x, -a.y);
			c.offset(-a.x, -a.y);
			d.offset(-a.x, -a.y);
			// a is now considered to be (0,0)
			
			distAB = b.length;
			cos = b.x / distAB;
			sin = b.y / distAB;
			
			c = new Point(c.x * cos + c.y * sin, c.y * cos - c.x * sin);
			d = new Point(d.x * cos + d.y * sin, d.y * cos - d.x * sin);
			
			if ((c.y < 0 && d.y < 0) || (c.y >= 0 && d.y >= 0)) return null;
			
			ABpos = d.x + (c.x - d.x) * d.y / (d.y - c.y); // what.
			if (ABpos < 0 || ABpos > distAB) return null;
			
			return new Point(a.x + ABpos * cos, a.y + ABpos * sin);
		}
	}
}