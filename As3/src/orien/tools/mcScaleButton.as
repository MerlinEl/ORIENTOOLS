package orien.tools {
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import imost.InitAfterValidate;
	import orien.tools.mcEffect;
	
	public class mcScaleButton extends MovieClip {
		
		//instance parameters reserved
		public var label_param:String;
		public var switch_type:String;
		public var button_label:String;
		public var zoom_tag:String;
		public var color_iner:uint;
		public var color_outer:uint;
		//instance components	
		public var btn_text:TextField;
		public var btn_skin:MovieClip;
		//public variables
		public var on_down:Function = function() {
		};
		public var on_up:Function = function() {
		};
		public var start_pos:Point;
		
		//private variables
		private var _is_locked:Boolean;
		private var _disabled:Boolean;
		private var _filters:Array;
		private var _hoffset:Number = 4;
		private var _pressed:Boolean = false;
		private var _fixed_size:Boolean = false;
		private var _text_align:String = TextFieldAutoSize.CENTER;
		private var _min_width:Number = 60;
		private var _pivot_align:String = "left";
		
		public function mcScaleButton(init_force:Boolean = false) {
			
			buttonMode = true;
			mouseChildren = false;
			if (init_force) { //use: dynamic button generation
				
				init();
				
			} else { //use: button is on stage
				
				new InitAfterValidate(this, "enabled", init); //wait for variable is accesible
			}
		}
		
		public function setWidth(new_width:Number, fix_size:Boolean = false):void {
			
			btn_skin.width = Math.max(_min_width, new_width);
			_fixed_size = fix_size;
		}
		
		private function init():void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//ftrace("mcScaleButton > After Validate")
			_pivot_align = isPivotLeft() ? "left" : "center";
			btn_text.autoSize = _text_align;
			if (button_label) this.textLabel = button_label;
			tintSkin(); //tint skin if colorize is defined and not black
			//replaced with Enabled grid on MC
			//btn_skin.scale9Grid = new Rectangle(rect9.x, rect9.y, rect9.w, rect9.h);
			addEventListener(MouseEvent.MOUSE_DOWN, down);
		}
		
		private function tintSkin():void {
			
			if (color_iner && color_iner != 0x000000) mcEffect.tint(btn_skin.inner, color_iner, 0.8);
			if (color_outer && color_outer != 0x000000) mcEffect.tint(btn_skin.outer, color_outer, 0.8);
		}
		
		private function isPivotLeft():Boolean {
			
			return getRect(this).x == 0;
		}
		
		private function down(e:MouseEvent) {
			
			if (_is_locked) return;
			btn_skin.gotoAndStop(2);
			tintSkin();
			addEventListener(MouseEvent.MOUSE_UP, up);
			on_down();
		}
		
		private function up(e:MouseEvent) {
			
			if (_is_locked) return;
			btn_skin.gotoAndStop(1);
			tintSkin();
			removeEventListener(MouseEvent.MOUSE_UP, up);
			on_up();
		}
		
		public function get is_locked():Boolean {
			
			return _is_locked;
		}
		
		public function set is_locked(value:Boolean):void {
			
			_is_locked = value;
		}
		
		public function get disabled():Boolean {
			
			return _disabled;
		}
		
		public function set disabled(value:Boolean):void {
			
			if (value == true && _disabled) return; //not again!
			_disabled = value;
			_is_locked = value;
			if (value) {
				
				_filters = filters;
				mcEffect.desaturate(this);
			} else {
				
				filters = _filters;
			}
		}

		public function get textLabel():String {
			
			return btn_text.text;
		}
		
		public function set textLabel(str:String):void {
			
			//ftrace("mcScaleButton > Set Text")
			btn_text.text = str;
			if (!_fixed_size) btn_skin.width = Math.max(_min_width, btn_text.width) + _hoffset*2;
			centerText();
		}
		
		private function centerText():void {
			
			//Text align when button pivot is at TOP_LEFT or CENTER only!!!
			switch (text_align) {
			
			case "left":
				//ftrace("% pivot:% align left...", btn_text.text, _pivot_align)
				if (_pivot_align == "left") {
					
					btn_text.x = _hoffset; //OK
				} else {
					
					btn_text.x = -btn_skin.width / 2 + _hoffset*2; //OK
				}
				break;
			case "right": 
				//ftrace("% pivot:% align right...", btn_text.text, _pivot_align)
				if (_pivot_align == "left") {
					
					btn_text.x = btn_skin.width - btn_text.width - _hoffset;
				} else {
					
					btn_text.x = -btn_skin.width / 2 + btn_skin.width - btn_text.width - _hoffset*2;//-(btn_text.width - btn_text.width)// +  / 2//- _hoffset; //OK
				}
				break;
			case "center": 
				//ftrace("% pivot:% align center...", btn_text.text, _pivot_align)
				if (_pivot_align == "left") {
				
					btn_text.x = (btn_skin.width - btn_text.width) / 2;
				} else {
					
					btn_text.x = -btn_text.width * 0.5;
				}
				break;
			}
		}
		
		public function get pressed():Boolean{
			
			return _pressed;
		}
		
		public function set pressed(val:Boolean):void{
			
			_pressed = val;
			btn_skin.gotoAndStop(val ? 2 : 1);
			tintSkin();
		}
		
		public function get fixedSize():Boolean {
			return _fixed_size;
		}
		
		public function set fixedSize(value:Boolean):void {
			_fixed_size = value;
		}
		
		public function get text_align():String {
			return _text_align;
		}
		
		public function set text_align(value:String):void {
			_text_align = value;
		}
		
		public function set hoffset(value:Number):void {
			_hoffset = value;
		}
	}
}

/*Experimental button with changable function

   fn example:
   btn_cancel.on_up = function(){

   trace("pressed cancel")
   }
   fn example:
   btn_info.on_up = function(){

   this.pressed ? info_window.gotoAndPlay("show") : info_window.gotoAndPlay("hide");
   this.pressed = !this.pressed;
   }
 */
//TODO test if twoo buttons have different functions