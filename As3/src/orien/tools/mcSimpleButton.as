package orien.tools {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import orien.tools.mcEffect;
	
	public class mcSimpleButton extends MovieClip {
		
		//instance parameters reserved
		public var label_param:String;
		public var switch_type:String;
		//public variables
		public var on_down:Function = function() {
		};
		public var on_up:Function = function() {
		};
		public var start_pos:Point = new Point(x, y);
		//private variables
		private var _hilighted:Boolean;
		private var _is_locked:Boolean;
		private var _disabled:Boolean;
		private var _filters:Array;
		
		/**
		 * 1f normal state
		 * 2f mouse down state
		 * 3f mouse over state
		 */
		public function mcSimpleButton() {
			
			buttonMode = true;
			mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.MOUSE_DOWN, down);
			//if button have 3f enable hilighter
			if (totalFrames > 2) mouseHilighter = true;
		}
		
		private function down(e:MouseEvent) {
			
			if (_is_locked) return;
			gotoAndStop(2);
			addEventListener(MouseEvent.MOUSE_UP, up);
			on_down();
		}
		
		private function up(e:MouseEvent) {
			
			if (_is_locked) return;
			gotoAndStop(1);
			removeEventListener(MouseEvent.MOUSE_UP, up);
			on_up();
		}
		
				
		public function set mouseHilighter(state:Boolean):void {
			
			if (state) {
				
				addEventListener(MouseEvent.MOUSE_OVER, over);
				addEventListener(MouseEvent.MOUSE_OUT, out);
			} else {
				
				removeEventListener(MouseEvent.MOUSE_OVER, over);
				removeEventListener(MouseEvent.MOUSE_OUT, out);
			}
		}
				
		private function over(e:MouseEvent):void {
			
			gotoAndStop(3);
		}
		
		private function out(e:MouseEvent):void {
			
			gotoAndStop(1);
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
		
		public function get textLabel():String {
			
			return this["num"] ? this["num"].text : "";
		}
		
		public function set textLabel(str:String):void {
			
			if (this["num"]) this["num"].text = str;
		}
		
		/**
		   var zoom_btn:btnZoomIn = new btnZoomIn();//{"x":100, "y":50, "name":"zoom_button"});
		   var exit_btn:btnExit = new btnExit();//{"x":100, "y":50, "name":"zoom_button"});
		   zoom_btn.initParams({"x":100, "y":50, "scale":1.5, "name":"zoom_button"})
		   exit_btn.initParams({"x":150, "y":50, "name":"exit_button"})
		   exit_btn.on_up = function(){
		
			  ftrace("Im button:%", this.name)
		   }
		   addChild(zoom_btn);
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
		
		public function moveTo(pos_x:Number, pos_y:Number):void{
			
			x = pos_x;
			y = pos_y;
		}
		
		public function scalTo(scale:Number):void{
			
			scaleX = scale;
			scaleY = scale;
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