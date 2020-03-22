package orien.tools { //first use: Zemepis6/3d_Biomy_99.fla
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcProgressBar extends MovieClip {
		
		//prameters
		public var reverse:Boolean = false;
		
		//interface
		public var pbMask:MovieClip;
	
		//private variables
		private var _mask_width:Number;
		private var _progress:int = 0;

		//public variables
		public var maxVal:Number = 100;
		
		public function mcProgressBar() {
			
			_mask_width = pbMask.width; //store original width
			if (!reverse) pbMask.width = 1; //scale width to 1
		}
		
		public function get progress():int {
			return _progress;
		}
		
		public function set progress(val:int):void {
			
			_progress = val;
			var w:Number = (_mask_width / maxVal) * val;
			pbMask.width = w;
		}
	}
}