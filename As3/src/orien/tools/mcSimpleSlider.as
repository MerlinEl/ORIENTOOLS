package orien.tools {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class mcSimpleSlider extends MovieClip {
		
		// interface components
		public var rider:MovieClip;
		public var btnMin:mcSimpleButton;
		public var btnMax:mcSimpleButton;
		public var rails:MovieClip;
		
		//public variables
		public var on_move:Function = function() {
		};
		
		// private variables
		private var _drag_bounds:Rectangle;
		private var _horizontal:Boolean = true;
		private var _val:Number = 0;
		private var _range:Array = [0, 100];
		private var _zom_speed:Number = 1;
		
		public function mcSimpleSlider():void {
			
			_drag_bounds = new Rectangle(0, 0, rails.width, 0);
			rider.buttonMode = true;
			rider.mouseChildren = false;
			rider.addEventListener(MouseEvent.MOUSE_DOWN, down);
			rider.addEventListener(MouseEvent.MOUSE_OUT, sliderOut);
			
			btnMin.on_down = function(){
				
				addEventListener(Event.ENTER_FRAME, loopPlus);
			}
			btnMin.on_up = function(){
				
				removeEventListener(Event.ENTER_FRAME, loopPlus);
			}
			
			btnMax.on_down = function(){
				
				addEventListener(Event.ENTER_FRAME, loopMinus);
			}
			btnMax.on_up = function(){
				
				removeEventListener(Event.ENTER_FRAME, loopMinus);
			}
		}
		
		private function loopPlus(e:Event):void {
			
			if (value < _range[1]) {
				
				value += _zom_speed;
				on_move();
			} else {
				
				removeEventListener(Event.ENTER_FRAME, loopPlus);
			}
		}
		
		private function loopMinus(e:Event):void {
			
			if (value > _range[0]) {
				
				value -= _zom_speed;
				on_move();
			} else {
				
				removeEventListener(Event.ENTER_FRAME, loopMinus);
			}
		}
		
		private function sliderOut(e:MouseEvent):void {
			
			if (mouseX > rider.width || mouseX < rider.width) up();
		}
		
		private function down(e:MouseEvent) {
			
			rider.addEventListener(MouseEvent.MOUSE_UP, up);
			rider.startDrag(false, _drag_bounds);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
		}
		
		private function up(e:MouseEvent = null) {
			
			rider.removeEventListener(MouseEvent.MOUSE_UP, up);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			rider.stopDrag();
		}
		
		private function onSlide(e:Event):void {
			
			var percent:Number = rider.x / rails.width;
			_val = mcMath.roundTo(_range[0] + percent * (_range[1] - _range[0]), 2);
			on_move();
			//ftrace("percent:% val:%",percent, _val);
		}
		
		public function set value(val:Number):void {
			
			_val = mcMath.minMaxFrom(val, _range[0], _range[1]);
			moveRiderTo(_val);
		}
		
		private function moveRiderTo(val:Number):void {
			
			var percent:Number = (val - _range[0]) / (_range[1] - _range[0]);
			rider.x = rails.width * percent;
		}
		
		public function get value():Number {
			
			return _val
		}
		
		/**
		   var zoom_btn:btnSlider = new btnSlider();//{"x":100, "y":50, "name":"zoom_button"});
		   zoom_btn.initParams({"x":100, "y":50, "length":250, "name":"zoom_button", "horizontal":false, "custom_range":[100, 500]});
		   zoom_btn.on_move = function(){
		   
			   console_01.text = String(zoom_btn.value);
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
			if (settings["length"]) {
				
				rails.width = settings["length"];
				_drag_bounds = new Rectangle(0, 0, rails.width, 0);
			}
			if (settings["horizontal"] != null) {
				
				this._horizontal = settings["horizontal"];
				if (!_horizontal) {
				
					rotation = 90;
					rider.rotation = -90;
					btnMin.rotation = -90;
					btnMin.x = rails.x + rails.width;
				}
			}
			if (settings["custom_range"]) this._range = settings["custom_range"];
			if (settings["zom_speed"]) this._zom_speed = settings["zom_speed"];
			if (settings["alpha"]) {
				
				this.alpha = settings["alpha"];
				rails.alpha = Math.max(settings["alpha"] - 0.4, 0.1);
			}
		}
	}
}

