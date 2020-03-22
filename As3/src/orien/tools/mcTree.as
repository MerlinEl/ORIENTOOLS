package orien.tools { //Not Used
	
	/**
	 * ...
	 * @author Orien
	 */
	public class mcTree {
		
		private var DATA:Object = {};
		
		public function mcTree():void {
		
		/*usage:
		   add("card.bg", 0x3A94ED);
		   add("card.border", 0x225088);
		   add("card.label_1.text", 0x293E74);
		   trace("test:"+DATA.card.bg.value);*/
		}
		
		public function get(path:String):* { //can return Number, int, uint, atd...
			
			var path_arr:Array = path.split(".");
			//trace("path:"+path_arr)
			if (path_arr.length == 0) return null;
			var o:Object = DATA;
			for each (var key:String in path_arr) {
				
				if (o[key]) o = o[key];
					//trace("search key:"+key+" found:"+o)
			}
			return o ? o.value : null;
		}
		
		public function add(path:String, value:*):void {
			
			var name:String, o:Object = DATA;
			var arr:Array = path.split(".");
			
			for (var i:int = 0; i < arr.length; i++) {
				
				//trace("check key:"+name)
				name = arr[i]
				
				if (!o[name]) {
					//trace("add missing key:"+name)
					o[name] = {};
				}
				o = o[name];
				o["level"] = i + 1; //how deeep object is
				if (i == arr.length - 1) o.value = value;
			}
		}
		
		public function print(obj:Object = null):void {
			
			if (!obj) obj = DATA;
			for (var key:String in obj) {
				
				var o:Object = obj[key];
				var tab:String = tabs(obj["level"] as int);
				trace(tab + "key:" + key + " value:" + o);
				if (o) print(o);
			}
		}
		
		private function tabs(cnt:int):String {
			
			var tab:String = "";
			for (var i:int = 0; i < cnt; i++) tab += "\t";
			return tab;
		}
	}
}