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
		 * constructor for mcVector2D
		 * @param	p1:Point, p2:Point || x:Number, y:Number || v:mcVector2D
		 * @return	reference to the new instance
		 */
		public function mcVector2D(... args) {
			
			this.dirX = 0;
			this.dirY = 0;
			
			if (2 == args.length) {
				if (args[0] is Point){
					// two points were pasted (build vector a - b)
					this.dirX = args[0].x - args[1].x, 
					this.dirY = args[0].y - args[1].y;
				} else {
					// x and y were passed
					this.dirX = this.fixNumber(args[0]);
					this.dirY = this.fixNumber(args[1]);
				}
			} else if (1 == args.length) {
				if (args[0] is mcVector2D) {
					// an existing vector was passed
					this.dirX = args[0].x;
					this.dirY = args[0].y;
				}
			}
		}
		
		/**
		 * sets the properties of the vector
		 * @param	x:Number, y:Number || v:mcVector2D
		 * @return	reference to the vector
		 */
		public function set(... args):mcVector2D {
			
			this.dirX = 0;
			this.dirY = 0;
			
			if (2 == args.length) {
				// x and y were passed
				this.dirX = this.fixNumber(args[0]);
				this.dirY = this.fixNumber(args[1]);
			} else if (1 == args.length) {
				if (args[0] is mcVector2D) {
					// an existing vector was passed
					this.dirX = args[0].x;
					this.dirY = args[0].y;
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
					this.dirX += args[i].dirX;
					this.dirY += args[i].dirY;
				}
			}
			this.dirX = this.fixNumber(this.dirX);
			this.dirY = this.fixNumber(this.dirY);
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
					this.dirX -= args[i].dirX;
					this.dirY -= args[i].dirY;
				}
			}
			this.dirX = this.fixNumber(this.dirX);
			this.dirY = this.fixNumber(this.dirY);
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
					this.dirX *= args[0].dirX;
					this.dirY *= args[0].dirY;
				} else {
					if (isNaN(Number(args[0]))) {
						this.dirX = this.dirY = 0;
					} else {
						this.dirX *= Number(args[0]);
						this.dirY *= Number(args[0]);
					}
				}
			} else if (2 == args.length) {
				isNaN(Number(args[0])) ? this.dirX = 0 : this.dirX *= Number(args[0]);
				isNaN(Number(args[1])) ? this.dirY = 0 : this.dirY *= Number(args[1]);
			}
			this.dirX = this.fixNumber(this.dirX);
			this.dirY = this.fixNumber(this.dirY);
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
			var currentLength:Number = Math.sqrt(Math.pow(this.dirX, 2) + Math.pow(this.dirY, 2));
			var newAngleRadians:Number = ((Math.atan2(this.dirY, this.dirX) * (180 / Math.PI)) + Number(rotationAngle)) * (Math.PI / 180);
			this.dirX = this.fixNumber(currentLength * Math.cos(newAngleRadians));
			this.dirY = this.fixNumber(currentLength * Math.sin(newAngleRadians));
			return this;
		}
		
		/**
		 * inverts the vector
		 * @param	none
		 * @return	reference to the vector
		 */
		public function invert():mcVector2D {
			
			this.dirX *= -1;
			this.dirY *= -1;
			return this;
		}
		
		/**
		 * projects the vector onto vector v
		 * @param	v:mcVector2D
		 * @return	reference to the vector
		 */
		public function project(v:mcVector2D):mcVector2D {
			
			if (v is mcVector2D) {
				var scalar:Number = this.dot(v) / Math.pow(v.length, 2);
				this.set(v);
				this.times(scalar);
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
				var rotationAngle:Number = 2 * this.angleBetween(v);
				if (0 >= this.angleBetweenCos(vAfterHorizReflect)) {
					rotationAngle *= -1;
				}
				this.rotate(rotationAngle);
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
				return this.fixNumber((this.dirX * v.dirX) + (this.dirY * v.dirY));
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
				return Math.abs(this.fixNumber((this.dirX * v.dirY) - (this.dirY * v.dirX)));
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
				return this.fixNumber(Math.acos(this.dot(v) / (this.length * v.length)) * (180 / Math.PI));
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
				return this.fixNumber(this.cross(v) / (this.length * v.length));
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
				return this.fixNumber(this.dot(v) / (this.length * v.length));
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
				var tempX:Number = this.dirX;
				var tempY:Number = this.dirY;
				this.dirX = v.dirX;
				this.dirY = v.dirY;
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
			
			return new mcVector2D(this.dirY, -this.dirX);
		}
		
		/**
		 * creates a new vector which is normal (anti-clockwise) to the vector
		 * @param	none
		 * @return	reference to the newly created vector
		 */
		public function getLeftNormal():mcVector2D {
			
			return new mcVector2D(-this.dirY, this.dirX);
		}
		
		/**
		 * tests if two vectors are normal to each other
		 * @param	v:mcVector2D
		 * @return	boolean indicating normality
		 */
		public function isNormalTo(v:mcVector2D):Boolean {
			
			if (v is mcVector2D) {
				return (this.dot(v) === 0);
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
				if ((this.dirX === v.dirX) && (this.dirY === v.dirY)) {
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
			
			return this.dirX;
		}
		
		/**
		 * sets x value of the vector
		 * @param	newX:Number
		 * @return	value of x BEFORE precision fix
		
		 */
		public function set x(newX:Number):void {
			
			this.dirX = this.fixNumber(newX);
		}
		
		/**
		 * retrieves the current y value of the vector
		 * @param	none
		 * @return	current value of y
		 */
		public function get y():Number {
			
			return this.dirY;
		}
		
		/**
		 * sets y value of the vector
		 * @param	newY:Number
		 * @return	value of y BEFORE precision fix
		 */
		public function set y(newY:Number):void {
			
			this.dirY = this.fixNumber(newY);
		}
		
		/**
		 * calculates the angle of the vector
		 * @param	none
		 * @return	number representing angle in degrees
		 */
		public function get angle():Number {
			
			return this.fixNumber(Math.atan2(this.dirY, this.dirX) * (180 / Math.PI));
			//return this.fixNumber(((Math.atan2(this.dirY, this.dirX)*(180/Math.PI))+360)%360);
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
			var currentLength:Number = Math.sqrt(Math.pow(this.dirX, 2) + Math.pow(this.dirY, 2));
			this.dirX = this.fixNumber(currentLength * Math.cos(angleRadians));
			this.dirY = this.fixNumber(currentLength * Math.sin(angleRadians));
		}
		
		/**
		 * returns the length (magnitude) of the vector
		 * @param	none
		 * @return	0 <= number
		 */
		public function get length():Number {
			
			return this.fixNumber(Math.sqrt(Math.pow(this.dirX, 2) + Math.pow(this.dirY, 2)));
		}
		
		/**
		 * sets the length (magnitude) to the given scalar
		 * @param	newLength:Number
		 * @return	length after set operation
		 */
		public function set length(newLength:Number):void {
			
			if (isNaN(Number(newLength))) {
				this.dirX = this.dirY = 0;
			}
			var currentLength:Number = Math.sqrt(Math.pow(this.dirX, 2) + Math.pow(this.dirY, 2));
			if (0 < currentLength) {
				this.times(Number(newLength) / currentLength);
			} else {
				this.dirY = 0;
				this.dirX = this.fixNumber(newLength);
			}
		}

		/**
		 * If you have a vector and a length, you can find the endpoint.
		 * @param	start_point
		 * @return
		 */
		/*public function endPoint(start_point:Point, len:Number):Point{
			
			this.length = len;
			moveTo(start_point);
			return new Point(dirX, dirY);
		}*/
		
		
		/**
		 * not tested
		 */
		/*public function get end():Point {

			var len = this.length;
			this.normalize();
			return new Point(dirX + dirX * len, dirY + dirY * len);
		}*/
		
		/*public function center():Point{
			
			var end:Point = endPoint();
			new Point(dirX + end.x / 2, dirY + end.y / 2)
		
			dx = x2 - x1 
			dy = y2 - y1
			normals =(-dy, dx) and (dy, -dx)
		}*/
		
		/**
		 * Method to normalize current vector
		 */
		public function normalize():void {
			
			this.dirX /= this.length;
			this.dirY /= this.length;
		}
		
		/**
		 * Method to obtain vector unit of current vector
		 * @return A copy of normalised vector
		 */
		public function getNormalized():mcVector2D {
			
			return new mcVector2D(this.dirX / this.length, this.dirY / this.length)
		}
		
		/**
		 * Move vector to new position
		 * @param	p Point
		 */
		public function moveTo(p:Point):void {
			
			this.dirX += p.x;
			this.dirY += p.y;
		}
		
		/**
		 * draws a vector in a given mc using a given color
		 * @param	mc|movieClipReference color|hexNumber
		 */
		public function paint(mc:Object, color:Number):void {
			
			mc.graphics.lineStyle(0, color);
			mc.graphics.moveTo(0, 0);
			mc.graphics.lineTo(this.dirX, this.dirY);
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
		 * override of toString() that produces meaningful output
		 * @param	none
		 * @return	string
		 */
		public function toString():String {
			
			return "[" + this.dirX + "," + this.dirY + "]";
		}
		
		public function toPoint():Point {
			
			return new Point(this.dirX, this.dirY);
		}
	
	}

}