package orien.tools {
	
	import orien.tools.mcArray;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class COLUMN {
		
		var source:Object = new Object();
		var _index:int = 0;
		
		public function COLUMN(index:int, data:Object = null) {
			
			_index = index;
			if (data) source = data;
		}
		
		public function addData(data:Object, key:String):void {
			
			source[key] = data;
		}
		
		public function getData(key:String):* {
			
			return source[key];
		}
		
		public function shuffle(key:String):void {
			
			var item:Array = source[key] as Array;
			if (!item || item.length == 0) return;
			new mcArray(item).shuffle();
		}
		
		public function get index():int {
			
			return _index;
		}
	
	}
}

