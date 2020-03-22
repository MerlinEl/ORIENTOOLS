package orien.tools {
	
	//Imports
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * @author René Bača (Orien) 2017
	 * @inspired http://kirill-poletaev.blogspot.cz/2012/10/advalert-as3-class-download-and-how-to.html
	 * @inspired http://sibirjak.com/osflash/blog/tutorial-creating-an-alert-box-with-the-as3commons-popupmanager/
	 */
	public class mcPopUp extends Sprite {
		
		//Public vars
		public static const ALERT:String = "alert";
		public static const PROMPT:String = "prompt"; //not used
		public static const YESNO:String = "yesno"; //not used
		public static const TYPE:String = "type"; //not used
		
		private var corner:Number = 12;
		
		//Local Vars
		protected var boxMsg:Sprite;
		protected var yesBtn:Sprite;
		protected var boxTitle:Sprite;
		protected var titleTf:TextField;
		protected var msgTf:TextField;
		protected var yesTf:TextField;
		protected var border:Number = 2;
		protected var fontList:Object = {"comic": "Comic Sans MS", "times": "Times New Roman"};
		protected var _container:DisplayObjectContainer;
		
		//Constructor  TODO: add clickCallback : Function
		public function mcPopUp(container:DisplayObjectContainer, msg:String, title:String = "", type:String = "alert", centred:Boolean = true, pos:Point = null, ...args):void {
			
			visible = false;
			_container = container;
			
			var formatTitle:TextFormat = new TextFormat();
			formatTitle.color = 0xFFFFFF;
			formatTitle.size = 18;
			formatTitle.font = fontList["comic"];
			formatTitle.bold = true;
			formatTitle.align = TextFormatAlign.CENTER;
			
			var formatMsg:TextFormat = new TextFormat();
			formatMsg.color = 0xD9EEFF;
			formatMsg.size = 17;
			formatMsg.font = fontList["times"];
			formatMsg.bold = false;
			formatMsg.leftMargin = 4;
			formatMsg.rightMargin = 4;
			
			var formatButtons:TextFormat = new TextFormat();
			formatButtons.color = 0xFFFFFF;
			formatButtons.size = 16;
			formatButtons.font = fontList["times"];
			formatButtons.bold = true;
			
			
			//Initialise Components
			boxMsg = new Sprite();
			yesBtn = new Sprite();
			boxTitle = new Sprite();
			titleTf = new TextField();
			msgTf = new TextField();
			yesTf = new TextField();
			
			yesTf.defaultTextFormat = formatButtons;
			yesTf.selectable = false;
			yesTf.autoSize = TextFieldAutoSize.CENTER;
			yesTf.selectable = false;
			yesTf.text = "OK"
			
			yesBtn.mouseEnabled = true;
			yesBtn.mouseChildren = false;
			yesBtn.buttonMode = true;
			
			titleTf.defaultTextFormat = formatTitle;
			titleTf.width = 300;
			titleTf.height = 32;
			titleTf.maxChars = 80;
			titleTf.wordWrap = false;
			titleTf.multiline = false;
			titleTf.selectable = false;
			titleTf.mouseEnabled = false;
			titleTf.text = title ? title : "";
			
			msgTf.defaultTextFormat = formatMsg;
			msgTf.width = titleTf.width;
			msgTf.autoSize = TextFieldAutoSize.LEFT;
			msgTf.wordWrap = true;
			msgTf.multiline = true;
			msgTf.selectable = false;
			
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
			
			//add embos to dialog
			var emb:BevelFilter = new BevelFilter(5, 45, 0xA6A4FF, 1, 0x5F67B8, 1, 2, 2, 0.5);
			var drs:DropShadowFilter = new DropShadowFilter(5, 45, 0x003366, 1, 5, 5, 0.7);
			filters = [emb, drs];
			
			switch (type) {
			
			case "alert": 
				Alert(msg, centred, pos);
				break;
			case "prompt": 
				break;
			case "yesno": 
				break;
			case "type": 
				break;
			}
		}
		
		//Boxes
		private function Alert(msg:String, centred:Boolean, pos:Point = null):void {
			
			visible = true;
			//setup data
			msgTf.text = msg;
			
			//Render			
			with (yesBtn.graphics) {
				clear()
				lineStyle(1, 0xAFACD5)
				beginFill(0x5E5EC6, 0.9)
				drawRoundRect(0, 0, 80, 28, corner)
				endFill()
			}
			
			with (boxMsg.graphics) {
				clear()
				lineStyle(1, 0xAFACD5)
				beginFill(0x6464C4, 0.9)
				drawRect(1, 0, msgTf.width-3, msgTf.height)
				endFill()
			}
			
			//Arange
			//rect.x + rect.width - 100, rect.y + rect.height - 40, 80, 20
			titleTf.x = border;
			titleTf.y = border + 2;
			boxMsg.x = border;
			boxMsg.y = titleTf.y + titleTf.height + border;
			yesBtn.x = boxMsg.width / 2 - yesBtn.width / 2;
			yesBtn.y = boxMsg.y + boxMsg.height + border + 4;
			yesTf.x = yesBtn.width / 2 - yesTf.width / 2;
			yesTf.y += 2;
			
			//render title bg
			with (boxTitle.graphics) {
				clear()
				beginFill(0xA6A4FF, 0.9)
				drawRoundRectComplex(3, 4, width - 2, titleTf.height, corner, 0, 0, 0)
				endFill()
			}
			
			//render bg
			with (graphics) {
				clear()
				lineStyle(2, 0x4D478D)
				beginFill(0x6464C4, 0.9)
				drawRoundRectComplex(0, 0, width + border + 2, height + border * 3 + 4, corner, 0, 0, corner); // new age design
				endFill()
			}
			
			if (centred) centerToStage();
			if (pos) moveTo(pos);
			_container.addChild(this);
		}
		
		private function Prompt(msg:String, title:String, centred:Boolean, pos:Point = null):void {
		
		}
		
		//Functions
		private function leave(e:MouseEvent):void {
			
			stopDrag();
		}
		
		private function drag(e:MouseEvent):void {
			
			startDrag();
		}
		
		private function moveTo(pos:Point):void {
			
			x = pos.x;
			y = pos.y;
		}
		
		private function centerToStage():void {
			
			ftrace("w:% h:%", _container.stage.stageWidth, _container.stage.stageHeight)
			x = _container.stage.stageWidth / 2 - width / 2;
			y = _container.stage.stageHeight / 2 - height / 2;
		}
		
		//Handlers
		protected function yesClickHandler(e:MouseEvent):void {
			
			visible = false;
		}
		
		protected function yesOverHandler(e:MouseEvent):void {
		
		}
	}
}

/*
import orien.tools.mcPopUp;

var msg:String = "After you have to do something realy nice."
var abox:mcPopUp = new mcPopUp(stage, msg, "Allert message:", mcPopUp.ALERT, true); //show centred in to stage
var abox:mcPopUp = new mcPopUp(stage, msg, "Alert message:", mcPopUp.ALERT, false, new Point(200, 0)); //show positioned
*/