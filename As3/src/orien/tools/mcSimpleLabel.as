package orien.tools {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class mcSimpleLabel extends MovieClip {
		
		//interface components
		public var tField:TextField;
		
		public function mcSimpleLabel() {
			
			// constructor code
			var tf:TextFormat = new TextFormat();
			tf.color = 0xA95AD3;
			tField.setTextFormat(tf);
			tField.type = TextFieldType.DYNAMIC;
			tField.autoSize = "left";
			tField.selectable = true;
			tField.multiline = true;
			tField.wordWrap = true;
			tField.border = true
			tField.borderColor = 0x525298;
			tField.background = true;
			tField.backgroundColor = 0xF7F3D2;
		}
		
		public function get text():String {
			
			return tField.text;
		}
		
		public function set text(value:String):void {
			
			tField.text = value;
		}
		
		/**
		   var text_box:txtLabel = new txtLabel();
		   text_box.initParams({"x":0, "y":0, "name":"text_box"});
		   addChild(text_box);
		 */
		public function initParams(settings:Object):void {
			
			if (settings["x"]) this.x = settings["x"];
			if (settings["y"]) this.y = settings["y"];
			if (settings["name"]) this.name = settings["name"];
		}
	}
}
