package orien.tools { //not used for now
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcConsole extends Sprite{
		
		private var _min_w:Number = 100;
		private var _min_h:Number = 50;
		private var _title_bar_height:Number = 20
		private var _margin_l:Number = 4;
		private var _margin_t:Number = 4;
		
		private var _msgText:TextField;
		private var _titleBar:TextField;
		private var _scene:DisplayObjectContainer;
		
		public function mcConsole(scene:DisplayObjectContainer, msg:*, title:String = "Console", on_top:Boolean = true, hidden:Boolean = false):void {
			
			this.visible = !hidden;
			_scene = scene;
			
			_msgText = new TextField();
			_titleBar = new TextField();
			
			var tf_01:TextFormat = new TextFormat();
			tf_01.color = 0xAA0000;
			tf_01.size = 14;
			
			var tf_02:TextFormat = new TextFormat();
			tf_02.color = 0xFFFF00;
			tf_02.size = 14;
			tf_02.bold = true;
			tf_02.align = TextFormatAlign.CENTER;
			
			//setup TextFields
			_msgText.name = "msg";
			_msgText.autoSize = "left";
			_msgText.width = scene.stage.stageWidth;
			_msgText.selectable = true;
			_msgText.type = TextFieldType.INPUT;
			_msgText.multiline = true;
			_msgText.wordWrap = true;
			_msgText.border = true
			_msgText.background = true;
			_msgText.backgroundColor = 0xFFFF00;
			_msgText.setTextFormat(tf_01);
			_msgText.text = msg;
			
			_titleBar.selectable = false;
			_titleBar.background = true;
			_titleBar.backgroundColor = 0x0099CC;
			_titleBar.border = true;
			_titleBar.borderColor = 0x006699;
			_titleBar.width = Math.max(_min_w - _margin_t * 2, _msgText.width);
			_titleBar.height = _title_bar_height;
			_titleBar.alpha = .8
			_titleBar.setTextFormat(tf_02);
			_titleBar.text = title;
			
			var box_w = Math.max(_min_w, _msgText.width + _margin_l * 2);
			var box_h = Math.max(_min_h, _msgText.height + _titleBar.height + _margin_t * 3);
			
			//Render BOX
			name = "box";
			with (graphics) {
				lineStyle(2, 0x006699)
				beginFill(0xB5D0DF, 0.6)
				drawRect(0, 0, box_w, box_h)
				endFill()
			}
			
			//align elements
			_titleBar.x = _margin_l;
			_titleBar.y = _margin_t;
			_msgText.x = _margin_l;
			_msgText.y = _titleBar.height + _margin_t * 2;
			
			addChild(_msgText);
			addChild(_titleBar);
			if (!on_top) this.y = scene.stage.stageHeight - this.height;
			_scene.addChild(this);
			
			//Events
			_titleBar.addEventListener(MouseEvent.RIGHT_CLICK, hide, false, 0, true);
			_titleBar.addEventListener(MouseEvent.MOUSE_DOWN, drag, false, 0, true);
			_titleBar.stage.addEventListener(MouseEvent.MOUSE_UP, leave, false, 0, true);
		}
		
		//private functions
		private function drag(e:MouseEvent):void {
			
			//startDrag(false, getRect(_scene));
			startDrag();
		}
		
		private function leave(e:MouseEvent):void {
			
			stopDrag();
		}
		
		//public functions
		public function log(msg:String):void {
			
			_msgText.appendText("\n" + msg);
		}
		
		public function clear():void {
			
			_msgText.text = "";
		}
		
		public function hide(e:MouseEvent = null):void {
			
			visible = false;
		}
		
		public function show():void {
			
			visible = true;
		}
		
		public function close(e:MouseEvent):void {
			
			_titleBar.removeEventListener(MouseEvent.RIGHT_CLICK, close);
			_titleBar.removeEventListener(MouseEvent.MOUSE_DOWN, drag);
			_titleBar.stage.removeEventListener(MouseEvent.MOUSE_UP, leave);
			_scene.removeChild(this);
		}
	}

}
