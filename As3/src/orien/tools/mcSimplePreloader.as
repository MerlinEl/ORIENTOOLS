package orien.tools {
	
	import com.darcey.debug.Ttrace;
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class mcSimplePreloader extends Sprite {
		
		private var _speed:Number = 2;
		
		[Embed(source="../../../@ASSETS/logo/AnimLoader.swf")]
		public var AnimLoader:Class;
		
		/**
		 * @example
		 * 	_preloader = new mcSimplePreloader();
			_win.stage.addChild(_preloader);
			_preloader.hide();
		 * @param	hidden
		 * @param	color
		 */
		public function mcSimplePreloader(w:Number, h:Number, hidden:Boolean = false, color:uint = 0xFFFFFF) {
			
			mouseEnabled = false;
			mouseChildren = false;
			hidden ? hide(true) : show(true);
			//build Interface
			var animloader:Sprite = new AnimLoader();
			addChild(animloader);
			drawRect(w, h, color);
			animloader.x = w / 2 - animloader.width/2;
			animloader.y = h / 2 - animloader.height/2;
		}

		private function drawRect(w:Number, h:Number, color:uint):void {
		
			graphics.beginFill(color); // choosing the colour for the fill
			graphics.drawRect(0, 0, w, h); // (x spacing, y spacing, width, height)
			graphics.endFill(); // not always needed but I like to put it in to end the fill
		}
		
		public function progress(data:String):void {
			
			//trace("progress:" + data);
		}
		
		public function hide(hard:Boolean = false, delay:Number = 0):void {
			
			visible = true;
			hard ? alpha = 0 : TweenLite.to(this, _speed, {alpha: 0, delay:delay});
		}
		
		public function show(hard:Boolean = false):void {
			
			visible = false;
			hard ? alpha = 1 : TweenLite.to(this, _speed, { alpha: 1 } );
		}
	}
}