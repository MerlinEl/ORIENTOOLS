/*
   var mc_play:mcPlay = new mcPlay(result_01, function():void{

   result_01.gotoAndPlay(1);
   generateRandomExample();
   });
   mc_play.playReverse();
 */

package orien.tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcPlay extends MovieClip {
		
		private var _mc:MovieClip;
		private var _onComplete:Function = function():void {
		};
		
		public function mcPlay(mc:MovieClip, onComplete:Function = null) {
			
			_mc = mc;
			if (onComplete != null) _onComplete = onComplete;
		}
		
		public function playForward():void {
			
			addEventListener(Event.ENTER_FRAME, _playFroward, false, 0, true);
		}
		
		private function _playFroward(e:Event):void {
			
			if (_mc.currentFrame == _mc.totalFrames) { //STOP!
				removeEventListener(Event.ENTER_FRAME, _playFroward);
				_onComplete();
				
			} else {
				
				_mc.nextFrame();
			}
		}
		
		public function playReverse():void {
			
			addEventListener(Event.ENTER_FRAME, _playReverse, false, 0, true);
		}
		
		private function _playReverse(e:Event):void {
			
			if (_mc.currentFrame == 1) { //STOP!
				removeEventListener(Event.ENTER_FRAME, _playReverse);
				_onComplete();
				
			} else {
				
				_mc.prevFrame();
			}
		}
	}
}