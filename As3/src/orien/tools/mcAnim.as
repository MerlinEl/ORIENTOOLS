package orien.tools {
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class mcAnim {
		
		static public var incerase:Boolean = false;
		
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
		
		/* Not Tested
		 * Fade object when growing
		 * static public function fadeInWithGrowth(_obj:*, _timeSec:Number = DEFAULT_TIMESEC_FADE_IN, _ease:Ease = null):void {
			
			var _endAlpha:int = _obj.alpha;
			var _startScaleX:int = _obj.scaleX / 2;
			var _startScaleY:int = _obj.scaleY / 2;
			var _endScaleX:int = _obj.scaleX;
			var _endScaleY:int = _obj.scaleY;
			var _startX:int = _obj.width / 2 - (_startScaleX * _obj.width / 2);
			var _startY:int = _obj.height / 2 - (_startScaleY * _obj.height / 2);
			var _endX:int = _obj.x;
			var _endY:int = _obj.y;
			_ease = _ease ? _ease : Back.easeOut;
			//Para que o scale ocorra centralizado e não a partir do topo
			TweenMax.fromTo(_obj, DEFAULT_TIMESEC_FADE_IN, {alpha: 0, scaleX: _startScaleX, scaleY: _startScaleY, x: _startX, y: _startY}, {alpha: _endAlpha, scaleX: _endScaleX, scaleY: _endScaleY, x: _endX, y: _endY, ease: _ease});
		}*/
		
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
		
		static public function pulseObject(obj:MovieClip, speed:Number, scale_x:Number, scale_y:Number, repeat:int):void {
			
			TweenMax.to(obj, speed, {scaleX: scale_x, scaleY: scale_y, repeat: repeat, yoyo: true});
		}
		
		static public function pulseObjects(arr:Array, speed:Number, scale_x:Number, scale_y:Number, repeat:int):void {
			
			TweenMax.allTo(arr, speed, {scaleX: scale_x, scaleY: scale_y, repeat: repeat, yoyo: true});
		}
		
		static public function pulseFadeObject(obj:MovieClip, speed:Number, scale_x:Number, scale_y:Number, repeat:int):void {
			
			TweenMax.to(obj, speed, {scaleX: scale_x, scaleY: scale_y, alpha: 0, repeat: repeat, yoyo: true});
		}
		
		/**
		 * @example
		 * mcAnim.incerase = false; //start from MIN else start from MAX
		 * if (_clima_mat) mcAnim.pulseManual(_clima_mat, "alpha", 0.001, 0.4, 1);
		 * @param	obj
		 * @param	param
		 * @param	val
		 * @param	min
		 * @param	max
		 */
		static public function pulseManual(obj:*, param:String, val:Number, min:Number, max:Number):void {
			
			pulseInceraseCheck(obj[param] + val, min, max);
			obj[param] += incerase ? val : -val;
		}
		
		static private function pulseInceraseCheck(val:Number, min:Number, max:Number):void {
			
			if (incerase) { //incerase value
				
				if (val > max) incerase = false;
				
			} else { //decerase value
				
				if (val < min) incerase = true;
			}
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
		
		static public function getAllLabels(mc:MovieClip):Array {
			
			var labels:Array = [];
			for each (var label:FrameLabel in mc.currentLabels) labels.push(label.name);
			return labels;
		}
		
		/**
		 * Return prevoius label p3 from current p4
		 * @example mcAnim.getPreviousLabel(this, "p");
		 * @param	mc
		 * @param	pattern
		 * @return
		 */
		static public function getPreviousLabel(mc:MovieClip, pattern:String):String {
			
			if (mc.currentFrame <= 1) return null;
			var curr_index:int = int(mc.currentLabel.replace(pattern, "")); //replace cuts the leading letters off the number
			var prev_index:int = curr_index - 1;
			return pattern + prev_index;
		}
		
		static public function getNextLabel(mc:MovieClip, pattern:String):String {
			
			if (mc.currentFrame >= mc.totalFrames) return null;
			var curr_index:int = int(mc.currentLabel.replace(pattern, "")); //replace cuts the leading letters off the number
			var prev_index:int = curr_index + 1;
			return pattern + prev_index;
		}
		
		static public function gotoNextFrame(mc:MovieClip):Boolean{
			
			if (mc.currentFrame < mc.totalFrames) {
				
				mc.gotoAndStop(mc.currentFrame+1);
				return true;
			}
			return false;
		}
		
		static public function gotoPrevFrame(mc:MovieClip):Boolean{
			
			if (mc.currentFrame > 1) {
				mc.gotoAndStop(mc.currentFrame-1);
				return true;
			}
			return false;
		}
		
		/**
		 * @example 
			mcAnim.colorizeCardBounce(card, 0xFF1752, moveMarkOnTop, [card]);
			function moveMarkOnTop(card:ClickCard):void{
		  
				ftrace("card completed:%", card)
			}
		 * @example	
		 * mcAnim.colorizeCardBounce(this, clr, function(){
				
				dispatchEvent(new mcCustomEvent(mcCustomEvent.EFFECT_COMPLETE, this));
			})
		 * @param	card
		 * @param	color
		 * @param	comp_fn
		 * @param	comp_params
		 */
		static public function colorizeCardBounce(card:MovieClip, color:uint = undefined, comp_fn:Function = null, comp_params:Array = null):void {
			
			mcEffect.tint(card, color ? color : 0x0AE28B, 0.6);
			card.alpha = 0;
			TweenLite.to(card, 1, {alpha: 1, ease: Bounce.easeOut, onComplete: comp_fn, onCompleteParams: comp_params});
		}
	}
}