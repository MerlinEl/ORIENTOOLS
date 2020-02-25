package orien.tools {
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class mcAnim {
		
		public function mcAnim() {
		
		}
		
		static public function fadeOut(obj:MovieClip, speed:Number = 1, invisible:Boolean = false):void {
			
			if (obj.alpha == 0) return; //if is hidden return
			TweenLite.to(obj, speed, {alpha: 0, onComplete: function():void {
				
				if (invisible) obj.visible = false;
			}});
		}
		
		static public function fadeIn(obj:MovieClip, speed:Number = 1, delay:Number = 0):void {
			
			if (obj.alpha == 1) return; //if is visible return
			TweenLite.to(obj, speed, {alpha: 1, delay: delay});
		}
		
		static public function hide(obj:MovieClip, fade:Boolean = false, speed:Number = 1):void {
			
			if (!obj.visible) return; //if is hidden return
			fade ? fadeOut(obj, speed, true) : (obj.visible = false, obj.alpha = 0);
		}
		
		static public function show(obj:MovieClip, fade:Boolean = false, speed:Number = 1):void {
			
			if (obj.visible) return; //if is visible return
			obj.visible = true;
			fade ? fadeIn(obj, speed) : obj.alpha = 1;
		}
		
		static public function wipe(obj:MovieClip, speed:Number = 1):void {
			
			TweenLite.to(obj, speed, {alpha: 0, onComplete: function():void {
				
				obj.parent.removeChild(obj);
			}});
		}
		
		/**
		 * 
		 * @param	obj
		 * @param	duration miliseconds
		 * @param	frequency miliseconds
		 * @param	distance max shake range
		 */
		static public function shakeObject(obj:MovieClip, duration:Number = 3000, frequency:Number = 30, distance:Number = 30):void {
			
			var shakes:int = duration / frequency;
			var shakeTimer:Timer = new Timer(frequency, shakes);
			var startX:Number = obj.x;
			var startY:Number = obj.y;
			
			var shakeUpdate:Function = function(e:TimerEvent):void {
				
				obj.x = startX + (-distance / 2 + Math.random() * distance);
				obj.y = startY + (-distance / 2 + Math.random() * distance);
			}
			
			var shakeComplete:Function = function(e:TimerEvent):void {
				
				obj.x = startX;
				obj.y = startY;
				e.target.removeEventListener(TimerEvent.TIMER, shakeUpdate);
				e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, shakeComplete);
			}
			
			shakeTimer.addEventListener(TimerEvent.TIMER, shakeUpdate);
			shakeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeComplete);
			
			shakeTimer.start();
		}

		static public function pulseObject(obj:MovieClip, duration:Number, scale_x:Number, scale_y:Number, repeat:int) {
			
			TweenMax.to(obj, duration, {scaleX: scale_x, scaleY: scale_y, repeat: repeat, yoyo: true});
		}
		
		static public function pulseObjects(arr:Array, duration:Number, scale_x:Number, scale_y:Number, repeat:int) {
			
			TweenMax.allTo(arr, duration, {scaleX: scale_x, scaleY: scale_y, repeat: repeat, yoyo: true});
		}
		
		static public function pulseFadeObject(obj:MovieClip, duration:Number, scale_x:Number, scale_y:Number, repeat:int) {
			
			TweenMax.to(obj, duration, {scaleX: scale_x, scaleY: scale_y, alpha: 0, repeat: repeat, yoyo: true});
		}
		
		static public function playSegment(mc:MovieClip, begin:int, end:int):void {
			
			mc.gotoAndPlay(begin);
			mc.addEventListener(Event.ENTER_FRAME, function(e:Event):void {
				
				if (mc.currentFrame == end) {
					mc.stop();
					mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
				}
			})
		
		/*mc.gotoAndPlay(begin); //CRASH!!!
		   mc.addFrameScript(end, frameFunction);
		   function frameFunction():void{
		   mc.stop();
		   mc.addFrameScript(30, null); //clear the code by writing null script to target frame.
		   }*/
		}
		
		static public function playSegmentAndExecute(mc:MovieClip, begin:int, end:int, fn:Function):void {
			
			mc.gotoAndPlay(begin);
			mc.addEventListener(Event.ENTER_FRAME, function(e:Event):void {
				
				if (mc.currentFrame == end) {
					mc.stop();
					mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
					fn();
				}
			})
		}
		
		static public function cascadeFadeIn(mc_arr:Array, speed:Number = 0.01, fade_time:Number = 1):void {
			
			var next_delay:Number = 10;
			for each (var mc:MovieClip in mc_arr) {
				
				mc.visible = true;
				TweenLite.to(mc, fade_time, {delay: next_delay / 10 * speed, alpha: 1});
				next_delay = next_delay + 10;
			}
		}
	}
}