package orien.tools {
	
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * This class is not used
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
		 * @param	gr	Graphics
		 * @param	x	pos_x
		 * @param	y	pos_y
		 * @param	width Number
		 * @param	height Number
		 * @param	color uint
		 * @param	alpha Number 0 - 1
		 */
		public static function drawRectangle(gr:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint, alpha:Number = 1, centred:Boolean = true):void {
			
			if (centred) {
				x -= width / 2;
				y -= height / 2;
			}
			gr.beginFill(color, alpha);
			gr.drawRect(x, y, width, height);
			gr.endFill();
		}
		
		/**
		 * Draw Circle from top-left
		 * @param	gr	Graphics
		 * @param	x	pos_x
		 * @param	y	pos_y
		 * @param	radius Number
		 * @param	color uint
		 * @param	alpha Number 0 - 1
		 */
		static public function drawCircle(gr:Graphics, x:Number, y:Number, radius:Number, color:uint, alpha:Number = 1, centred:Boolean = true):void {
			
			if (!centred) {
				x += radius;
				y += radius;
			}
			gr.beginFill(color, alpha);
			gr.drawCircle(x, y, radius);
			gr.endFill();
		}
		
		/**
		 * Draw Elipse from top-left
		 * @param	gr	Graphics
		 * @param	x	pos_x
		 * @param	y	pos_y
		 * @param	width Number
		 * @param	height Number
		 * @param	color uint
		 * @param	alpha Number 0 - 1
		 */
		static public function drawElipse(gr:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint, alpha:Number = 1, centred:Boolean = true):void {
			
			if (centred) {
				x -= width / 2;
				y -= height / 2;
			}
			gr.beginFill(color, alpha);
			gr.drawEllipse(x, y, width, height);
			gr.endFill();
		}
		
		/**
		 * Draw Diamond from top-left
		 * @param	gr	Graphics
		 * @param	x	pos_x
		 * @param	y	pos_y
		 * @param	width Number
		 * @param	height Number
		 * @param	color uint
		 * @param	alpha Number 0 - 1
		 */
		static public function drawDiamond(gr:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint, alpha:Number = 1, centred:Boolean = true):void {
			
			if (!centred) {
				x += width / 2;
				y += height / 2;
			}
			gr.beginFill(color, alpha);
			gr.moveTo(x - width / 2, y);
			gr.lineTo(x, y - height / 2);
			gr.lineTo(x + width / 2, y);
			gr.lineTo(x, y + height / 2);
			gr.endFill();
		}
		/**
		 * Need to finish cetntred part
		 * @param	gr
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 * @param	color
		 * @param	alpha
		 * @param	centred
		 * @param	way
		 */
		static public function drawTriangle(gr:Graphics,  x:Number, y:Number, width:Number, height:Number, color:uint, alpha:Number = 1, centred:Boolean = true, way:String = "top"):void {
			
			var tri:mcTriangle = new mcTriangle(x, y, width, height);
			if (centred) tri.move(-width / 2, height / 2); //move to center
			tri.pointAt(way);
			gr.beginFill(color, alpha);
			gr.drawTriangles(tri.verts);
			gr.endFill();
		}
	}
}
