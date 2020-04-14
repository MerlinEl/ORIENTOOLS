package orien.tools {
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * Collection of two Points where first is min and second is max
	 * @author René Bača (Orien) 2018
	 */
	public final class TRIANGLE {
		
		private var _alpha:Number;
		private var _beta:Number;
		private var _gama:Number;
		private var _points:Array = [];
		private var _safe_rect:Rectangle;
		private var _pA:Point = new Point();
		private var _pB:Point = new Point();
		private var _pC:Point = new Point();
		private var _pos:Point;
		private var _width:Number;
		private var _height:Number;
		private var _rect:Rectangle;
		
		public function TRIANGLE(rect:Rectangle) {
			
			_safe_rect = rect;
			ftrace("TRIANGLE > build in rect:%", _safe_rect)
		}
		
	    /**
		* @author Orien and Peter and Semi 2018 (opsaná kružnice trojúhelníku)
		* @param	angle_alpha
		* @param	angle_beta
		* @return
		*/
		public function buildByTwoAngles(angle_alpha:Number, angle_beta:Number):void {
						
			//           (C)
			//            +
			//           . .
			//          . γ .
			//         .     .
			//      b .       . a
			//       .         .
			//      .  α     β  .
			//  (A)+ . . . . . . +(B)
			//            c
			alpha = angle_alpha;
			beta = angle_beta;
			gama = 180 - (angle_alpha + angle_beta);
			ftrace('set angles alpha:% beta:% gama:%', alpha, beta, gama);
			
			var alpha_rad:Number = mcTran.degToRadians(alpha);
			var beta_rad:Number = mcTran.degToRadians(beta);
			var gama_rad:Number = mcTran.degToRadians(gama);
			
			var diameter:Number = Math.min(_safe_rect.width, _safe_rect.height);
			//ftrace("diameter:%", diameter)
			var len_a:Number = diameter * Math.sin(alpha_rad);
			var len_b:Number = diameter * Math.sin(beta_rad);
			var len_c:Number = diameter * Math.sin(gama_rad);
			//ftrace("diameter:% len a:% b:% c:%",diameter, len_a, len_b, len_c);
			
			pA = new Point(0, 0);
			pB = new Point(len_c, 0)
			var height_c:Number = len_b * Math.sin(alpha_rad);
			var pythagoras:Number = Math.pow(len_b, 2) - Math.pow(height_c, 2);
			pC = new Point(Math.sqrt(pythagoras), -height_c);
			if (alpha > 90) pC.x = -pC.x;
			
			var min_x:Number = Math.min.apply(null,[pA.x, pB.x, pC.x]);
			var min_y:Number = Math.min.apply(null,[pA.y, pB.y, pC.y]);
			var max_x:Number = Math.max.apply(null,[pA.x, pB.x, pC.x]);
			var max_y:Number = Math.max.apply(null, [pA.y, pB.y, pC.y]);
			
			_pos = new Point(min_x, min_y);
			_width = (max_x - min_x);
			_height = (max_y-min_y);
			_rect = new Rectangle(_pos.x, _pos.y, _width, _height);
			centerTriangleToRect();
			
			//debug
			printAngles();
		}
		
		private function printAngles():void {
			
			//alpha
			var vCA:mcVector2D = new mcVector2D(pC, pA);
			var vBA:mcVector2D = new mcVector2D(pB, pA);
			//beta
			var vAB:mcVector2D = new mcVector2D(pA, pB);
			var vCB:mcVector2D = new mcVector2D(pC, pB);
			//gama
			var vAC:mcVector2D = new mcVector2D(pA, pC);
			var vBC:mcVector2D = new mcVector2D(pB, pC);

			ftrace('get angles alpha:% beta:% gama:%', vCA.angleBetween(vBA), vAB.angleBetween(vCB), vAC.angleBetween(vBC));
		}
		
		
		private function centerTriangleToRect():void{

			var rect_center:Point = getCenter(_safe_rect);
			var tri_center:Point = getCenter(_rect);
			var offset:Point = new Point(pA.x + tri_center.x - rect_center.x, pA.y + tri_center.y - rect_center.y);
			
			pA.offset(-offset.x, -offset.y);
			pB.offset(-offset.x, -offset.y);
			pC.offset(-offset.x, -offset.y);
		}
		
		private function getCenter(obj_rect:Rectangle):Point {
		
			return new Point(obj_rect.x + obj_rect.width / 2, obj_rect.y + obj_rect.height / 2);
		}
		
		public function drawTo(gra:Graphics, angle_alpha:Number, angle_beta:Number, fill_color:uint, line_color:uint, thickness:Number = 2):void{	
			
			buildByTwoAngles(angle_alpha, angle_beta);
			with (gra){
				
				clear();
				beginFill(fill_color, 1);
				lineStyle(thickness, line_color, 1, true);
				moveTo(pA.x, pA.y); //base left
				lineTo(pB.x, pB.y); //base right
				lineTo(pC.x, pC.y); //top
				lineTo(pA.x, pA.y); //base left
				endFill();
			}
		}

		private function getPointC(start_pos:Point, angle_rad:Number, len:Number):Point {
			
			return new Point(
			
				start_pos.x + len * Math.cos(angle_rad), 
				start_pos.y + len * -Math.sin(angle_rad)
			);
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'TRIANGLE(pos:[A:['+pA+', B:'+pB+', C:'+pC+'] angles:[α:' + alpha + ', β:' + beta + ', γ:' + gama + '])';
		}
		
		/**
		 * Conversion as
		 * @return as Object
		 */
		public function toObject():Object {
			
			return {"α": alpha, "β": beta, "γ": gama}
		}
		
		public function get alpha():Number {
			return _alpha;
		}
		

		public function get beta():Number {
			return _beta;
		}
		
		public function get gama():Number {
			return _gama;
		}
				
		
		public function set alpha(value:Number):void {
			_alpha = value;
		}
		
		public function set beta(value:Number):void {
			_beta = value;
		}
		public function set gama(value:Number):void {
			_gama = value;
		}
		
		public function get pA():Point {
			return _pA;
		}
		
		public function set pA(value:Point):void {
			_pA = value;
		}
		
		public function get pB():Point {
			return _pB;
		}
		
		public function set pB(value:Point):void {
			_pB = value;
		}
		
		public function get pC():Point {
			return _pC;
		}
		
		public function set pC(value:Point):void {
			_pC = value;
		}

				
		/*private function rotatePointAroundOrigin(pointX:Number, pointY:Number, originX:Number, originY:Number, angle:Number):Point {
			
			var radians:Number = mcTran.degToRadians(angle);
			return new Point(Math.cos(radians) * (pointX - originX) - Math.sin(radians) * (pointY - originY) + originX, Math.sin(radians) * (pointX - originX) + Math.cos(radians) * (pointY - originY) + originY);
		}*/
	}
}


	
/*
//old way create triangle

alpha = angle_alpha; //35
beta = angle_beta; //60
gama = 180 - (angle_alpha + angle_beta);

var alpha_rad:Number = mcTran.degToRadians(alpha);
var beta_rad:Number = mcTran.degToRadians(beta);

var b_len:Number = _safe_rect.height / Math.sin(alpha_rad);
var a_len:Number = _safe_rect.height / Math.sin(beta_rad);
var x_b:Number = _safe_rect.height / Math.tan(alpha_rad) + _safe_rect.height / Math.tan(beta_rad);

pA = new Point(_safe_rect.x, _safe_rect.y);	
pB = new Point(x_b + _safe_rect.x, _safe_rect.y);
pC = getPointC(pA, alpha_rad, b_len);
*/
				
		/**
		 * Random scale TRIANGLE 
		 * @param	min
		 * @param	max
		 */
		/*public function randomScale(min:Number, max:Number):void {
			
			var center:Point = mcTran.pointsCenter(_points);
			var va:mcVector2D = new mcVector2D(_points[0], center);
			var vb:mcVector2D = new mcVector2D(_points[1], center);
			var vc:mcVector2D = new mcVector2D(_points[2], center);
			var random_scale:Number = mcMath.randomRangeDecimal(min, max, 1);
			va.length *= random_scale;
			vb.length *= random_scale;
			vc.length *= random_scale;
			_points[0] = va.toPoint();
			_points[1] = vb.toPoint();
			_points[2] = vc.toPoint();
			roundPoints();
		}
		
			
		private function roundPoints():void {
			
			mcTran.roundPoint(pA, 2);
			mcTran.roundPoint(pB, 2);
			mcTran.roundPoint(pC, 2);
		}
		
		private function roundAngles():void {
			
			alpha = mcMath.roundToDecimals(alpha, 2);
			beta = mcMath.roundToDecimals(beta, 2);
			gama = mcMath.roundToDecimals(gama, 2);
		}*/

