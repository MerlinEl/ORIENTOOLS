package orien.tools {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Rene
	 */
	public class mcTran {
		
		public function mcTran() {
		
		}
		
		/**
		 * Get or set object position in 2D
		 * @param	o1	object
		 * @param	o2	if (Point != null) move object at this Point(x, y) else return current position
		 * @return	object Point(x, y)
		 */
		public static function pos(o1:Object, o2:Object = null, centred:Boolean = false):Point {
			
			if (o2 == null) { //get pos
				
				return new Point(o1.x, o1.y);
				
			} else if (o2 is Object) { //set pos;
				
				if (centred) {

					var o_center:Point = getCenter(o1);
					var p1:Point = new Point(o1.x, o1.y);
					var p2:Point = new Point(o2.x, o2.y);
					p1.offset(-o_center.x, -o_center.y);
					p2.offset(p1.x, p1.y);
					o1.x = p2.x;
					o1.y = p2.y;
					
				} else {
				
					o1.x = o2.x;
					o1.y = o2.y;
				}
			}
			return new Point(o1.x, o1.y);
		}
		
		/**
		 * Get or set object position in 3D
		 * @param	o1	object
		 * @param	o2	if (Vector3D != null) move object at this Vector3D(x, y, z) else return current position
		 * @return	object Vector3D(x, y, z)
		 */
		public static function pos3d(o1:Object, o2:Object = null):Vector3D {
			
			if (o2 == null) { //get pos
				
				return new Vector3D(o1.x, o1.y, o1.z);
				
			} else if (o2 is Object) { //set pos;
				
				o1.x = o2.x;
				o1.y = o2.y;
				o1.z = o2.z;
				
			}
			return new Vector3D(o1.x, o1.y, o1.z);
		}
		
		
		static public function getCenter(obj:Object):Point {
			
			if (!obj.parent) {
				
				ftrace("Error: mcTran > getCenter > object:% has no parent.", obj);
				return new Point(obj.x, obj.y);
			}
			var bounds:Rectangle = obj.getBounds(obj.parent);
			var center_x:Number = bounds.x + bounds.width /2;
			var center_y:Number = bounds.y + bounds.height / 2;
			return new Point(center_x, center_y);
		}
		
		/**
		 * Get or set object scale
		 * @param	o	object
		 * @param	s	if (Point != null) scale object to this Point(x, y) else return current scale
		 * @return	object Point(scaleX, scaleY)
		 */
		public static function scale(o:Object, s:Point = null):Point {
			
			if (s == null) { //get scale
				
				return new Point(o.scaleX, o.scaleY);
				
			} else if (s is Point) { //set scale;
				
				o.scaleX = s.x;
				o.scaleY = s.y;
			}
			return s;
		}
		
		//not used
		public static function isNear(p1:Point, p2:Point, offset:Number):Boolean {
			
			var diff_x:Number = p1.x - p2.x;
			var diff_y:Number = p1.y - p2.y;
			return Math.abs(diff_x - diff_y) <= offset;
		}
		
		//not used
		public static function isOnPlace(p1:Point, p2:Point):Boolean {
			
			var diff_x:Number = p1.x - p2.x;
			var diff_y:Number = p1.y - p2.y;
			return diff_x == diff_y;
		}
		
		/**
		 * Fit one rectangle in to another proportionally
		 * @param	container
		 * @param	content
		 * @param	offset
		 */
		public static function fitToContainer(container:MovieClip, content:MovieClip, offset:Number = 0):void {
			
			var scale:Number = Math.min((container.width - offset) / content.width, (container.height - offset) / content.height);
			content.width *= scale;
			content.height *= scale;
		}
		
		/**
		 * Switch position between teo objects
		 * @param	obj_a Object A
		 * @param	obj_b Object B
		 */
		public static function swapPos(obj_a:*, obj_b:*):void {
			
			var temp_pos:Point = pos(obj_a);
			pos(obj_a, pos(obj_b));
			pos(obj_b, temp_pos);
		}
		
		/**
		 *Return mouseX mouseY as Point
		 * @param	o object from which we want mouse coordinates
		 * @return Point
		 */
		public static function mousePos(o:Object):Point {
			
			return new Point(o.mouseX, o.mouseY);
		}
		
		/**
		 * Get distance between two points
		 * distance = √ (x1 - x2)² + (y1 - y2)²
		 * @param	p1 first point
		 * @param	p2 second point
		 * @return	Number(distance)
		 */
		static public function twoPointsDistance(p1:Point, p2:Point):Number {
			
			var deltaX:Number = p1.x - p2.x;
			var deltaY:Number = p1.y - p2.y;
			return Math.sqrt(deltaX * deltaX + deltaY * deltaY);
		}
		
		static public function twoObjectsDistance(obj_a:DisplayObject, obj_b:DisplayObject, round:Number = -1):Number {
			
			var dist:Number = twoPointsDistance(pos(obj_a), pos(obj_b));
			return round == -1 ? dist : mcMath.toFixed(dist, round);
		}
		
		/**
		 * Gt angle between two points
		 * @param	p1
		 * @param	p2
		 * @return	angle in degrees
		 */
		static public function twoPointsAngle(p1:Point, p2:Point):Number {
			
			var deltaX:Number = p2.x - p1.x;
			var deltaY:Number = p2.y - p1.y;
			return radToDegrees(Math.atan2(deltaY, deltaX));
		}
		
		/**
		 * Get points center
		 * @param	points_array an array of points
		 * @return	center point
		 * @example var center:Point = pointsCenter([p1, p2, p3]);
		 */
		static public function pointsCenter(points_array:Array):Point {
			
			var total_x:Number = 0;
			var total_y:Number = 0;
			for each (var point:Point in points_array) {
				
				total_x += point.x;
				total_y += point.y;
			}
			return new Point(total_x / points_array.length, total_y / points_array.length);
		}
		
		/**
		 * Move an object to center of given points
		 * @param	obj
		 * @param	points_array
		 */
		static public function moveToPointsCenter(obj:DisplayObject, points_array:Array):void{
			
			var center:Point = pointsCenter(points_array);
			pos(obj, center);
		}
	
		/**
		 * Get closest point from points array by given point
		 * @param	points_arr array of points
		 * @param	point a Point from where we calculate distances
		 * @return	closest Point(x, y)
		 */
		static public function closestPoint(points_arr:Array, point:Point):Point {
			
			var arr:mcArray = new mcArray(points_arr);
			arr.sortByDistance(point);
			return Point(arr.getItemAt(0));
		}
		
		/**
		 * NOT TESTED
		 * Get closest object from object array by given point
		 * @param	obj_arr array of objects
		 * @param	point a Point from where we calculate distances
		 * @return	closest Point(x, y)
		 */
		/*static public function closestObject(obj_arr:Array, point:Point):* {
		
		   var arr:mcArray = new mcArray(obj_arr);
		   arr.sortByDistance(point);
		   return arr.getItemAt(0);
		   }*/
		
		/**
		 * Conver string in to Point Object
		 * @param	str must have point format: "(x=20, y=45)"
		 * @return	Point()
		 * @example  stringToPoint("(x=20, y=45)") return: Point(x=20, y=45)
		 */
		static public function stringToPoint(str:String):Point {
			
			if (!str || str.length < 9) return null;
			var x_start:int = str.indexOf("=") + 1;
			var x_end:int = str.indexOf(",");
			var y_start:int = str.lastIndexOf("=") + 1;
			var y_end:int = str.lastIndexOf(")");
			if (x_start == -1 || x_end == -1 || y_start == -1 || y_end == -1) return null;
			var x_str:String = str.substring(x_start, x_end);
			var y_str:String = str.substring(y_start, y_end);
			return new Point(Number(x_str), Number(y_str));
		}
		
		/**
		 * Scale object from given point
		 * @param	object Sprite, Movieclip or any display Object
		 * @param	absScale positive or negative scale number
		 * @param	AC Point(x, y)
		 */
		static public function scaleAroundPoint(obj:DisplayObject, absScale:Number, AC:Point):void {
			
			var relScale:Number = absScale / obj.scaleX;
			AC = obj.localToGlobal(AC);
			AC = obj.parent.globalToLocal(AC);
			var AB:Point = new Point(obj.x, obj.y);
			var CB:Point = AB.subtract(AC);
			CB.x *= relScale;
			CB.y *= relScale;
			AB = AC.add(CB);
			obj.scaleX *= relScale;
			obj.scaleY *= relScale;
			obj.x = AB.x;
			obj.y = AB.y;
		}
		
		/**
		 * @author Mark Ransom
		 * Scale object from mouse pointer
		 * @param	object Sprite or Movieclip
		 * @param	absScale positive or negative scale number
		 */
		static public function scaleAroundMousePoint(obj:DisplayObject, absScale:Number):void {
			
			var AC:Point = new Point(obj.mouseX, obj.mouseY);
			scaleAroundPoint(obj, absScale, AC);
		}
		
		/**
		 * There are 2.54 centimeters per inch;
		 * if it is sufficient to assume 96 pixels per inch
		 * @param	pixels
		 * @return
		 */
		static public function pixelsToCm(pixels:Number):Number {
			
			return pixels * 2.54 / 96;
		}
		
		static public function radToDegrees(radians:Number):Number {
			
			return radians * 180 / Math.PI;
		}
		
		static public function degToRadians(degrees:Number):Number {
			
			return degrees * Math.PI / 180;
		}
		
		/**
		 * Set object on top in parent children
		 * @param	obj Sprite, Shape, MovieClip... which is added in to stage.
		 */
		static public function setOnTop(obj:DisplayObject):void {
			
			var obj_parent:DisplayObjectContainer = obj.parent as DisplayObjectContainer;
			if (!obj_parent || obj_parent.numChildren < 2) return;
			obj_parent.setChildIndex(obj, obj_parent.numChildren - 1); // Set on top
		}
		
		static public function getZindex(obj:DisplayObject):int {
			
			var obj_parent:DisplayObjectContainer = obj.parent as DisplayObjectContainer;
			return obj_parent.getChildIndex(obj);
		}
		
		static public function setZindex(obj:DisplayObject, index:int):void {
			
			var obj_parent:DisplayObjectContainer = obj.parent as DisplayObjectContainer;
			if (!obj_parent || obj_parent.numChildren < index - 1) return;
			obj_parent.setChildIndex(obj, index);
		}
		
		/**
		 * Sort objects by Zindex from first to last one
		 * @param	arr objects array
		 */
		static public function sortZindexByOrder(arr:Array):void {
			
			var obj_parent:DisplayObjectContainer = arr[0].parent as DisplayObjectContainer;
			if (!obj_parent || obj_parent.numChildren < index - 1) return;
			var index:int = obj_parent.numChildren - 1; //get top level index
			for each (var obj:DisplayObject in arr){
				
				obj_parent.setChildIndex(obj, index);
				index--;
			}
		}
		
		/**
		 * Set object to desired zIndex
		 * @param	obj Sprite, Shape, MovieClip... which is added in to stage.
		 */
		static public function setZindexTo(obj:DisplayObject, type:String):void {
			
			var obj_parent:DisplayObjectContainer = obj.parent as DisplayObjectContainer;
			if (!obj_parent || obj_parent.numChildren < 2) return;
			var current_depth:int = obj_parent.getChildIndex(obj);
			
			switch (type) {
			
			case "top": 
				obj_parent.setChildIndex(obj, obj_parent.numChildren - 1);
				break;
			case "bottom": 
				obj_parent.setChildIndex(obj, 0);
				break;
			case "forward": 
				if (current_depth < obj_parent.numChildren - 1) obj_parent.setChildIndex(obj, current_depth + 1);
				break;
			case "backward": 
				if (current_depth > 0) obj_parent.setChildIndex(obj, current_depth - 1);
				break;
			case "penultimate": 
				obj_parent.setChildIndex(obj, obj_parent.numChildren - 2);
				break; // Set near top 
			}
		
		}
		
		static public function getRect(obj:DisplayObject):Rectangle {
			
			return new Rectangle(obj.x, obj.y, obj.width, obj.height);
		}
		
		static public function isInRect(p:Point, rect:Rectangle):Boolean {
			
			return rect.contains(p.x, p.y);
		}
		
		static public function rectDiagonal(w:Number, h:Number, round:int = -1):Number {
			
			var diagonal:Number = Math.sqrt(Math.pow(w, 2) + Math.pow(h, 2));
			return round == -1 ? diagonal : mcMath.toFixed(diagonal, round);
		}
		
		/**
		 * Draw virtual line with given [Angle], [Length] and [Start Position]
		 * @param	pos_start
		 * @param	angle
		 * @param	len
		 * @return	end of line as Point
		 */
		static public function lineEnd(pos_start:Point, angle:int, len:Number):Point {
			
			var angle_rad:Number = degToRadians(angle);
			var pos_end:Point = new Point();
			pos_end.x = (len * Math.cos(angle_rad)) + pos_start.x;
			pos_end.y = (len * Math.sin(angle_rad)) + pos_start.y;
			return pos_end;
		}
		
		
		static public function getAngleBetweenTwoPoints(p1:Point, p2:Point):int {
			
			return Math.abs(Math.atan2((p1.x - p2.x), (p1.y - p2.y))) * (180 / Math.PI);
		}
		
		/**
		 * Not Used must be tested TODO
		 * Get inverted mid vector between three points (two vectors which have common p3)
		 * @param	p1
		 * @param	p2
		 * @param	p3
		 * @return
		 */
		/*static public function getTrixel(p1:Point, p2:Point, p3:Point):mcVector2D {
			
			var p:Point = new Point(p1.x + p2.x / 2, p1.y + p2.y / 2);
			return new mcVector2D(p3, p);
		}*/
		
		static public function rotateAroundCenter(obj:DisplayObject, angle_degrees:Number):void {
   
			if (obj.rotation == angle_degrees) return;
			
			var matrix:Matrix = obj.transform.matrix;
			var rect:Rectangle = obj.getBounds(obj.parent);
			
			matrix.translate(-(rect.left + (rect.width / 2)), -(rect.top + (rect.height / 2)));
			matrix.rotate((angle_degrees / 180) * Math.PI);
			matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
			obj.transform.matrix = matrix;
			
			obj.rotation = Math.round(obj.rotation);
		}
	}
}


/** VYRAZENO
 * 
static public function rotateAroundCenter(obj:DisplayObject, angle_degrees:Number):void {
	
	if (obj.rotation == angle_degrees) {
		return;
	}
	var point:Point=new Point(obj.x+obj.width/2, obj.y+obj.height/2);
	var m:Matrix=obj.transform.matrix;
	m.tx -= point.x;
	m.ty -= point.y;
	m.rotate (angle_degrees*(Math.PI/180));
	m.tx += point.x;
	m.ty += point.y;
	obj.transform.matrix = m;
}
*/