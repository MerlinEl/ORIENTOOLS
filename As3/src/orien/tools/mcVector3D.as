package orien.tools { //NOT USED
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/** 
	 * ...
	 * @author René Bača (Orien) 2018
	 */
	public class mcVector3D extends Vector3D{
		
		/**
		 * constructor mcVector3D
		 */
		public function mcVector3D(x:Number=0, y:Number=0, z:Number=0, w:Number=0) {
			super(x, y, z, w);	
		}
		
		/**
		 * draws a vector in a given mc using a given color
		 * @param	mc|movieClipReference color|hexNumber
		 */
		public function draw(graphics:Graphics, startPoint:mcPoint3D = null, thickness:Number = 1, opacity:Number = 1):void {
			
			//draw three vector lines X:R Z:G Y:B
			var start:mcPoint3D = startPoint ? startPoint : new mcPoint3D();
			var end:mcPoint3D = new mcPoint3D(x, y, z);
			end.x += start.x;
			end.y += start.y;
			end.z += start.z;
			//draw vector x
			//draw vector y
			//draw vector z
			//Not winished maybe bad way......
			graphics.lineStyle(thickness, 0xFF0000, opacity, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
			graphics.moveTo(start.x, start.y);
			graphics.lineTo(end.x, end.y);
			//draw arrow head
			var head_angle:Number = polarAngle(new Point(end.x, end.y), new Point(start.x, start.y));
			var head_length:Number = 10;
			var handles_angle:Number = 30; //45
            graphics.moveTo(end.x - (head_length * Math.cos((head_angle - handles_angle) * Math.PI / 180)),
                     end.y - (head_length * Math.sin((head_angle - handles_angle) * Math.PI / 180)));
            graphics.lineTo(end.x + (thickness * Math.cos((head_angle) * Math.PI / 180)),
                     end.y + (thickness * Math.sin((head_angle) * Math.PI / 180)));
            graphics.lineTo(end.x - (head_length * Math.cos((head_angle + handles_angle) * Math.PI / 180)),
                     end.y - (head_length * Math.sin((head_angle + handles_angle) * Math.PI / 180)));
		}

		/**
		 * Automatically used when trace
		 */
		/*public function toString():String {
			
			return "{object mcVector3D(dirX:" + dirX + ", dirY:" + dirY +, "dirZ:" + dirZ + ")}";
		}*/
	}
}