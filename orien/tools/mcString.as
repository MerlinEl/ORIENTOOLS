package orien.tools {
	import flash.display.DisplayObjectContainer
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author René Bača (Orien)
	 */
	public class mcString {
		private static var max_try:int = 10;
		/**
		 * DEBUG = int trace different functions
		 */
		public static var DEBUG:int = 0
		
		public function mcString() {
		
		}
		
		/**
		 *Incerase name version _01 to _02, _03, _04.. This depend on identical names found in container
		 * DEBUG = 1;
		 * @param	container movieclip or sprite, etc...
		 * @param	name card_01,
		 * @return	new unique name
		 * @example getUniqueName(this, "card_01")
		 */
		public static function getUniqueName(container:DisplayObjectContainer, name:String):String {
			
			if (!container || !name) return "error: getUniqueName missing parameter(s)."
			
			var names:Array = mcCollect.byCondition(container, "part_names", name.split("_")[0]);
			
			if (DEBUG == 1) trace("compare name:" + name + " with children names:" + names)
			
			var new_name:String = name;
			while (names.indexOf(new_name) != -1) {
				
				new_name = versionUp(new_name);
				if (DEBUG == 1) trace("created new Name:" + new_name);
			}
			return new_name;
		}
		
		/**
		 *Apend a number _01 after string or replace it with higer _02, 03....
		 * @param	name
		 * @return	String
		 */
		static public function versionUp(name:String):String {
			
			var new_name:String = name;
			var version:String = "01";
			var last_underscore:Number = new_name.lastIndexOf("_");
			if (last_underscore == -1) { //if string have no version
				new_name += "_";
				last_underscore = new_name.length;
			} else {
				
				var num:Number = Number(new_name.substring(last_underscore + 1, new_name.length));
				version = num ? numToString(num + 1) : "01";
				new_name = new_name.substring(0, last_underscore);
			}
			return new_name + "_" + version;
		}
		
		public static function numToString(num:Number):String {
			
			return (num < 10 ? "0" + String(num) : String(num));
		}
		
		/**
		 * Convert string to object (one level for now)
		 * @param	str content of: arrays, strings, numbers
		 * @return	Object
		 * @example	var catalog:Object = toObject("{par1:123, par2:abcde, par4:[1,2,3,4], par5:[a,2,3re, omega, plus, 456.57]}")
		 *
		   import orien.tools.mcString;
		   import orien.tools.mcObject;
		   var str_obj:String = "{par1:123, par2:abcde, par4:[1,2,3,4], par5:[a,2,3re, omega, plus, 456.57]}"
		   var o:Object = mcString.toObjectSimple(str_obj)
		   var ob:Object = {"a":1, "b":156, "c":[1,2,3]}
		   trace("PRINT OBJECT.......\n")
		   mcObject.print(ob)
		 */
		public static function toObjectSimple(str:String):Object {
			
			var new_obj:Object = new Object();
			var dividers:Array = ["{", "}", "(", ")", "[", "]", ":", ","];
			str = trimWhiteSpacesBeforeAfterDividers(str, dividers);
			//trace("trimmed string:" + str);
			var progress:int = 0;
			//trace("convert string obj:" + str);
			//construct
			while (progress < str.length) {
				
				//teake each char from string
				var char:String = str.charAt(progress);
				if (DEBUG == 2) trace("while next char:" + char + " at:" + progress);
				//acording type do action
				switch (char) {
				
				case "{": //obj begin
					progress = fillObjectWith(new_obj, str, char, progress);
					break;
				case ",": //obj next element
					progress = fillObjectWith(new_obj, str, char, progress);
					break;
				case "}": //obj end
					progress = str.length;
					break;
				}
				progress++;
			}
			return new_obj;
		}
		
		static private function fillObjectWith(new_obj:Object, str:String, char:String, progress:int):int {
			
			var val:String = undefined;
			var key:String = getObjKeyAtPos(str, progress + 1); //progress to next char after {
			if (key) {
				
				progress = str.indexOf(":", progress); //get begin of value
				if (progress == -1) {
					errorMsg(1); //bad string syntax
					return progress = str.length;
				}
				progress++; //progress to next char after :
				val = getObjValueAtPos(str, progress);
				if (!val) {
					errorMsg(1); //bad string syntax
					return progress = str.length;
				}
				progress += val.length - 1;
				if (DEBUG == 2) trace("\tkey:" + key + " val:" + val);
				//assing new object with value (Number, String, Boolean, Array or Object)
				new_obj[key] = convertToType(val);
				
			} else {
				errorMsg(1); //bad string syntax
				return progress = str.length;
			}
			return progress;
		}
		
		static private function convertToType(str:String):* {
			
			//TODO recursive call if is Object
			if (str.charAt(0) == "[") return toArray(str);
			if (str.charAt(0) == "{") return str; //late call this recursive, to get true object; 
			if (str.indexOf("..."   ) != -1) return rangeToNumbers(str);
			if (str.indexOf("true"  ) != -1) return true;
			if (str.indexOf("false" ) != -1) return false;
			if (isNaN(Number(str))) return String(str);
			return Number(str);
		}
		
		static public function toArray(str:String):Array {
			
			//temove braces if exists
			if (str.charAt(0) == "[") str = str.substring(1, str.length);
			if (str.charAt(str.length - 1) == "]") str = str.substring(0, str.length - 1);
			//split to array
			return str.split(",");
		}
		/**
		 * Conver string Object in to Point
		 * @param	str "(x=1, y=56)" or "1,56"
		 * @return	new Point(x, y)
		 */
		static public function toPoint(str:String):Point {
			
			str = trimWhiteSpaces(str);
			if (str.charAt(0) == "("){ //"(x=1, y=2)"
				
				var pos_x:int = str.indexOf("x=");
				var pos_y:int = str.indexOf("y=");
				if (pos_x == -1 || pos_y  == -1) return null; //is not point data 
				var num_x:Number = Number(str.substring(pos_x + 2, str.indexOf(",")));
				var num_y:Number = Number(str.substring(pos_y + 2, str.indexOf(")")));
				if (isNaN(num_x) || isNaN(num_y)) return null; //is not point data 
				return new Point(num_x, num_y);
			}
			if (str.indexOf(",") == -1) return null; //is not point data
			var arr:Array = str.split(","); //"1,2"
			if (isNaN(Number(arr[0])) || isNaN(Number(arr[1]))) return null; //is not point data 
			return new Point(arr[0], arr[1]);
		}	
		
		/**
		 * Remove white spaces before and after for each special character
		 * @param	str	String
		 * @param	dividers array of special characters, like ["{", "}", ":", ","];
		 * @return	String
		 */
		static public function trimWhiteSpacesBeforeAfterDividers(str:String, dividers:Array):String {
			
			for each (var d:String in dividers) {
				
				var index:int = 0
				do {
					
					index = str.indexOf(d, index);
					if (index != -1) {
						
						//trace("got char:", d, "at:", index)
						var new_str:String = trimBackForwardForCharSpacesAt(str, index);
						//if spaces replaced
						if (str.length > new_str.length) str = new_str;
						index++;
					}
					
				} while (index != -1)
			}
			return str;
		}
		
		/**
		 * Remove spaces before and after a Character by given position
		 * @param	str String
		 * @param	pos character position
		 * @return	String
		 */
		static public function trimBackForwardForCharSpacesAt(str:String, pos:int):String {
			
			var trim_start:int = pos;
			var trim_end:int = pos;
			var special_char:String = str.substring(pos, pos + 1);
			//trace("keep special char:", special_char)
			//search for space forward
			do {
				var next_space:String = str.charAt(trim_end + 1);
				if (next_space == " ") trim_end++;
				
			} while (next_space == " ");
			//search for space backward
			do {
				var prev_space:String = str.charAt(trim_start - 1);
				if (prev_space == " ") trim_start--;
				
			} while (prev_space == " ");
			//trace("Trim from:", trim_start, "to:", trim_end)
			//replace spaces with special char
			if (trim_end != trim_start) {
				
				var a:String = str.substring(0, trim_start);
				var b:String = str.substring(trim_end + 1, str.length);
				str = a + special_char + b;
			}
			return str;
		}
		
		/**
		 * Remove white spaces in a String
		 * @param	str String with spaces
		 * @return	String without spaces
		 */
		static public function trimWhiteSpaces(str:String):String {
			
			if (!str || str.length == 0) return undefined;
			var rex:RegExp = /[\s\r\n]+/gim;
			return str.replace(rex, '');
		}
		
		/*static public function trimWhiteSpaceFrontBack(str:String):String{
		
		   var rex:RegExp /^\s*|\s*$/gim;
		   return str.replace(rex,'');
		   }*/
		
		/**
		 * Get from string a value at given position
		 * @param	str String input
		 * @param	start from where we start search for value(s)
		 * @return	String
		 */
		static private function getObjValueAtPos(str:String, start:int):String {
			
			//TODO multi here or top of script
			//if is multi Array
			//if is milti Object
			
			//if str is Array
			if (str.charAt(start) == "[") {
				if (DEBUG == 2) trace("getObjValueAtPos >> is array:" + start)
				return str.substring(start, str.indexOf("]", start) + 1);
			}
			//if str is Object
			if (str.charAt(start) == "{") { //if is Array
				if (DEBUG == 2) trace("getObjValueAtPos >> is object:" + start)
				return str.substring(start, str.indexOf("}", start) + 1);
			}
			if (DEBUG == 2) trace("start:" + start + " >>" + str.substring(start, str.length))
			
			//if str is String or Number
			var end:int = str.indexOf("}", start);
			return str.substring(start, end);
		}
		
		/**
		 * Print to log an error message
		 * @param	type
		 */
		static private function errorMsg(type:Number):void {
			
			var msg:String = "";
			switch (type) {
			
			case 1: 
				msg = "Can't convert String to Object. Invalid structure."
				break;
			}
			trace(msg);
		}
		
		static private function getObjKeyAtPos(str:String, start:int):String {
			
			var end:int = str.indexOf(":", start);
			return str.substring(start, end);
		}
		
		static public function getSize(str:String, format:TextFormat = null, font_name:String = "Times New Roman"):Object {
			
			if (format == null) {
				
				format = new TextFormat();
				format.size = 12;
				format.align = TextFormatAlign.LEFT;
				format.font = font_name;
				format.rightMargin = 1;
			}
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.multiline = false;
			tf.wordWrap = false;
			tf.text = str;
			// add 2 pixels-gutters left & right
			return {"width": tf.textWidth + 4, "height": tf.textHeight};
		}
		
		/**
		 * Convert String numbers in to Array of numbers
		 * @param	data string "1, 2, 3...8, 45"
		 * @return	array of numbers
		 */
		static public function rangeToNumbers(data:String):Array {
			
			var nums:Array = new Array();
			data = trimWhiteSpaces(data);
			var data_array:Array = data.split(",");
			for each (var str:String in data_array) {
				
				if (str.indexOf("...") != -1) { //is range "1...5"
					
					var range:Array = str.split("...");
					var num_a:Number = range[0];
					var num_b:Number = range[1];
					if (num_a > num_b) continue; //prevent reverse 8...2
					nums = nums.concat(mcMath.numbersInRange(num_a, num_b));
					
				} else if (isNumber(str)) { //is number
					
					nums.push(Number(str));
				}
			}
			return nums;
		}
		
		static public function isNumber(str:String):Boolean {
			
			return !isNaN(Number(str));
		}
	}
}