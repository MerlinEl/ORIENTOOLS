package orien.tools { //doresit polohu nuly
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class mcDoubleSlider extends MovieClip {
		
		// interface components
		public var rider:MovieClip;
		public var rails:MovieClip;
		
		// private variables
		private var max_x:int = 1000;
		private var _drag_bounds:Rectangle;
		private var _horizontal:Boolean = true;
		private var _val:Number = 0;
		private var _range:Array = [-80, 180];
		
		public function mcDoubleSlider(horizontal:Boolean = true, length:Number = 300, custom_range:Array = null):void {
			
			_horizontal = horizontal;
			if (!horizontal) {
				
				rotation = 90;
				rider.rotation = -90;
			}
			if (custom_range) _range = custom_range;
			rails.width = length;
			rails.x = -length/2
			_drag_bounds = new Rectangle(-length/2, 0, length, 0);
			rider.buttonMode = true;
			rider.mouseChildren = false;
			rider.addEventListener(MouseEvent.MOUSE_DOWN, down);
			rider.addEventListener(MouseEvent.MOUSE_OUT, sliderOut)
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
			
			//var div:Number = (Math.abs(_range[0]) / _range[1]) * (Math.abs(_range[0]) + _range[1]);
			var percent:Number = mcMath.roundTo(rider.x / (rails.width / 2), 2);
			if (percent >= 0){
				
				_val = mcMath.roundTo(percent * _range[1], 2);
				
			} else {
				
				_val = mcMath.roundTo(percent * Math.abs(_range[0]), 2);
			}
			//ftrace("div:% percent:% val:%",div, percent, _val);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function set value(val:Number):void {
			
			_val = mcMath.minMaxFrom(val, _range[0], _range[1]);
			moveRiderTo(_val);
		}
		
		private function moveRiderTo(val:Number):void {
			
			var percent:Number = 0;
			if (val >= 0){
				
				percent = val / _range[1];
				
			} else {
				
				percent = val / Math.abs(_range[0]);
			}
			rider.x = (rails.width/2) * percent;
		}
		
		public function get value():Number {
			
			return _val
		}
	}
}