/*	
 
private function getPointB(pos:Point, angle:Number, len:Number):Point{
	
	var angle_rad:Number = mcTran.degToRadians(_alpha);
	//var len_vector = Math.sin(angle_rad) / len;
	var pointX:Number = Math.cos(angle_rad) / Math.sin(angle_rad) * len;
	return new Point(pointX, 0);
}


private function getEndPointAt_old(pos:Point, angle:Number, len:Number):Point {
	
	var angle_rad:Number = mcTran.degToRadians(_alpha);
	var pointX:Number = (len * Math.cos(angle_rad)) + pos.x;
	var pointY:Number = (len * -Math.sin(angle_rad)) + pos.y;
	return new Point(pointX, pointY);
} 

for (var i:Number = 0; i < this._viewAngle; i++)
{
    var pointX:Number = (this._viewRange) * Math.sin((90 - this._viewAngle * 0.5 + i) * Math.PI / 180);
    var pointY:Number = (this._viewRange) * -Math.cos((90 - this._viewAngle * 0.5 + i) * Math.PI / 180);
    graphics.lineTo(pointX + 100, pointY + 100);
    graphics.moveTo(100, 100);
}
 * 
var angleAInRadians:Number = angleInRaidans(_alpha);
var angleBInRadians:Number = angleInRaidans(_beta);
var angleCInRadians:Number = angleInRaidans(_gama);
var lengthOfSideA:Number = Math.sin(angleAInRadians) * _base_length / Math.sin(angleCInRadians);
var lengthOfSideB:Number = Math.sin(angleBInRadians) * _base_length / Math.sin(angleCInRadians);

var bSideEndX:Number = (lengthOfSideB * Math.cos(angleBInRadians))+ pos.x;
var bSideEndY:Number = (lengthOfSideB * Math.sin(angleBInRadians))+ pos.y;
var cSideEndX:Number = -(_base_length * Math.cos(angleCInRadians)) + pos.x;
var cSideEndY:Number = (_base_length * Math.sin(angleCInRadians)) + pos.y;
lineStyle(thickness, 0xFF0000, 1, true);
moveTo(pos.x, pos.y);
lineTo(bSideEndX, bSideEndY);

lineStyle(thickness, 0x0000FF);			
lineTo(cSideEndX, cSideEndY);
lineStyle(thickness, 0);

lineTo(pos.x, pos.y);				
*/