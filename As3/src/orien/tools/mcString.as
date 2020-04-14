package orien.tools {
	import flash.display.DisplayObjectContainer
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import mcs.MathExample;
	
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
		public static var thin_space:String = " ";
		
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
		
		public static function getNumbers(str:String):Array{
			
			var pattern:RegExp = /\d+/g ; // a regular expression that matches numbers
			return(str.match(pattern));
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
		 * Multiply str in by count 
		 * @param	str
		 * @param	cnt
		 * @return
		 */
		public static function Multiply(str:String, cnt:int):String {
			
			var new_str:String = "";
			for (var i:int = 0; i < cnt; i++) new_str += str;
			return new_str;
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
			
			if (!str || str.length == 0) return new Object();
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
			if (str.indexOf("...") != -1) return rangeToNumbers(str);
			if (str.indexOf("true") != -1) return true;
			if (str.indexOf("false") != -1) return false;
			if (isNaN(Number(str))) return String(str);
			return Number(str);
		}
		
		/**
		 * @example "[1,2,3]" == [1,2,3]
		 * @param	str
		 * @return
		 */
		static public function toArray(str:String):Array {
			
			//remove white spaces at begin and end (15.11.2016)
			str = trimWhiteSpaceFrontBack(str);
			//temove braces if exists
			if (str.charAt(0) == "[") str = str.substring(1, str.length);
			if (str.charAt(str.length - 1) == "]") str = str.substring(0, str.length - 1);
			//remove any spaces before and after comma
			str = trimWhiteSpacesBeforeAfterDividers(str, [","]);
			//split to array
			return str.split(",");
		}
		
		/**
		 * @example "{x:1, y:2, z:3}, {name:John, surname:Deep}" == [{x:1, y:2, z:3}, {name:John, surname:Deep}]
		 * @param	str
		 * @return
		 */
		static public function toSimpleObjArray(str:String):Array {
			
			//remove white spaces at begin and end (15.11.2016)
			str = trimWhiteSpaceFrontBack(str);
			//temove braces if exists
			if (str.charAt(0) == "{") str = str.substring(1, str.length);
			if (str.charAt(str.length - 1) == "}") str = str.substring(0, str.length - 1);
			//remove any spaces before and after comma
			str = trimWhiteSpacesBeforeAfterDividers(str, [","]);
			//split to object array
			var arr:Array = str.split("},{");
			//convert all "{string, objects}" in to objects {key: val:}
			for (var i:int = 0; i < arr.length; i++){
				
				var o:Object = new Object();
				var data_arr:Array = arr[i].split(",");
				for each (var s:String in data_arr){
					
					var key:String = s.split(":").shift();
					var val:String = s.split(":").pop();
					//ftrace("compile object key:% val:%", key, val)
					o[key] = val;
				}
				arr[i] = o;
			}
			return arr;
		}
		
		/**
		 * Conver string Object in to Point
		 * @param	str "(x=1, y=56)" or "1,56"
		 * @return	new Point(x, y)
		 */
		static public function toPoint(str:String):Point {
			
			str = trimWhiteSpaces(str);
			if (str.charAt(0) == "(") { //"(x=1, y=2)"
				
				var pos_x:int = str.indexOf("x=");
				var pos_y:int = str.indexOf("y=");
				if (pos_x == -1 || pos_y == -1) return null; //is not point data 
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
			
			//ftrace("str: % div: %", str, dividers);
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
		
		static public function trimWhiteSpaceFrontBack(str:String):String {
			
			return str.replace(/^\s+|\s+$/g, "");
		}
		
		static public function trimWhiteSpaceFront(str:String):String {
			
			return str.replace(/\s+/, "");
		}
		
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
		 * Count how many times is pattern present in given string
		 * @param	str target string
		 * @param	pattern search string
		 * @return	int how many times is pattern present in target str
		 */
		static public function getOccurences(str:String, pattern:String):int {
			
			return str.match(new RegExp(pattern, "g")).length;
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
		
		/**
		 * Recognize if all letters in string is lowercase
		 * @param	str
		 * @return
		 */
		static public function isLowerCase(str:String):Boolean{
			
			if (str.length == 1){
				
				return str == str.toLowerCase();
				
			} else {
				
				for (var i:int = 0; i < str.length; i++){
					
					var char:String = str.charAt(i) as String;
					if (char != char.toLowerCase()) return false; 
				}
			}
			return true;
		}
		
		static public function isValidEmail(email:String):Boolean {
			
			var emailExpression:RegExp = /([a-z0-9._-]+?)@([a-z0-9.-]+)\.([a-z]{2,4})/;
			return emailExpression.test(email);
		}
		
		static public function removeFirst(str:String):String {
			
			return str.substr(1);
		}
		
		static public function removeLast(str:String):String {
			
			return str.substring(0, str.length - 1);
		}
		
		/**
		 * Remove first and last character from _string_
		 * @usage	Usage:
		 * var str:String = "1abcde2";
		 * var str:String = "1abcde2";
		 * var str_1:String = mcString.removeFirst(str);
		 * var str_2:String = mcString.removeLast(str);
		 * var str_3:String = mcString.removeFirstAndLast(str);
		 * trace(str, str_1, str_2, str_3)
		 * output: 1abcde2, abcde2, 1abcde, abcde,
		 * @param	str full String
		 * @return	shorten String
		 */
		static public function removeFirstAndLast(str:String):String {
			
			return removeFirst(removeLast(str));
		}
		
		static public function singleQuoteToDouble(str:String):String {
			
			return str.replace(/\"/g, '\'');
		}
		
		/**
		 * Replace character(search) at position by given one(replace)
		 * @param	str String where we want replace characters
		 * @param	search String which characters will be replaced
		 * @param	replace New chars
		 * @return	New String
		 */
		static public function replaceAt(str:String, search:String, replace:String, pos:int = 0):String {
			
			//trace("replace word:" + search + " with:" + replace+" at:" + pos + " in text:" + str);
			var begin:String = str.substring(0, str.indexOf(search, pos));
			var end:String = str.substring(str.indexOf(search, pos) + search.length);
			//trace("begin:"+begin+" end:"+end)
			return begin + replace + end;
		}
		
		static public function replaceAll(str:String, search:String, replace:String):String {
			
			//return str.replace(new RegExp(search, "g"), replace); //working
			return str.split(search).join(replace);
		}
		
		/**
		 * Replace clossest occurence from given index
		 * @param	str
		 * @param	search
		 * @param	replace
		 * @param	index
		 * @return
		 */
		static public function replaceClosest(str:String, search:String, replace:String, index:int):String {
			
			var all_char_indexes:Array = new Array();
			var next_pos:int = str.indexOf(search, next_pos);
			while (next_pos != -1) {
				
				all_char_indexes.push(next_pos);
				next_pos = str.indexOf(search, next_pos + 1);
			}
			var closest_index:int = mcMath.getClosestIndex(all_char_indexes, index);
			var start:int = all_char_indexes[closest_index];
			//trace("all char indexes:" + all_char_indexes + " hit index:" + index + " closest index:" + closest_index);
			return replaceAt(str, search, replace, start);
		}
		
		/**
		 * Reverse a string
		 * @param	str
		 * @return
		 */
		static public function reverse(str:String):String {
			
			return str.split("").reverse().join("");
		}
		
		/**
		 * Cout how many words is in a String
		 * @param	str text
		 * @param	search word
		 * @return	int count
		 */
		static public function charsCount(str:String, search:String):int {
			
			var cnt:int = 0;
			var next_pos:int = str.indexOf(search, next_pos);
			while (next_pos != -1) {
				
				cnt++;
				next_pos = str.indexOf(search, next_pos + 1);
			}
			return cnt;
		}
		
		static public function removeTabsAndNewLines(str:String):String { //not used
			
			var rex:RegExp = /(\t|\n|\r)/gi;
			str = str.replace(rex, '');
			return str;
		}
		
		static public function fixTextChars(str:String):String { //not used
			
			var new_str:String = str.split("\\n").join("\n");
			new_str = new_str.split("\\r").join("\r");
			new_str = new_str.split("\\t").join("\t");
			//string = string.replace(/\n/g, "<br>");
			//var newText:String = str.replace(/\r\n/g, "\n");
			//var new_str:String = str.replace(/\\n/g, "\n");
			//new_str = new_str.replace(/\\t/g, "\t");
			return new_str;
		}
		
		/**
		 * If a string number have more than wanted decimal places then will be reduced
		 * If a string number have less than wanted decimal places then will be aded zeros
		 * @param	num_str Must have comma or nothing. ex: 12,5 or 12
		 * @param	places decimal places
		 */
		static public function toFixed(num_str:String, places:Number):String {
			
			var zero_pattern:String = "0000000000"; //0 x 10
			var arr:Array = num_str.split(",");
			if (arr.length == 1) { //number is whole
				
				num_str += "," + zero_pattern.substring(0, places);
			} else {
				
				var decimal_len:int = String(arr[1]).length;
				if (decimal_len < places) { //append missing zeros
					
					num_str += zero_pattern.substring(0, places - decimal_len);
				}
				if (decimal_len > places) { //reduce decimals to wanted places
					
					var num:Number = stringToNumber(num_str);
					num = mcMath.toFixed(num, places);
					num_str = numberToString(num);
				}
			}
			return num_str;
		}
		
		/**
		 * Convert fraction (1/10) in to number 0.1;
		 * @param	fraction String
		 * @return Number of fraction
		 */
		static public function fractionToNumber(fraction:String, fixed:int = 0):Number {
			
			var nums:Array = fraction.split("/");
			var result:Number = Number(nums[0]) / Number(nums[1]);
			return fixed ? mcMath.toFixed(result, fixed) : result;
		}
		
		/**
		 * Breaks a string into an array of letters.
		 * @param	str
		 * @return	Array
		 */
		static public function splitAll(str:String):Array {
			
			var new_array:Array = new Array();
			for (var i:int = 0; i < str.length; i++) {
				
				new_array.push(str.charAt(i));
			}
			return new_array
		}
		
		/**
		 * Split text by delimiters and remove them. //NOT USED
		 * @example	var str:String = "Uskutečnili nečekaný objev! Ve školní jídelně?"
		 * @example	var arr:Array = mcString.splitRemoveDelimiters(str, "?!,. ")
		 * @result [Uskutečnili,nečekaný,objev,,Ve,školní,jídelně]
		 * @param	str
		 * @param	delimiters
		 * @return
		 */
		static public function splitRemoveDelimiters(str:String, delimiters:String):Array{
			
			var regstr:String = "["+delimiters+"]+";
			var regexp:RegExp = new RegExp(regstr);
			var arr:Array = str.split(regexp);
			if (arr[arr.length - 1] == "") arr.pop(); //remove last element if is empty
			return arr;
		}
		
		/**
		 * Split text by delimiters. //used by mcs.TextBubbles
		 * @example	var str:String = "Uskutečnili nečekaný objev! Ve školní jídelně?"
		 * @example	var arr:Array = mcString.spitDelimiters(str, "?!,. ");
		 * @result [Uskutečnili nečekaný objev,!, Ve školní jídelně,?]
		 * @param	str
		 * @param	delimiters
		 * @return
		 */
		static public function spitDelimiters(str:String, delimiters:String):Array {
		
			//var regstr:String = "(["+delimiters+"])";
			var regstr:String = "(["+delimiters+"][]*)";
			var regexp:RegExp = new RegExp(regstr);
			var arr:Array = str.split(regexp);
			arr = arr.filter(noEmptyNoSpace); //remove spaces and empty strings
			function noEmptyNoSpace(item:*, index:int, array:Array):Boolean{

			  return item != "" && item != " ";
			}
			return arr;
		}
		/**
		 * @example	var alphabet:mcArray = new mcArray(mcString.splitStringEach(mcKeyboard.ALPHABET_ENG_UP, 3));
			//ABC,DEF,GHI,JKL,MNO,PQR,STU,VWX == 8
			alphabet.shuffle();
		 * @param	str
		 * @param	len
		 * @return
		 */
		static public function splitStringEach(str:String, len:int):Array {
	
			var arr:Array = new Array();
			for (var i:int = 0; i < str.length; i+=len){
				
				if (str.length < i+len) break; //if rest of string is less than len
				var part:String = str.substring(i, i+len);
				arr.push(part);
			}
			return arr;
		}
		
		/**
		 * Insert char(s) in to a string
		 * @param	str input string
		 * @param	add char(s)
		 * @param	pos place where char(s) will be inserted
		 * @return	modiffied string
		 */
		static public function insertAt(str:String, add:String, pos:int):String {
			
			return str.substr(0, pos) + add + str.substr(pos);
		}
		
		/**
		 * Convert a String in to nuber ("45°" -> 45)
		 * @param	angle
		 * @return
		 */
		static public function angleToNumber(str:String):Number{
			
			return Number(str.substring(0, str.length - 1));
		}
		
		
		/**
		 * Convert a "String number" with commas in to Number ("1,5" -> 1.5)
		 * @param	num_str
		 * @return
		 */
		static public function stringToNumber(num_str:String, decimals:int = -1):Number {
			
			if (num_str.indexOf(",")) num_str = replaceAll(num_str, ",", ".");
			if (isNumber(num_str)) {
				
				return (decimals == -1) ? Number(num_str) : Number(Number(num_str).toFixed(decimals));
			}
			return NaN;
		}
		
		/**
		 * Conver a Number in to string with custom separator (1.5 -> "1.5" or "1,5")
		 * @param	num
		 * @param	separator
		 * @param
		 * @return
		 */
		static public function numberToString(num:Number, decimals:int = -1, separator:String = ","):String {
			
			if (decimals != -1) num = Number(num.toFixed(decimals));
			var num_str:String = num.toString();
			if (separator == ",") {
				
				if (num_str.indexOf(".")) num_str = replaceAll(num_str, ".", ",");
			} else {
				
				if (num_str.indexOf(",")) num_str = replaceAll(num_str, ",", ".");
			}
			return num_str;
		}
		
		/**
		 * Insert hair spaces in number, like: 1000 == 1 000, 25600, 25 600, etc..
		 * @param	num_str String Number
		 * @param	space thin_space
		 * @return	modified num_string
		 */
		static public function formatNumber(num_str:String, space:String = ""):String {
			
			space.length == 0 ? space = thin_space : null;
			if (num_str.length < 3) return num_str; //if is less than 1000 return back
			return num_str.replace(/\d{1,3}(?=(\d{3})+(?!\d))/g, "$&" + space);
		}
		
		/**
		 * Remove all thin spaces
		 * @param	num_str
		 * @param	space thin_space
		 * @return	collapsed String
		 */
		static public function unformatNumber(num_str:String, space:String = ""):String {
			
			space.length == 0 ? space = thin_space : null;
			if (num_str.length < 4) return num_str; //if is less than 1000 return back
			return num_str.split(space).join("");
		}
		
		/**
		 * Split formated number in to parts
		 * @param	num_str "1 222 333"
		 * @param	space thin_space
		 * @return	array of string numbers "1 222 333" > ["1", "222", "333"]
		 */
		static public function splitFormatedNumber(num_str:String, space:String = ""):Array {
			
			space.length == 0 ? space = thin_space : null;
			return num_str.split(space);
		}
		
		/**
		 * Insert hair spaces in number, like: 1000 == 1 000, 25600, 25 600, etc..
		 * @param	num_str String Number
		 * @param	space thin_space
		 * @return	modified num_string
		 */
		static public function formatDecimal(num_str:String, space:String = "", comma:String = ","):String {
			
			space.length == 0 ? space = thin_space : null;
			if (num_str.indexOf(comma) == -1) return num_str; //is not decimal
			var parts:Array = num_str.split(comma);
			var unit:String = parts[0]+comma+space;
			var decimals:String = parts[1];
			while (decimals.length > 3){
				
				unit += decimals.substring(0, 3)+space;
				decimals = decimals.substring(3);
			}
			unit += decimals;
			return unit;
		}
		
		/**
		 * Parse string in to Object MathExample
		 * @param	str "123*6" or "45/3" or "45+897" ...
		 * @return	Object new MathExample {numa, numb, operator}
		 */
		static public function parseToExample(str:String):MathExample {
			
			var operators:Array = ["+", "-", "*", "/", ":"];
			var num_a:String = "";
			var num_b:String = "";
			var half:Boolean = false;
			var obj:MathExample = new MathExample();
			
			str = mcString.trimWhiteSpaces(str);
			for (var i:int = 0; i < str.length; i++) {
				
				var char:String = str.charAt(i);
				if (operators.indexOf(char) != -1) {
					
					obj.numa = Number(num_a);
					obj.operator = String(char);
					half = true;
				} else {
					
					half ? num_b += char : num_a += char;
				}
				//at the end append num_b
				if (i == str.length - 1) obj.numb = Number(num_b);
			}
			return obj;
		}
		
		/**
		 * Convert words in string to Array
		 * @param	words_str "a, b, c"
		 * @return	["a", "b", "c"]
		 */
		static public function wordsStringToArray(words_str:String):Array {

			words_str = trimWhiteSpacesBeforeAfterDividers(words_str, [","]);
			return words_str.split(",");
		}
	}
}