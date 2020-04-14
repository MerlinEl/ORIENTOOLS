package orien.tools {
	import com.greensock.TweenLite;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import orien.tools.mcTran;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2018
	 */
	public class mcTextButton extends MovieClip {
		
		public var is_locked:Boolean = false;
		public var is_correct:Boolean = false;
		public var on_down:Function = new Function();
		public var on_up:Function = new Function();
		private var label_tf:TextField = new TextField();
		private var _default_border_color:uint;
		private var _focus_border_color:uint = 0xF86449;
		private var label_left_offset:Number = 4;
		private var corner_radius:Number = 8;
		private var label_format:TextFormat;
		private var inner_shadow:DropShadowFilter = new DropShadowFilter(0, 0, 0x0066FF, 1, 12, 12, 1, 1, true);
		private var drop_shadow:DropShadowFilter = new DropShadowFilter(2, 80, 0xFF9122, 1, 5, 5, 0.45, 1);
		
		public function mcTextButton(btn_name:String, text_color:uint, bg_color:uint, border_color:uint, label_text:String, text_size:Number = 24, corners:Number = 8, align:String = TextFormatAlign.LEFT) {
			
			name = btn_name;
			corner_radius = corners;
			_default_border_color = border_color;
			label_format = new TextFormat();
			label_format.font = "Times New Roman";
			label_format.size = text_size;
			label_format.bold = false;
			label_format.align = align;
			//if (align != TextFormatAlign.CENTER) label_format.leftMargin = label_left_offset;
			
			label_tf.defaultTextFormat = label_format;
			label_tf.selectable = false;
			//label_tf.border = true;
			label_tf.wordWrap = false;
			label_tf.multiline = false;
			//label_tf.borderColor = border_color;
			//label_tf.opaqueBackground = bg_color;
			label_tf.autoSize = "left";
			label_tf.textColor = text_color;
			label_tf.text = label_text;
			label_tf.mouseEnabled = false;
			label_tf.alpha = 1;
			//center x y
			label_tf.x -= label_tf.width / 2;
			label_tf.y -= label_tf.height / 2;
			//draw rounded bg
			drawBackground(mcTran.getRect(label_tf), bg_color, border_color);
			//add filters
			filters = [drop_shadow, inner_shadow];
			//add to stage
			addChild(label_tf);
			buttonMode = true;
			mouseEnabled = true;
			mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		}
		
		private function drawBackground(rect:Rectangle, bg_color:uint, border_color:uint):void {
			
			var offset:Number = 8;
			var sp:Shape = new Shape();
			var gra:Graphics = sp.graphics;
			gra.clear();
			gra.lineStyle(2, border_color, 1);
			gra.beginFill(bg_color, 1);
			gra.drawRoundRect(rect.x - offset / 2, rect.y - offset / 2, rect.width + offset, rect.height + offset, corner_radius, corner_radius);
			gra.endFill();
			addChild(sp);
		}
		
		public function get label():String {
			
			return label_tf.text;
		}
		
		public function set label(str:String):void {
			
			label_tf.text = str;
		}
		
		public function pos(pos_x:Number, pos_y:Number):void{
			
			x = pos_x; y = pos_y;
		}
		
		public function wipe(fade:Boolean = false, kick:Boolean = false):void {
			
			unregister();
			if (fade && kick) {
				
				TweenLite.to(this, 1, {alpha: 0, x:x-60, y:y-60, rotation:180, onComplete: wipeCard, onCompleteParams: [this]});
			} else if (fade) {
				TweenLite.to(this, 1, {alpha: 0, y:y+30, scaleX:0.5, scaleY:0.5, onComplete: wipeCard, onCompleteParams: [this]});
			} else {
				
				parent.removeChild(this);
			}
			function wipeCard(card:mcTextButton):void {
				
				card.parent.removeChild(card);
			}
		}
		
		private function unregister():void{
			
			removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			removeEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onDown(e:MouseEvent):void {
			
			if (is_locked) return;
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			on_down();
		}
		
		private function onUp(e:MouseEvent):void {
			
			removeEventListener(MouseEvent.MOUSE_UP, onUp);
			if (is_locked) return;
			on_up();
		}
	}
}