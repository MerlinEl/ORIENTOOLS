package orien.tools { //used at Vector3D
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 * The mcPoint3D holds the properties to represent a single point i 3d space (x,y,z)
	 * @version		1.0
	 */
	public class mcPoint3D {

		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		/**
		 * Creates a mcPoint3D instance
		 * @param	x	The x coordinate
		 * @param	y	The y coordinate
		 * @param	z	The z coordinate
		 */
		public function mcPoint3D(x:Number = 0, y:Number = 0, z:Number = 0) {
			
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}

/**
 * Performs a perspective projection on the instance and returns a 2d represenation of the 3d coordinates
 * @param		focalLength			Distance from camera to the stage
 * @param		projectionCenter	2d coordinate representing the center of the viewing frustrum (vanishing point)
 * @return		A Point2d instance representing a projected version of <code>this<code>
 */
/*public function project (focalLength:Number, projectionCenter:Point = null):Point2d
   {
   var t:Number = focalLength / (focalLength+z);

   if (!projectionCenter)
   {
   projectionCenter = new Point(0, 0);
   }

   var xOffset:Number = projectionCenter.x;
   var yOffset:Number = projectionCenter.y;

   var x:Number = this.x;
   var y:Number = this.y;
   var z:Number = this.z;

   x -= xOffset;
   y -= yOffset;

   x = (x*t)+xOffset;
   y = (y*t)+yOffset;

   return new Point2d(x, y, t);
   }*/

/**
 * Applies the supplied transformation matrix to the point around the supplied pivot point
 * @param		m				Matrix3d instance with the transformation values
 * @param		pivotPoint		A Point in 3d witch the transformation should be applied around. The coordinates (0,0,0) is used if no value is supplied.
 */
/*public function applyMatrix(m:Matrix3d, pivotPoint:mcPoint3D = null):void {
	
	if (!pivotPoint) {
		pivotPoint = new mcPoint3D();
	}
	
	var p:mcPoint3D = m.apply(this, pivotPoint);
	
	this.x = p.x;
	this.y = p.y;
	this.z = p.z;
}*/