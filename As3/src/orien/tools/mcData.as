package orien.tools {
	
	public class mcData {
		
		private var _data:Object;
		
		/**
		 * Create collection from key and value
		 * addItem
		 * getItem
		 * removeItem
		 * length
		 * contains
		 * @usage
		   import orien.tools.mcData;
		   var data:mcData = new mcData({
		   
				"one":156,
				"two":56.28,
				"three":"Heloo there I'm you data Collection."
			});
		   //OR//
		   var data:mcData = new mcData();
		   data.addItem("one", 156);
		   data.addItem("two", 56.28);
		   data.addItem("three", "Heloo there I'm you data Collection.");
		   data.addItem("four", "I wil be deleted.");
		   data.removeItem("four");
		   data.print();
		
		   ftrace("tree items:% contains key two? % four? %", data.length, data.contains("two"), data.contains("four"))
		
		   var val_3:String = data.getItem("three") as String;
		   ftrace("val_3:%", val_3)
		 */
		public function mcData(obj:Object = null):void {
			
			_data = new Object();
			if (obj){
				
				for (var key:String in obj) _data[key] = obj[key];
			}
			//_data = obj ? obj : new Object();
		}
		
		public function get items():Object {
			
			return _data;
		}
		
		public function set items(data:Object) {
			
			_data = data;
		}
		
		public function get length():Number {
			
			var cnt:int = 0;
			for (var k:String in _data) cnt++;
			return cnt;
		}
		
		public function contains(key:String):Boolean {
			
			return (_data[key] != undefined);
		}
		
		public function addItem(key:String, val:*) {
			
			_data[key] = val; //add new obj at defined key
		}
		
		public function getItem(key:String):* {
			
			var val:*;
			for (var k:String in _data) {
				
				if (k == key) {
					val = _data[k];
					break;
				}
			}
			return val;
		}
		
		public function removeItem(key:String) {
			
			if (_data[key] == null) {
				
				trace("Item:["+key+"] not found.")
				return;
			}
			_data[key] = undefined; //empty container at given key
			delete _data[key]; //remove key from _data
		}
		
		public function print(obj:Object = null):void {
			
			if (!obj) obj = _data;
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