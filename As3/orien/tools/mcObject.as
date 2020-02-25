package orien.tools {
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2015
	 */
	public class mcObject {
		
		public function mcObject() {
		
		}
		
		static public function length(obj:Object):uint {
			
			var len:uint = 0;
			for (var s:* in obj) len++;
			return len;
		}
		
		static public function print(obj:Object, level:int = 0):void {
			
			for (var key:String in obj) {
				
				var val:Object = obj[key];
				var t:String = tabs(level);
				trace(t + "key:" + key + " value:" + val);
				if (!isEmpty(val)) {
					print(val, level + 1);
				}
			}
		}
		
		static public function isEmpty(obj:Object):Boolean {
			
			var is_empty:Boolean = true;
			for (var n:* in obj) {
				is_empty = false;
				break;
			}
			return is_empty;
		}
		
		static private function tabs(cnt:int):String {
			
			var tab:String = "";
			for (var i:int = 0; i < cnt; i++) tab += "\t";
			return tab;
		}
		
		static public function twoObjectsDistance(obj1:Object, obj2:Object):Number {
			
			var p1:Point = new Point(obj1.x, obj1.y);
			var p2:Point = new Point(obj2.x, obj2.y);
			return mcTran.twoPointsDistance(p1, p2);
		}
		
		static public function cloneTextFormat(tf:TextFormat):TextFormat {
			
			var new_tf:TextFormat = new TextFormat();
			var props:Array = ["font", "size", "color", "bold", "italic", "underline", "url", "target", "align", "leftMargin", "rightMargin", "indent", "leading"]
			for each (var p:String in props) {
				//trace("prop:" + p)
				new_tf[p] = tf[p];
			}
			return new_tf;
		}
		
		/*function cloneFormat(o:*):* {
			
			var obj:Object = getByteArray(o); // this returns null on MovieClips
			return obj;
		}
		
		function getByteArray(obj:Object) {
			
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(obj);
			byteArray.position = 0;
			return byteArray.readObject()
		}*/
	}
}