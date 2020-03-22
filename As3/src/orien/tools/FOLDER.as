package orien.tools {
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 * @usage orien.tools.mcUMLTable
	 */
	public class FOLDER {
		
		private var _name:String;
		private var _text:String;
		private var _parent:String;
		private var _children:Array = [];
		
		public function FOLDER(name:String, text:String):void {
			
			_name = name;
			_text = text;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'FOLDER(card:' + this.name + ', text:' + this.text + ', parent:' + this.parent +  ', children:' + this.children.length + ')';
		}
		
		public function get text():String {
			
			return _text;
		}
		
		public function set text(value:String):void {
			
			_text = value;
		}
		
		public function get parent():String {
			
			return _parent;
		}
		
		public function set parent(value:String):void {
			
			_parent = value;
		}
		
		public function get children():Array {
			
			return _children;
		}
		
		public function set children(value:Array):void {
			
			_children = value;
		}
		
		public function get name():String {
			
			return _name;
		}
		
		public function set name(value:String):void {
			
			_name = value;
		}
	}
}