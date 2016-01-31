package orien.tools {
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class mcAnim {
		
		public function mcAnim() {
		
		}
		
		static public function fadeOut(obj:MovieClip, speed:Number = 1, invisible:Boolean = false):void {
			if (obj.alpha == 0) return; //if is hidden return
			TweenLite.to(obj, speed, { alpha: 0, onComplete: function():void{
				if (invisible) obj.visible = false;
			}});
		}
		
		static public function fadeIn(obj:MovieClip, speed:Number = 1):void {
			if (obj.alpha == 1) return; //if is visible return
			TweenLite.to(obj, speed, {alpha: 1});
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
	}

}