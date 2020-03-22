/***************************************************************************************************************
   mcVector2D Class For Actionscript 3.0
   ---------------------------------------------------------------------------------------------------------------
   method listing:
   state-altering methods:
   mcVector2D(x, y)    - create vector and set the components to x and y
   mcVector2D(v)     - create vector and set the components to the components of vector v
   set(x, y)     - set the components to x and y
   set(v)        - set the components to the components of vector v
   plus(v1 ... vn)   - add the components of the given vectors to the components of the vector
   minus(v1 ... vn)  - subtract the components of given vectors from the components of the vector
   times(x, y)     - multiply the components of vector by x and y
   times(scalar)   - multiply the components of vector by number scalar
   times(v)      - multiply the components of vector by the components of vector v
   invert()      - invert (or reverse) the vector
   project(v)      - set the vector to be the projection of the vector onto vector v
   reflect(v)      - reflect the vector over vector v
   rotate(a)     - rotate the vector by angle a in degrees
   swap(v)       - swap the components of the vector and vector v (note: also alters vector v)
   state-safe methods:
   getLeftNormal()   - return a new vector which is left hand normal to the vector
   getRightNormal()  - return a new vector which is right hand normal to the vector
   cross(v)      - return the magnitude of the cross product of the vector and vector v
   dot(v)        - return the dot product of the vector and vector v
   angleBetween(v)   - return the angle between the vector and vector v
   angleBetweenCos(v)  - return the cosine of the angle between the vector and vector v
   angleBetweenSin(v)  - return the sine of the angle between the vector and vector v
   comparison methods:
   isEqualTo(v)    - test for equality between the vector and vector v
   isNormalTo(v)   - test for normality between the vector and vector v
   utility methods:
   paint(mc, color)  - draw vector in given movieclip using a given color
   private methods:
   fixNumber()     - convert all inputs to a number of fixed precision
   toString()      - override of built in method to provide meaningful output
   property listing:
   x     - virtual property representing the current x component of the vector  (get/set)
   y     - virtual property representing the current y component of the vector  (get/set)
   angle   - virtual property representing the current degree angle of the vector (get/set)
   magnitude - virtual property representing the current magnitude of the vector    (get/set)

   Feel free to use this code as you wish, Have Fun!
   Please send bug reports && ( gripes || praise ) to nick[at]zambetti[dot]com
 ***************************************************************************************************************/
