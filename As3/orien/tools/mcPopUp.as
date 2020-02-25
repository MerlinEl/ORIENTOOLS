package orien.tools {
	
	//Imports
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	//Class
	public class mcPopUp extends Sprite {
		private var corner:Number = 12;
		
		//Vars
		protected var boxMsg:Sprite;
		protected var yesBtn:Sprite;
		protected var boxTitle:Sprite;
		protected var titleTf:TextField;
		protected var msgTf:TextField;
		protected var yesTf:TextField;
		protected var border:Number = 2;
		protected var fontList:Object = {"comic": "Comic Sans MS", "times": "Times New Roman"};
		protected var formatTitle:TextFormat;
		protected var formatMsg:TextFormat;
		
		//Constructor
		public function mcPopUp():void {
			
			visible = false;
			formatTitle = new TextFormat();
			formatTitle.color = 0x453D72;
			formatTitle.size = 18;
			formatTitle.font = fontList["comic"];
			formatTitle.bold = true;
			formatTitle.align = "center";
			
			formatMsg = new TextFormat();
			formatMsg.color = 0x5664A3;
			formatMsg.size = 14;
			formatMsg.font = fontList["times"];
			formatMsg.bold = false;
			
			//Initialise Components
			boxMsg = new Sprite();
			yesBtn = new Sprite();
			boxTitle = new Sprite();
			titleTf = new TextField();
			msgTf = new TextField();
			yesTf = new TextField();
			
			yesTf.selectable = false;
			yesTf.autoSize = "left";
			yesTf.selectable = false;
			
			yesBtn.mouseEnabled = true;
			yesBtn.mouseChildren = false;
			yesBtn.buttonMode = true;
			
			titleTf.defaultTextFormat = formatTitle;
			titleTf.autoSize = "left";
			titleTf.multiline = false;
			titleTf.selectable = false;
			titleTf.mouseEnabled = false;
			
			msgTf.defaultTextFormat = formatMsg;
			msgTf.autoSize = "left";
			msgTf.multiline = true;
			msgTf.selectable = true;
			
			//Add components
			boxMsg.addChild(msgTf);
			yesBtn.addChild(yesTf);
			addChild(boxTitle);
			addChild(titleTf);
			addChild(boxMsg);
			addChild(yesBtn);
			
			//Events
			yesBtn.addEventListener(MouseEvent.CLICK, yesClickHandler, false, 0, true)
			yesBtn.addEventListener(MouseEvent.MOUSE_OVER, yesOverHandler, false, 0, true)
			boxTitle.addEventListener(MouseEvent.MOUSE_DOWN, drag);
			boxTitle.addEventListener(MouseEvent.MOUSE_UP, leave);
			boxTitle.buttonMode = true;
		}
		
		//Boxes
		public function Alert(title:String, msg:String):void {
			
			visible = true;
			hideOthers("alert");
			
			//setup data
			titleTf.text = title;
			msgTf.text = msg;
			yesTf.text = "OK"
			
			//Render			
			with (yesBtn.graphics) {
				clear()
				lineStyle(1, 0x537DDF)
				beginFill(0x89B7EF, 0.4)
				drawRoundRect(0, 0, 80, 22, corner)
				endFill()
			}
			
			with (boxMsg.graphics) {
				clear()
				lineStyle(1)
				beginFill(0xCEEFFF, 0.4)
				drawRect(0, 0, msgTf.width, msgTf.height)
				endFill()
			}                             

			//Arange
			//rect.x + rect.width - 100, rect.y + rect.height - 40, 80, 20
			titleTf.x = border;
			titleTf.y = border;
			boxMsg.x = border;
			boxMsg.y = titleTf.y + titleTf.height + border;
			yesBtn.x = border + 4;
			yesBtn.y = boxMsg.y + boxMsg.height + border + 4;
			yesTf.x = yesBtn.width / 2 - yesTf.width / 2;
			yesTf.y += 2; 
			
			//render title bg
			with (boxTitle.graphics) {
				clear()
				beginFill(0x495FF3, 0.4)
				drawRoundRectComplex(0, 0, width + border, titleTf.height + 2, corner, corner, 0, 0)
				endFill()
			}
			
			//render bg
			with (graphics) {
				clear()
				lineStyle(1)
				beginFill(0xA5A0DC, 0.6)
				drawRoundRectComplex(0, 0, width + border, height + border * 3, corner, corner , corner, corner);
				endFill()
			}
			
			setPos();
		}
		
		private function leave(e:MouseEvent):void {
			
			stopDrag();
		}
		
		private function drag(e:MouseEvent):void {
			
			startDrag();
		}
		
		private function setPos():void {
			
			x = parent.width / 2 - width / 2;
			y = parent.height / 2 - height / 2;
		}
		
		protected function hideOthers(string:String):void {
		
		}
		
		//Handlers
		protected function yesClickHandler(e:MouseEvent):void {
			
			visible = false;
		}
		
		protected function yesOverHandler(e:MouseEvent):void {
		
		}
	}
}