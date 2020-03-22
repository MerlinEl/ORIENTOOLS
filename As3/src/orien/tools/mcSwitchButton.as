/*Experimental button with changable function

   fn example:
   btn_cancel.on_disabled = function(){

   trace("pressed cancel")
   }
   fn example:
   btn_switchview.on_enabled = editText;
   btn_switchview.on_disabled = viewText;
   btn_switchview.pressed = true;
   btn_switchview.on_enabled();
   }
 */
//TODO test if twoo buttons have different functions

package orien.tools {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import orien.tools.mcEffect;
	
	public class mcSwitchButton extends MovieClip {
		
		public var on_enabled:Function = function() {
		};
		public var on_disabled:Function = function() {
		};
		public var start_pressed:Boolean = false;
		
		private var _is_locked:Boolean = false;
		private var _disabled:Boolean;
		private var _filters:Array;
		private var _hilighted:Boolean;
		private var _pressed:Boolean = false;
		
		public function mcSwitchButton() {
			
			buttonMode = true;
			mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			if (start_pressed) this.pressed = true;
			addEventListener(MouseEvent.MOUSE_DOWN, down);
		}
		
		private function down(e:MouseEvent) {
			
			if (is_locked) return;
			this.pressed = !pressed;
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
		
		public function get hilighted():Boolean {
			
			return _hilighted;
		}
		
		public function set hilighted(value:Boolean):void {
			
			this["flicker_01"].visible = value;
			_hilighted = value;
		}
		
		public function get pressed():Boolean {
			
			return _pressed;
		}
		
		public function set pressed(value:Boolean):void {
			
			value ? gotoAndStop(2) : gotoAndStop(1);
			value ? on_enabled() : on_disabled();
			_pressed = value;
		}
		
		/**
		   btn_rotate = new btnPlay();
		   btn_rotate.initParams({"x":btn_offset, "y":btn_offset, "scale":1.7, "name":"btn_rotate"});
		   btn_rotate.on_enabled = function(){
		
		   _swf._autoRotate = true;
		   }
		   btn_rotate.on_disabled = function(){
		
		   _swf._autoRotate = false;
		   }
		   addChild(btn_rotate);
		 * @param	settings
		 */
		public function initParams(settings:Object):void {
			
			if (settings["x"]) this.x = settings["x"];
			if (settings["y"]) this.y = settings["y"];
			if (settings["scale"]) {
				
				this.scaleX = settings["scale"];
				this.scaleY = settings["scale"];
			}
			if (settings["name"]) this.name = settings["name"];
		}
		
		public function moveTo(pos_x:Number, pos_y:Number):void {
			
			x = pos_x;
			y = pos_y;
		}
		
		public function scalTo(scale:Number):void {
			
			scaleX = scale;
			scaleY = scale;
		}
	}
}