package orien.tools {
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Nicholas Zambetti 2003
	 * @modify René Bača (Orien) 2016
	 */
	public class mcVector2D {
		
		//instance properties
		private var dirX:Number = 0;
		private var dirY:Number = 0;

		/**
		 * constructor mcVector2D
		 * @example	
		 * var v1:mcVector2D = new mcVector2D(p1, center, 10, p3); 
		 * @param	... args[]
		 * 0 > Point(p1) or Number(dirX)	: 
		 * 1 > Point(p2) or Number(dirY)	: 
		 * 2 > Number(10) 					: length of vector
		 * 3 > Point(p3) 					: start pos	
		 */
		public function mcVector2D(... args) {
			
			if (args.length == 0) {
			
				dirX = 0;
				dirY = 0;
				
			} else if (args.length >= 2) {
				
				if (args[0] is Point && args[1] is Point){ // two points were pasted (build vector a - b)
					
					dirX = args[0].x - args[1].x, 
					dirY = args[0].y - args[1].y;
				} else { // x and y were passed
					
					dirX = fixNumber(args[0]);
					dirY = fixNumber(args[1]);
				}
				if (args.length > 2 && args[2]) length = args[2]; //set vector length
				if (args.length > 3 && args[3]) moveTo(args[3]); //move vector to pos
			}
		}
		
		/**
		 * sets the properties of the vector
		 * @param	x:Number, y:Number || v:mcVector2D
		 * @return	reference to the vector
		 */
		public function set(... args):mcVector2D {
			
			dirX = 0;
			dirY = 0;
			
			if (2 == args.length) {
				// x and y were passed
				dirX = fixNumber(args[0]);
				dirY = fixNumber(args[1]);
			} else if (1 == args.length) {
				if (args[0] is mcVector2D) {
					// an existing vector was passed
					dirX = args[0].x;
					dirY = args[0].y;
				}
			}
			return this;
		}
		
		/**
		 * adds given vectors to the vector
		 * @param	v1:mcVector2D ... vn;mcVector2D
		 * @return	reference to the vector
		 */
		public function plus(... args):mcVector2D {
			
			for (var i = 0; i < args.length; ++i) {
				if (args[i] is mcVector2D) {
					dirX += args[i].dirX;
					dirY += args[i].dirY;
				}
			}
			dirX = fixNumber(dirX);
			dirY = fixNumber(dirY);
			return this;
		}
		
		/**
		 * subtracts given vectors from the vector
		 * @param	v1:mcVector2D ... vn:mcVector2D
		 * @return	reference to the vector
		 */
		public function minus(... args):mcVector2D {
			
			for (var i = 0; i < args.length; ++i) {
				if (args[i] is mcVector2D) {
					dirX -= args[i].dirX;
					dirY -= args[i].dirY;
				}
			}
			dirX = fixNumber(dirX);
			dirY = fixNumber(dirY);
			return this;
		}
		
		/**
		 * multiplies the components by the x and y args or by the given vector
		 * @param	x:number, y:number || scalar:number || v:mcVector2D
		 * @return	reference to the vector
		 */
		public function times(... args):mcVector2D {
			
			if (1 == args.length) {
				if (args[0] is mcVector2D) {
					dirX *= args[0].dirX;
					dirY *= args[0].dirY;
				} else {
					if (isNaN(Number(args[0]))) {
						dirX = dirY = 0;
					} else {
						dirX *= Number(args[0]);
						dirY *= Number(args[0]);
					}
				}
			} else if (2 == args.length) {
				isNaN(Number(args[0])) ? dirX = 0 : dirX *= Number(args[0]);
				isNaN(Number(args[1])) ? dirY = 0 : dirY *= Number(args[1]);
			}
			dirX = fixNumber(dirX);
			dirY = fixNumber(dirY);
			return this;
		}
		
		/**
		 * rotates the vector by the given angle (in degrees)
		 * @param	rotationAngle:Number
		 * @return	reference to the vector
		 */
		public function rotate(rotationAngle:Number):mcVector2D {
			
			if (isNaN(Number(rotationAngle))) {
				return this;
			}
			var currentLength:Number = Math.sqrt(Math.pow(dirX, 2) + Math.pow(dirY, 2));
			var newAngleRadians:Number = ((Math.atan2(dirY, dirX) * (180 / Math.PI)) + Number(rotationAngle)) * (Math.PI / 180);
			dirX = fixNumber(currentLength * Math.cos(newAngleRadians));
			dirY = fixNumber(currentLength * Math.sin(newAngleRadians));
			return this;
		}
		
		/*public function rotate(angleInRadians:Number):mcVector2D {
			
			var newPosX:Number = (dirX * Math.cos(angleInRadians)) - (dirY * Math.sin(angleInRadians));
			var newPosY:Number = (dirX * Math.sin(angleInRadians)) + (dirY * Math.cos(angleInRadians));
			dirX = newPosX;
			dirY = newPosY;
			return this;
		}*/
		
		/**
		 * inverts the vector
		 * @param	none
		 * @return	reference to the vector
		 */
		public function invert():mcVector2D {
			
			dirX *= -1;
			dirY *= -1;
			return this;
		}
		
		public function clone():mcVector2D{
			
			return new mcVector2D(dirX, dirY);
		}
		
		/**
		 * projects the vector onto vector v
		 * @param	v:mcVector2D
		 * @return	reference to the vector
		 */
		public function project(v:mcVector2D):mcVector2D {
			
			if (v is mcVector2D) {
				var scalar:Number = dot(v) / Math.pow(v.length, 2);
				set(v);
				times(scalar);
			}
			return this;
		}
		
		/**
		 * relects the vector over vector v
		 * @param	v:mcVector2D
		 * @return	reference to the vector
		 */
		public function reflect(v:mcVector2D):mcVector2D {
			
			if (v is mcVector2D) {
				var vAfterHorizReflect:mcVector2D = new mcVector2D(v.dirY, -v.dirX);
				var rotationAngle:Number = 2 * angleBetween(v);
				if (0 >= angleBetweenCos(vAfterHorizReflect)) {
					rotationAngle *= -1;
				}
				rotate(rotationAngle);
			}
			return this;
		}
		
		/**
		 * calculates the dot product of the vector and vector v
		 * @param	v:mcVector2D
		 * @return	number
		 */
		public function dot(v:mcVector2D):Number {
			
			if (v is mcVector2D) {
				return fixNumber((dirX * v.dirX) + (dirY * v.dirY));
			}
			return 0;
		}
		
		/**
		 * calculates the cross product of the vector and vector v
		 * @param	v:mcVector2D
		 * @return	number (representing the length of the theoretical vector result)
		 */
		public function cross(v:mcVector2D):Number {
			
			if (v is mcVector2D) {
				return Math.abs(fixNumber((dirX * v.dirY) - (dirY * v.dirX)));
			}
			return 0;
		}
		
		/**
		 * calculates the the angle between the vector and vector v in degrees
		 * @param	v:mcVector2D
		 * @return	number
		 */
		public function angleBetween(v:mcVector2D):Number {

			if (v is mcVector2D) {				
				return fixNumber(Math.acos(dot(v) / (length * v.length)) * (180 / Math.PI));
			}
			return 0;
		}

		/**
		 * calculates the sine of the angle between the vector and vector v
		 * @param	v:mcVector2D
		 * @return	number
		 */
		public function angleBetweenSin(v:mcVector2D):Number {
			
			if (v is mcVector2D) {
				return fixNumber(cross(v) / (length * v.length));
			}
			return 0;
		}
		
		/**
		 * calculates the cosine of the angle between the vector and vector v
		 * @param	v:mcVector2D
		 * @return	number
		 */
		public function angleBetweenCos(v:mcVector2D):Number {
			
			if (v is mcVector2D) {
				return fixNumber(dot(v) / (length * v.length));
			}
			return 0;
		}
		
		/**
		 * exchanges data of the vector and the given vector
		 * @param	v:mcVector2D
		 * @return	reference to the vector
		 */
		public function swap(v:mcVector2D):mcVector2D {
			
			if (v is mcVector2D) {
				var tempX:Number = dirX;
				var tempY:Number = dirY;
				dirX = v.dirX;
				dirY = v.dirY;
				v.dirX = tempX;
				v.dirY = tempY;
			}
			return this;
		}
		
		/**
		 * creates a new vector which is normal (clockwise) to the vector
		 * @param	none
		 * @return	reference to the newly created vector
		 */
		public function getRightNormal():mcVector2D {
			
			return new mcVector2D(dirY, -dirX);
		}
		
		/**
		 * creates a new vector which is normal (anti-clockwise) to the vector
		 * @param	none
		 * @return	reference to the newly created vector
		 */
		public function getLeftNormal():mcVector2D {
			
			return new mcVector2D(-dirY, dirX);
		}
		
		/**
		 * tests if two vectors are normal to each other
		 * @param	v:mcVector2D
		 * @return	boolean indicating normality
		 */
		public function isNormalTo(v:mcVector2D):Boolean {
			
			if (v is mcVector2D) {
				return (dot(v) === 0);
			} else {
				return false;
			}
		}
		
		/**
		 * tests if two vectors are equal to each other
		 * @param	v:mcVector2D
		 * @return	boolean indicating equality
		 */
		public function isEqualTo(v:mcVector2D):Boolean {
			
			if (v is mcVector2D) {
				if ((dirX === v.dirX) && (dirY === v.dirY)) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * retrieves the current x value of the vector
		 * @param	none
		 * @return	current value of x
		 */
		public function get x():Number {
			
			return dirX;
		}
		
		/**
		 * sets x value of the vector
		 * @param	newX:Number
		 * @return	value of x BEFORE precision fix
		
		 */
		public function set x(newX:Number):void {
			
			dirX = fixNumber(newX);
		}
		
		/**
		 * retrieves the current y value of the vector
		 * @param	none
		 * @return	current value of y
		 */
		public function get y():Number {
			
			return dirY;
		}
		
		/**
		 * sets y value of the vector
		 * @param	newY:Number
		 * @return	value of y BEFORE precision fix
		 */
		public function set y(newY:Number):void {
			
			dirY = fixNumber(newY);
		}
		
		/**
		 * calculates the angle of the vector
		 * @param	none
		 * @return	number representing angle in degrees
		 */
		public function get angle():Number {
			
			return fixNumber(Math.atan2(dirY, dirX) * (180 / Math.PI));
			//return fixNumber(((Math.atan2(dirY, dirX)*(180/Math.PI))+360)%360);
		}
		
		/**
		 * sets the angle of the vector to the given angle (in degrees)
		 * @param	newAngle:Number
		 * @return	number representing angle in degrees BEFORE precision fix
		 */
		public function set angle(newAngle:Number):void {
			
			var angleRadians:Number = 0;
			if (!isNaN(Number(newAngle))) {
				angleRadians = Number(newAngle) * (Math.PI / 180);
			}
			var currentLength:Number = Math.sqrt(Math.pow(dirX, 2) + Math.pow(dirY, 2));
			dirX = fixNumber(currentLength * Math.cos(angleRadians));
			dirY = fixNumber(currentLength * Math.sin(angleRadians));
		}
		
		/**
		 * returns the length (magnitude) of the vector
		 * @param	none
		 * @return	0 <= number
		 */
		public function get length():Number {
			
			return fixNumber(Math.sqrt(Math.pow(dirX, 2) + Math.pow(dirY, 2)));
		}
		
		/**
		 * sets the length (magnitude) to the given scalar
		 * @param	newLength:Number
		 * @return	length after set operation
		 */
		public function set length(newLength:Number):void {
			
			if (isNaN(Number(newLength))) {
				dirX = dirY = 0;
			}
			var currentLength:Number = Math.sqrt(Math.pow(dirX, 2) + Math.pow(dirY, 2));
			if (0 < currentLength) {
				times(Number(newLength) / currentLength);
			} else {
				dirY = 0;
				dirX = fixNumber(newLength);
			}
		}


		/*private function shift(val:Number):void {
			
			dirX *= val;
			dirY *= val;
		}*/
		
		/*public function center(start_pos:Point):Point{
			
			var end:Point = endPoint();
			new Point(dirX + end.x / 2, dirY + end.y / 2)
		
			dx = x2 - x1 
			dy = y2 - y1
			normals =(-dy, dx) and (dy, -dx)
		}*/
		
		/**
		 * Method to normalize current vector
		 */
		public function normalize(len:Number = 0):void {
			
			dirX /= length;
			dirY /= length;
			if (len != 0) {
				
				dirX *= len;
				dirY *= len;
			}
		}
		
		/**
		 * Method to obtain vector unit of current vector
		 * @return A copy of normalised vector
		 */
		public function getNormalized():mcVector2D {
			
			return new mcVector2D(dirX / length, dirY / length)
		}
		
		/**
		 * Move vector to new position
		 * @param	p Point
		 */
		public function moveTo(p:Point):void {
			
			dirX += p.x;
			dirY += p.y;
		}
		
		/**
		 * draws a vector in a given mc using a given color
		 * @param	mc|movieClipReference color|hexNumber
		 */
		public function draw(graphics:Graphics, startPoint:Point = null, color:uint = 0, thickness:Number = 1, opacity:Number = 1):void {
			
			//draw vector line
			var start:Point = startPoint ? startPoint : new Point();
			var end:Point = new Point(dirX, dirY);
			end.x += start.x;
			end.y += start.y;
			graphics.lineStyle(thickness, color, opacity, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
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
		
		private function polarAngle(point:Point, center:Point=null):Number{
			if (!center)center = new Point(0, 0);
			return Math.atan2(point.y - center.y, point.x - center.x) * 180 / Math.PI;
		}
		
		/**
		 * converts all numeric inputs to a number of fixed precision
		 * @param	numberValue:Number
		 * @return	number rounded to a fixed precision
		 */
		private function fixNumber(numberValue:Number):Number {
			
			return isNaN(Number(numberValue)) ? 0 : Math.round(Number(numberValue) * 100000) / 100000;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString():String {
			
			return "mcVector2D(" + dirX + ", " + dirY + ")";
		}
		
		public function toPoint():Point {
			
			return new Point(dirX, dirY);
		}
	}
}

/*
Rotate vector
new_pos_a.x = Math.cos((-angle) * Math.PI / 180) * vector_a.length;
new_pos_a.y = Math.sin((-angle) * Math.PI / 180) * vector_a.length;
*/