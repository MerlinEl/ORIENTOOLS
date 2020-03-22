package orien.tools {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class mcCollisions {
		
		static public function bitmapStroke(stroke_a:*, stroke_b:*, alphaOffset:Number = 255):Boolean { //PaintPngStroke
			
			var p:Point = new Point(0, 0);
			return (stroke_a.bitmapData.hitTest(p, alphaOffset, stroke_b.bitmapData, p, alphaOffset));
		}
		
		/**
		 * Simple collision test. Use this for objects that are not rotated.
		 * @param	obj_a	Takes DisplayObjectContainer as argument. Can be a Sprite, MovieClip, etc.
		 * @param	obj_b	Takes DisplayObjectContainer as argument. Can be a Sprite, MovieClip, etc.
		 * @return	Collision True/False
		 */
		static public function simple(obj_a:DisplayObjectContainer, obj_b:DisplayObjectContainer):Boolean {
			
			var result = false;
			
			//draw obj_a content in to bitmap data
			var rect_a:Rectangle = obj_a.getBounds(obj_a);
			var bdata_a = new BitmapData(rect_a.width, rect_a.height, true, 0);
			bdata_a.draw(obj_a);
			
			//draw obj_b content in to bitmap data
			var rect_b:Rectangle = obj_b.getBounds(obj_b);
			var bdata_b = new BitmapData(rect_b.width, rect_b.height, true, 0);
			bdata_b.draw(obj_b);
			
			//now detect collisions
			var p1:Point = new Point(obj_a.x, obj_a.y);
			var p2:Point = new Point(obj_b.x, obj_b.y);
			
			if (bdata_a.hitTest(p1, 255, bdata_b, p2, 255)) {
				
				result = true;
			}
			
			bdata_b.dispose();
			bdata_a.dispose();
			
			return result;
		}
		
		/**
		 * Complex collision test. Use this for objects that are rotated, scaled, skewed, etc
		 * @param	obj_a	Takes DisplayObjectContainer as argument. Can be a Sprite, MovieClip, etc.
		 * @param	obj_b	Takes DisplayObjectContainer as argument. Can be a Sprite, MovieClip, etc.
		 * @return	Collision True/False
		 */
		static public function complex(obj_a:DisplayObjectContainer, obj_b:DisplayObjectContainer):Boolean {
			
			var result = false;
			
			var rect_b:Rectangle = obj_a.getBounds(obj_a);
			var offset1:Matrix = obj_a.transform.matrix;
			offset1.tx = obj_a.x - obj_b.x;
			offset1.ty = obj_a.y - obj_b.y;
			
			var bdata_b:BitmapData = new BitmapData(rect_b.width, rect_b.height, true, 0);
			bdata_b.draw(obj_a, offset1);
			
			var rect_a:Rectangle = obj_b.getBounds(obj_b);
			var bdata_a:BitmapData = new BitmapData(rect_a.width, rect_a.height, true, 0);
			
			var offset2:Matrix = obj_b.transform.matrix;
			offset2.tx = obj_b.x - obj_b.x;
			offset2.ty = obj_b.y - obj_b.y;
			
			bdata_a.draw(obj_b, offset2);
			
			var p1:Point = new Point(rect_a.x, rect_a.y);
			var p2:Point = new Point(rect_b.x, rect_b.y);

			if (bdata_a.hitTest(p1, 255, bdata_b, p2, 255)) {
				result = true;
			}
			
			bdata_b.dispose();
			bdata_a.dispose();
			
			return result;
		}
		
		static public function pointPixel(obj_a:DisplayObjectContainer, obj_b:DisplayObjectContainer):Boolean {
			
			//X,Y represents a point in space
			return (obj_a.hitTestPoint(obj_b.x, obj_b.y, true)) //actual pixels of the object (true) or the bounding box (false).
		}
		
		static public function pointObject(obj_a:DisplayObjectContainer, obj_b:DisplayObjectContainer):Boolean {
			
			//X,Y represents a point in space
			return (obj_a.hitTestPoint(obj_b.x, obj_b.y, false)) //actual pixels of the object (true) or the bounding box (false).
		}
		
		static public function objects(obj_a:DisplayObjectContainer, obj_b:DisplayObjectContainer):Boolean {
			
			return (obj_a.hitTestObject(obj_b));
		}
		
		/**
		 * Check collision based on internal hit cage in each object <("avoid flipped sprites")>
	posible solution to add in mcBitmapData 
	var bounds1:Rectangle = image1.getBounds(this);
    var bounds2:Rectangle = image2.getBounds(this);
		 * @param	obj_a
		 * @param	obj_b
		 * @param	hit	name of children object which define hit area
		 * @return
		 */
		static public function byObjectHit(obj_a:DisplayObjectContainer, obj_b:DisplayObjectContainer, hit:String):Boolean{
	
			var result:Boolean = false;
			
			//get object hit bitmapData
			var bdata_a:BitmapData = mcBitmapData.fromObject(obj_a[hit]);
			var bdata_b:BitmapData = mcBitmapData.fromObject(obj_b[hit]);	
			//now detect collisions
			var p1:Point = new Point(obj_a.x, obj_a.y);
			var p2:Point = new Point(obj_b.x, obj_b.y);
			//offset point to hit object
			p1.x += obj_a[hit].x
			p1.y += obj_a[hit].y
			p2.x += obj_b[hit].x
			p2.y += obj_b[hit].y
			//collision test
			if (bdata_a.hitTest(p1, 255, bdata_b, p2, 255)) {
			
				result = true;
			}
			//remove ditmapData from memory
			bdata_b.dispose();
			bdata_a.dispose();
			
			return result;
		}

		/**
		 * NOT USED
		 * @param	obj_a
		 * @param	obj_b
		 * @param	hit
		 * @return
		 */
		static public function hitIntersection(obj_a:DisplayObjectContainer, obj_b:DisplayObjectContainer, hit:String):Boolean{
			var b1:Rectangle = obj_a.getBounds(obj_a[hit]);
			var b2:Rectangle = obj_b.getBounds(obj_a[hit]);
			return (b1.intersects(b2));
		}

		/**
		 * NOT USED
		 * @param	obj_a
		 * @param	obj_b
		 * @return
		 */
		static public function intersection(obj_a:DisplayObjectContainer, obj_b:DisplayObjectContainer):Boolean{
			var b1:Rectangle = obj_a.getBounds(obj_a);
			var b2:Rectangle = obj_b.getBounds(obj_a);
			return (b1.intersects(b2));
		}
	}
}