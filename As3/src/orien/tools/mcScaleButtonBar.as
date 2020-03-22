package orien.tools {
	
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import imost.InitAfterValidate;
	import orien.tools.mcCollect;
	import orien.tools.mcScaleButton;
	
	public class mcScaleButtonBar extends MovieClip {
		
		//interface parameters
		public var spaces:Number = 4;
		public var align:String = "left";
		public var margin:Number = 0;
		
		// public variables
		public var all_buttons:mcArray;
		
		public function mcScaleButtonBar() {
			
			all_buttons = new mcArray(mcCollect.byCondition(this, "prefix", "btn")); //must collect here
			//ftrace("mcScaleButtonBar > mcScaleButtonBar % > all_buttons:%", name, all_buttons.length)
			stage ? addToStage() : addEventListener(Event.ADDED_TO_STAGE, addToStage);
		}
		
		private function addToStage(e:Event = null):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, addToStage);
			new InitAfterValidate(this, "enabled", init); //wait for variable is accesible
		}
		
		private function init():void {
			
			anlignButtons();
		}
		
		private function anlignButtons():void {
			
			//arange buttons array from left or from right
			all_buttons.sortByDistance(align == "left" ? new Point() : new Point(barbg_01.width, 0));
			
			var start_x:Number = align == "left" ? margin : barbg_01.width - margin;
			for each (var btn:mcScaleButton in all_buttons.source) {
				
				if (align == "left") {
					
					//ftrace("mcScaleButtonBar > anlignButtons > x:% width:% text:%", btn.x, btn.width, btn.textLabel);
					btn.x = start_x;
					start_x = btn.x + btn.width + spaces;
					
				} else {
					
					btn.x = start_x - btn.width;
					start_x = btn.x - spaces;
				}
				
			}
		}
		
		public function hide():void {
			
			this.visible = false;
			this.alpha = 0;
		}
		
		public function show():void {
			
			this.visible = true;
			TweenLite.to(this, 0.8, {alpha: 1});
		}
		
		public function visibleButtons(switch_names:Array):void {
			
			for each (var btn:mcScaleButton in all_buttons.source) {
				
				btn.visible = switch_names.indexOf(btn.switch_type) != -1;
				
				btn.pressed = false;
				btn.textLabel = btn.button_label;
			}
			show();
		}
	}
}
