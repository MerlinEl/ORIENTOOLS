package orien.tools { //Not Used Not Finished
	
	//Imports
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	//Class
	public class mcDialog extends Sprite {
		
		//Vars
		protected var _rect:Rectangle;
		protected var _alertBox:Shape;
		protected var _yesBtn:Sprite;
		protected var _stage:DisplayObjectContainer;
		protected var _centred:Boolean;
		protected var _textField:TextField;
		
		/**
		 * @example var dia:mcDialog = new mcDialog(this, null, true);
		 * @example dia.AlertBox();
		 * @param	container
		 * @param	rect
		 * @param	centred
		 */
		public function mcDialog(container:DisplayObjectContainer, rect:Rectangle = null, centred:Boolean = false):void {
			
			_stage = container;
			_rect = rect ? rect : new Rectangle(0, 0, 200, 100);
			_centred = centred;
		}
		
		public function AlertBox():void {
			
			//Initialise
			_alertBox = new Shape()
			_yesBtn = new Sprite()
			_textField = new TextField();
			addChild(_alertBox)
			addChild(_yesBtn)
			
			//Render
			with (_alertBox.graphics) {
				lineStyle(1, 0x5974A6)
				beginFill(0x7E9EDA, 0.7)
				drawRect(_rect.x, _rect.y, _rect.width, _rect.height)
				endFill()
			}
			
			with (_yesBtn.graphics) {
				lineStyle(1, 0x5974A6)
				beginFill(0xA6B4EC, 1)
				drawRect(_rect.x + _rect.width - 100, _rect.y + _rect.height - 40, 80, 20)
				endFill()
			}
			_yesBtn.buttonMode = true;
			
			_textField.text = "OK";
			_textField.selectable = false;
			_textField.mouseEnabled = false;
			ftrace("ok btn pos:%", mcTran.pos(_yesBtn))
			mcTran.pos(_textField, new Point(_rect.x + _rect.width - 100, _rect.y + _rect.height - 40));
			addChild(_textField);
			
			//Events
			_yesBtn.addEventListener(MouseEvent.CLICK, yesClickHandler, false, 0, true);
			_yesBtn.addEventListener(MouseEvent.MOUSE_OVER, yesOverHandler, false, 0, true);
			
			ftrace("root:%", root)
			if (_centred) centerTo(_stage);
			_stage.addChild(this)
		}
		
		protected function centerTo(stage:DisplayObjectContainer):void {
			
			ftrace("stage size:%", mcTran.pos(stage))
			this.x = stage.x + stage.width / 2;
			this.y = stage.y + stage.height / 2;
		}
		
		//Handlers
		protected function yesClickHandler(e:MouseEvent):void {
		
			ftrace("click")
			_stage.removeChild(this);
		}
		
		protected function yesOverHandler(e:MouseEvent):void {
		
		}
	}
}