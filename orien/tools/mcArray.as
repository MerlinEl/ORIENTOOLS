package orien.tools {
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Kolomeets Alexander
	 * @author René Bača (Orien) 2015
	 */
	public class mcArray {
		/**
		 * DEBUG = int trace different functions
		 */
		public var DEBUG:int = 0
		public var source:Array = [];
		
		public function mcArray(data:Array = null, clone:Boolean = false) {
			
			if (data) clone ? mergeArray(data) : instanceArray(data);
		}
		
		private function instanceArray(data:Array):void {
			
			this.source = data
		}
		
		private function mergeArray(arr:Array):void {
			
			source = source.concat(arr);
		}
		
		public function get length():int {
			
			return source.length;
		}
		
		public function getItemAt(index:int):Object {
			
			return source[index];
		}
		
		public function removeItemAt(index:int):void {
			
			var result:Array = [];
			
			for (var i:int = 0; i < source.length; i++)
				if (i != index)
					result.push(source[i]);
			
			source = result;
		}
		
		public function removeItem(item:*):void {
			
			var result:Array = [];
			
			for (var i:int = 0; i < source.length; i++)
				if (item != source[i])
					result.push(source[i]);
			
			source = result;
		}
		
		public function addItem(item:*):void {
			
			//if (!contains(item) && item is Object) //not good at numerical array
			source.push(item);
		}
		
		public function addItemAt(item:*, index:int):void {
			
			if (contains(item))
				removeItem(item);
			
			var result:Array = [];
			
			if (index > source.length)
				index = source.length;
			
			var pushed:Boolean = false;
			
			for (var i:int = 0; i <= source.length; i++)
				if (i == index) {
					pushed = true;
					result.push(item);
				} else
					result.push(source[(pushed ? (i - 1) : i)]);
			
			source = result;
		}
		
		public function contains(item:*):Boolean {
			
			for each (var i:* in source)
				if (i == item)
					return true;
			
			return false;
		}
		
		public function toString():String {
			
			return String(source);
		}
		
		public function toArray():Array {
			
			return source;
		}
		
		public function toArrayClone():Array {
			
			var new_array:Array = new Array();
			for each (var item:* in source) {
				new_array.push(item);
			}
			return new_array;
		}
		
		public function getItemIndex(item:*):int {
			
			for (var i:int = 0; i < source.length; i++)
				if (getItemAt(i) == item)
					return i;
			return -1;
		}
		
		public function getItemIndexByPosition(pos_a:Point):int {
			
			for (var i:int = 0; i < source.length; i++) {
				var pos_b:Point = mcTran.pos(getItemAt(i)) as Point;
				if (pos_a.equals(pos_b)) return i;
			}
			return -1;
		}
		
		public function getFistItem():* {
			
			return source[0];
		}
		
		public function getLastItem():* {
			
			return source[source.length - 1];
		}
		
		public function getItemByName(str:String):* {
			
			for (var i:int = 0; i < source.length; i++)
				if (getItemAt(i).name == str)
					return getItemAt(i);
			return null;
		}
		
		public function collectParams(attr:String):Array {
			
			var params:Array = new Array();
			for each (var o:* in source) {
				
				params.push(mcCollect.getValueByParam(o, attr));
			}
			return params;
		}
		
		/**
		 * Collect values from objects by paramater, add array result to source
		 * @param	arr objects array
		 * @param	param parameter which contains wanted value
		 */
		public function extractItemsByParam(arr:Array, param:String):void {
			
			var obj_arr:Array = new Array();
			for each (var o:* in arr)
				if (o[param] != null)
					obj_arr.push(o[param]);
			source = obj_arr;
		}
		
		public function getUniqueName(name:String):String {
			
			var all_names:Array = getNames();
			if (DEBUG == 1) trace("compare name:" + name + " with children names:" + all_names)
			var new_name:String = name;
			while (all_names.indexOf(new_name) != -1) {
				
				new_name = mcString.versionUp(new_name);
				if (DEBUG == 1) trace("created new Name:" + new_name);
			}
			return new_name;
		}
		
		public function getNames():Array {
			
			var all_names:Array = new Array();
			for each (var o:* in source) all_names.push(o.name);
			return all_names;
		}
		
		public function getRandomItem():* {
			
			var random_pos:int = mcMath.randomRange(0, source.length - 1);
			return source[random_pos];
		}
		
		/**
		 * Elements between range [from, to] will remains. Rest will be deleted.
		 * Use only from, u get first n elements.
		 * @param	from start slice
		 * @param	to end slice
		 */
		public function extractItems(from:int, to:int = undefined):void {
			
			if (!to) { //get elements from begin
				source.splice(from, source.length);
			} else { //get middle part between [from - to]
				
				source.splice(to, source.length); //delete last part
				source.splice(0, from); //delete first part
			}
		}
		
		public function printParam(param:String):void {
			
			for each (var o:* in source) trace("Param:" + o[param]);
		}
		
		public function print():void {
			
			for each (var o:* in source) {
				
				trace("mcArray >>" + o);
				mcObject.print(o);
			}
		}
		
		public function clear():void {
			
			source = [];
		}
		
		public function sortByDistance(p:Point):void {
			
			var obj_arr:Array = new Array();
			for each (var o:* in source) {
				
				var dist:Number = mcMath.double(mcTran.twoPointsDistance(new Point(o.x, o.y), p));
				obj_arr.push({"obj": o, "dist": dist});
			}
			obj_arr.sortOn("dist", Array.NUMERIC); //1,2,3,4...
			extractItemsByParam(obj_arr, "obj"); //add to source only obj array
		}
		
		public function sortByAttribute(attr:String):void {
			
			source.sortOn(attr);
		}
		
		public function shuffle():void {
			
			source.sort(randomSort);
		}
		
		public function shift():* {
			
			return source.shift();
		}
		
		public function mergeItems(arrays:Array):void {
			
			for each (var o:* in arrays) source = source.concat(o);
		}
		
		public function pop():* {
			
			return source.pop();
		}
		
		private function randomSort(a:*, b:*):Number {
			
			if (Math.random() < 0.5) return -1;
			else return 1;
		}
	}
}