package orien.tools {
	
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Draw Splines or Shapes ?
	 * @author Alex Hannigan
	 * @author René Bača (Orien) 2015
	 *
	 *
	 */
	public class mcDraw {
		
		private static var default_color:Number = 0x0EF152;
		private static var default_alpha:Number = 1;
		
		public function mcDraw() {
			
			throw new ArgumentError("The DrawingShapes Class cannot be instanicated.");
		}
		
		/**
		 * Draw Rectangle from top-left
		 * @param	gra	Graphics
		 * @param	x	pos_x
		 * @param	y	pos_y
		 * @param	width Number
		 * @param	height Number
		 * @param	color uint
		 * @param	alpha Number 0 - 1
		 */
		public static function drawRectangle(gra:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint, alpha:Number = 1, params:Object = null):void {
			
			
			if (mcObject.pick(params, "centred", false)) {
				x -= width / 2;
				y -= height / 2;
			}
			if (mcObject.pick(params, "border", false)) {
				
				gra.lineStyle(
				
					mcObject.pick(params, "thickness", 1),
					mcObject.pick(params, "border_color", 0x000000),
					mcObject.pick(params, "alpha", 1)
				);
			}
			gra.beginFill(color, alpha);
			if (mcObject.pick(params, "round", false)){
			
				gra.drawRoundRect(x, y, width, height, 
				
					mcObject.pick(params, "corner_w", 4),
					mcObject.pick(params, "corner_h", 4)
				);
			} else {
				
				gra.drawRect(x, y, width, height);	
			}
			gra.endFill();
		}
		
		public static function drawRectangleBorder(gra:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint, thckness:int):void {
			
			gra.lineStyle(thckness, color);
			gra.drawRect(x, y, width, height);
			gra.endFill();
		}
		
		/**
		 * Draw Circle from top-left
		 * @param	gra	Graphics
		 * @param	x	pos_x
		 * @param	y	pos_y
		 * @param	radius Number
		 * @param	color uint
		 * @param	alpha Number 0 - 1
		 */
		static public function drawCircle(gra:Graphics, x:Number, y:Number, radius:Number, color:uint, alpha:Number = 1, centred:Boolean = true):void {
			
			if (!centred) {
				x += radius;
				y += radius;
			}
			gra.beginFill(color, alpha);
			gra.drawCircle(x, y, radius);
			gra.endFill();
		}
		
		/**
		 * Draw Arc around center with given start_angle and arc_angle
		 * @example	mcDraw.drawArc(graphics, p3, arc_radius, start_angle, vectors_angle);
		 * @param	gra	Graphics
		 * @param	center	Point(x, y)
		 * @param	radius	Arc radius
		 * @param	start_angle
		 * @param	arc_angle
		 * @param	steps	how many segments will be used to draw Arc
		 * @param	params	optional parameters {steps, thickness, border_color, fill_color, fill:Bolean}
		 */
		static public function drawArc(gra:Graphics, center:Point, radius:Number, start_angle:Number, arc_angle:Number, params:Object = null) {
	
			var twoPI = 2 * Math.PI;
			var steps:int = mcObject.pick(params, "steps", 20); 
			var angleStep = (arc_angle / 360) / steps;
			var xx = center.x + Math.cos(start_angle * twoPI) * radius;
			var yy = center.y + Math.sin(start_angle * twoPI) * radius;
			gra.lineStyle(
			
				mcObject.pick(params, "thickness", 1), 
				mcObject.pick(params, "border_color", 0x0049A4)
			);
			gra.moveTo(xx, yy);
			for (var i = 1; i <= steps; i++) {
				var angle = start_angle + i * angleStep;
				xx = center.x + Math.cos(angle * twoPI) * radius;
				yy = center.y + Math.sin(angle * twoPI) * radius;
				gra.lineTo(xx, yy);
			}
		}
		
		/**
		 * Draw Elipse from top-left
		 * @param	gra	Graphics
		 * @param	x	pos_x
		 * @param	y	pos_y
		 * @param	width Number
		 * @param	height Number
		 * @param	color uint
		 * @param	alpha Number 0 - 1
		 */
		static public function drawElipse(gra:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint, alpha:Number = 1, centred:Boolean = true):void {
			
			if (centred) {
				x -= width / 2;
				y -= height / 2;
			}
			gra.beginFill(color, alpha);
			gra.drawEllipse(x, y, width, height);
			gra.endFill();
		}
		
		/**
		 * Draw Diamond from top-left
		 * @param	gra	Graphics
		 * @param	x	pos_x
		 * @param	y	pos_y
		 * @param	width Number
		 * @param	height Number
		 * @param	color uint
		 * @param	alpha Number 0 - 1
		 */
		static public function drawDiamond(gra:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint, alpha:Number = 1, centred:Boolean = true):void {
			
			if (!centred) {
				x += width / 2;
				y += height / 2;
			}
			gra.beginFill(color, alpha);
			gra.moveTo(x - width / 2, y);
			gra.lineTo(x, y - height / 2);
			gra.lineTo(x + width / 2, y);
			gra.lineTo(x, y + height / 2);
			gra.endFill();
		}
		
		/**
		 * Need to finish cetntred part
		 * @param	gra
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 * @param	color
		 * @param	alpha
		 * @param	centred
		 * @param	way
		 */
		static public function drawTriangle(gra:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint, alpha:Number = 1, centred:Boolean = true, way:String = "top"):void {
			
			var tri:mcTriangle = new mcTriangle(x, y, width, height);
			if (centred) tri.move(-width / 2, height / 2); //move to center
			tri.pointAt(way);
			gra.beginFill(color, alpha);
			gra.drawTriangles(tri.verts);
			gra.endFill();
		}
		
		/**
		 *
		 * @param	gra
		 * @param	points Array of point coordinates (x0, y0, x1, y1, .. xN, yN)
		 * @param	params Object {fill_color:uint, border_color:uint, alpha:Number, thickness:int, border:Boolean}
		 */
		//color:uint, alpha:Number = 1, border:Object = {}
		static public function drawShape(gra:Graphics, points:Vector.<Point>, params:Object = null):void {
			
			gra.beginFill(
				mcObject.pick(params, "fill_color", 0xC0C0C0), 
				mcObject.pick(params, "alpha", 1)
			);
			if (mcObject.pick(params, "border", false)) {
				
				gra.lineStyle(
					mcObject.pick(params, "thickness", 1), 
					mcObject.pick(params, "border_color", 0x000000),
					mcObject.pick(params, "alpha", 1)
				);
			}
			for (var i:int = 0; i < points.length; ++i) {
				if (i == 0) {
					gra.moveTo(points[i].x, points[i].y);
				} else {
					gra.lineTo(points[i].x, points[i].y);
				}
			}
			gra.endFill();
		}
		
		static public function drawLine(gra:Graphics, points:Vector.<Point>, params:Object = null):void {
			
			gra.lineStyle(
				mcObject.pick(params, "thickness", 1), 
				mcObject.pick(params, "color", 0x000000), 
				mcObject.pick(params, "alpha", 1)
			);
			for (var i:int = 0; i < points.length; ++i) {
				if (i == 0) {
					gra.moveTo(points[i].x, points[i].y);
				} else {
					gra.lineTo(points[i].x, points[i].y);
				}
			}
			gra.endFill();
		}
		
		/**
		* Draw Line by given angle, length and position
		*/
		static public function drawLinePAL(gra:Graphics, pos_start:Point, angle:int, len:Number, clr:uint = 0xF028E1):void {
			
			//ftrace("Draw line > pos:% angle:% len:% clr:%", pos_start, angle, len, clr);
			gra.lineStyle(1.5, clr, 1, true);
			gra.moveTo(pos_start.x, pos_start.y);
			var pos_end:Point = mcTran.lineEnd(pos_start, angle, len);
			gra.lineTo(pos_end.x, pos_end.y);
		}
	}
}
