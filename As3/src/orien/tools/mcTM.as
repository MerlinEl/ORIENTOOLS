package orien.tools { //not used
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcTM {
		
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _scale:Number;
		private var _size:Number;
		private var _rotation:Number;
		
		public function mcTM() {
			
			var gr:Number = obj.rotation * Math.PI / 180; // radians
			var gs:Number = stage.stageWidth / obj.width; // get scale ratio
		}
	}
}