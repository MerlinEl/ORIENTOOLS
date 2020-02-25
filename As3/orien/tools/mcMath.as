package orien.tools {
	
	/**
	 * ...
	 * @author René Bača (Orien) 2015
	 */
	public class mcMath {
		
		//private const MAX_TRY:int = 400;
		
		public function mcMath() {
		
		}
		
		/**
		 * Round a number to defined decimals.
		 * @param	num a Number we want to round
		 * @param	to how many decimals remains
		 * @return	rounded number
		 * @example roundTo(4.458, 1) == 4.4
		 * @example roundTo(4.458, 2) == 4.45
		 */
		static public function roundTo(num:Number, to:Number):Number {
			
			var power:Number = Math.pow(10, to);
			return int(num * power) / power;
		}
		
		/**
		 * Round a number to dozens, hundred, thousand, etc..
		 * @param	num a Number we want to round
		 * @param	to 10, 20, 30, ...
		 * @return	rounded number
		 */
		static public function roundToDozen(num:Number, to:int = 10):int {
			
			return Math.round(num / to) * to;
		}
		
		/**
		 * Remove all zeros at end
		 * @param	num like 24 000
		 * @return	optimized Number
		 */
		static public function removeZerosAtEnd(num:Number):Number {
			
			/*
			   var cislo = 5300;
			   var zlomek = cislo / Math.pow(10, String(cislo).length-1);
			   var cislo_bez_nul = zlomek * Math.pow(10, String(zlomek).length-2);
			   trace("zlomek:"+zlomek+" cislo_bez_nul:"+cislo_bez_nul)*/
			
			var cnt:int = 0;
			for (var i:int = 1; i < String(num).length; i++) {
				
				if (mcMath.mod(num, Math.pow(10, i)) == 0) cnt++;
			}
			return num / Math.pow(10, cnt);
		}
		
		/**
		 * @return	random true or false
		 */
		static public function randomSwitch():Boolean {
			
			return randomRange(0, 1) == 1;
		}
		
		/**
		 * Updated:(01.11.2016)
		 * Generate a random number between defined range.
		 * @param	min_num minimum number
		 * @param	max_num maximum number
		 * @param	round_type round Number type: floor, ceil, round.
		 * @param	to_fixed maximum decimal places
		 * @return	number
		 */
		static public function randomRange(min_num:Number, max_num:Number, round_type:String = "floor", to_fixed:int = 0):Number {
			
			var random_num:Number = Math.random() * (max_num - min_num + 1);
			switch (round_type) {
			
			case "none": 
				random_num += min_num;
				break;
			case "floor": 
				random_num = Math.floor(random_num) + min_num;
				break;
			}
			return to_fixed == 0 ? random_num : toFixed(random_num, to_fixed);
		}
		
		/**
		 * Generate random decimal number in range [0 - 1] and reduce decimal places like: 0.2, 0.21, 0.568 etc...
		 * @param	decimals fixed decimal places
		 * @return
		 */
		static public function randomDecimal(decimals:int):Number {
			
			return Number(Math.random().toFixed(decimals));
		}
		
		/**
		 * @date 15.9.2014
		 * Generate a random number between defined range
		 * @param	min_num minimum number
		 * @param	max_num maximum number
		 * @param	used array of already used numbers
		 * @param	tryes how many tryes will be done to achive required result
		 * @return	return Object num  = new unique number based on history(used)
		 * 						  used = array of used numbers numbers include new number
		 */
		static public function randomRangeUnique(min_num:Number, max_num:Number, used:Array, tryes:Number):Object {
			
			var random_num:Number = randomRange(min_num, max_num);
			while (used.indexOf(random_num) != -1 && tryes > 0) { //search for different result if exists
				
				random_num = randomRange(min_num, max_num);
				tryes--;
			}
			used.push(random_num); //add new generated number in to used array
			if (used.length >= max_num) used = []; //empty array if all numbers in range are used
			return {"num": random_num, "used": used};
		}
		
		/**
		 * Create field of numbers in range and shuffle;
		 * @example	if (cars_frames.length == 0) cars_frames = mcMath.regenerateField(1, cars_01.totalFrames);
		 * @example	var random_unique_frame = car_frames.pop();
		 * @param	from
		 * @param	to
		 * @param	shuffle
		 * @return	mcArray
		 */
		static public function regenerateField(from:Number, to:Number, shuffle:Boolean = true):mcArray {
			
			var new_field:mcArray = new mcArray(numbersInRange(from, to));
			if (shuffle) new_field.shuffle();
			return new_field;
		}
		
		/**
		 * @date 15.9.2014
		 * Generate a random number between defined range (rounded to dozens)
		 * @param	min_num minimum number
		 * @param	max_num maximum number
		 * @param	used array of already used numbers
		 * @param	tryes how many tryes will be done to achive required result
		 * @return	return Object num  = new unique number based on history(used)
		 * 						  used = array of used numbers numbers include new number
		 */
		static public function randomRangeDozensUnique(min_num:Number, max_num:Number, used:Array, tryes:Number):Object {
			
			var random_num:Number = roundToDozen(randomRange(min_num, max_num));
			while (used.indexOf(random_num) != -1 && tryes > 0) { //search for different result if exists
				
				random_num = roundToDozen(randomRange(min_num, max_num));
				tryes--;
			}
			used.push(random_num); //add new generated number in to used array
			if (used.length >= Math.round(max_num / 10)) used = []; //empty array if all numbers in range are used
			return {"num": random_num, "used": used};
		}
		
		/**
		 * @example	trace("1990 in roman is " + mcMath.arabicToRoman(1990));
		 * @param	val
		 */
		static public function arabicToRoman(val:int) {
			
			if (val < 1 || val > 3999) return "-1";
			
			var arr_1:Array = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
			var arr_2:Array = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
			var roman:String = ""
			
			for (var i:int = 0; i < arr_1.length; i++) {
				//ftrace("key: % val: %", arr_2[i], arr_1[i])
				while (val >= arr_1[i]) {
					roman += arr_2[i];
					val -= arr_1[i];
				}
			}
			return roman;
		}
		
		/**
		 * @example	trace("MCMXC in arabic is " + mcMath.romanToArabic("MCMXC"));
		 * @param	roman
		 * @return
		 */
		static public function romanToArabic(roman:String):Number {
			
			var roman_arr:Array = roman.toUpperCase().split('');
			var lookup:Object = { I:1, V:5, X:10, L:50, C:100, D:500, M:1000 };
			var num:Number = 0, val:Number = 0;
			while (roman_arr.length) {
				val = lookup[roman_arr.shift()];
				num += val * (val < lookup[roman_arr[0]] ? -1 : 1);
			}
			return num;
		}
		
		/**
		 * Generate an array of unmbers between min | max range
		 * @param	min_num minimum number
		 * @param	max_num maximum number
		 * @param	type all, even, odd
		 * @param	step skip each 1,2,3... element
		 * @return	array of numbers
		 */
		static public function numbersInRange(min_num:Number, max_num:Number, type:String = "all", step:int = 1):Array {
			
			if (step < 1) {
				
				trace("Error numbersInRange, step must be bigger than 0!")
				return [];
			}
			//trace("min:"+min_num+"max:"+max_num);
			var nums:Array = new Array();
			for (var i:Number = min_num; i <= max_num; i += step) {
				switch (type) {
				
				case "all": 
					nums.push(i);
					break;
				case "even": 
					if (isEven(i)) nums.push(i);
					break;
				case "odd": 
					if (!isEven(i)) nums.push(i);
					break;
				}
			}
			return nums;
		}
		
		static public function numbersInRangeDecimal(min_num:Number, max_num:Number, step:Number = 0.1, dec_only:Boolean = false, decimals:int = 2):Array {
			
			if (step < 0.1) {
				
				trace("Error numbersInRangeDecimal, step must be bigger than 0!")
				return [];
			}
			var nums:Array = dec_only ? [] : [min_num];
			var num:Number = min_num + step;
			while (num <= max_num) {
				
				if (isWhole(num) && dec_only) {
					
					//skip whole number
					
				} else {
					
					nums.push(num);
				}
				num += step;
				num = Number(num.toFixed(decimals)); //aded fixer to avoid this: 1.2000000000000002
			}
			return nums;
		}
		
		/**
		 * Generate an array of random numbers between min | max range at given length
		 * @param	min_num minimum number
		 * @param	max_num maximum number
		 * @param	len length of array
		 * @return	array of random numbers
		 */
		static public function generateRandomNumbers(min_num:Number, max_num:Number, len:Number):Array {
			
			var nums:Array = new Array();
			for (var i:Number = 0; i < len; i++) nums.push(randomRange(min_num, max_num));
			return nums;
		}
		
		/**
		 * Generate an array of unique numbers between min max
		 * @param	min_num minimum number
		 * @param	max_num maximum number
		 * @param	len length of array
		 * @param	tryes how many times repeat unique number generation (default 20x)
		 * @return	array of random unique numbers
		 */
		static public function getRandomNumbersFromRangeUnique(min_num:Number, max_num:Number, len:Number, tryes:Number = 20):Array {
			
			if (max_num < min_num) return new Array();
			var nums:Array = new Array();
			var max_try:int = tryes;
			while (nums.length < len && max_try > 0) { //if array length not big enough
				
				max_try--;
				var random_num:Number = randomRange(min_num, max_num);
				if (nums.indexOf(random_num) == -1) { //if random_num is not in nums 
					max_try = tryes; //reset try counter if num is unique
					nums.push(random_num); //append random number 
				}
				if (max_try == 0) {//reset try counter is 0
					
					max_try = tryes;
					nums.push(random_num); //append random number
					
				}
			}
			return nums;
		}
		
		/**
		 * Check if number is whole
		 * @param	val
		 * @return
		 */
		static public function isWhole(val:Number):Boolean {
			
			return int(val) == val;
		}
		
		/**
		 * Check if given number is even or odd
		 * @param	num number which we want to check
		 * @return	bollean: true | false
		 */
		static public function isEven(val:Number):Boolean { //je li sudé číslo
			
			return val % 2 == 0;
		}
		
		static public function mod(val_a:Number, val_b:Number):Number {
			
			return val_a % val_b;
		}
		
		/**
		 * Convert positive number in to negative and vice versa
		 * @example inverseNumber(24) == -24;
		 * @param	val
		 */
		static public function inverseNumber(val:Number):Number {
			
			return val * -1;
		}
		
		//rozklad čísla na sčítání
		static public function composeNumber(num_res:int, num_min:int):Array {
			
			var cnt:int = num_res;
			var output:Array = new Array();
			while (cnt >= num_min) {
				
				output.push(cnt + "+" + (num_res - cnt));
				cnt--;
			}
			return output;
		}
		
		//rozklad čísla na odčítání etc. (45, 100) mean: 100 combinations with result 45
		static public function decomposeNumber(num_res:int, num_max:int):Array {
			
			var cnt:int = num_max;
			var output:Array = new Array();
			while (cnt >= num_res) {
				
				output.push(cnt + "-" + (cnt - num_res));
				cnt--;
			}
			return output;
		}
		
		/**
		 * Split number to whole and decimal part
		 * @param	num
		 * @return	new Array ( Number(whole), Number(decimal) )
		 */
		static public function splitDecimals(num:Number):Array {
			
			if (num.toString().indexOf(".") == -1) return [num, 0];
			var str_arr:Array = num.toString().split(".");
			return [Number(str_arr[0]), Number("0." + str_arr[1])];
		}
		
		static public function getNumArraySum(arr:Array):Number {
			
			var sum:Number = 0;
			for each (var o:Number in arr) sum += o;
			return sum;
		}
		
		//get second digit from numbers 10-infinite;
		static public function getLastDigit(num:int):int {
			
			if (num < 9) return num;
			return num % 10;
		}
		
		//get array numbers from number like 123 == [100, 20, 3]
		static public function decomposeEachDigit(num:Number):Array {
			
			if (isNaN(num)) return null;
			var digits:Array = [];
			var cnt:int = 0;
			while (num > 0) {
				var mod:int = num % 10;
				digits.push(mod * Math.pow(10, cnt))
				
				num = Math.floor(num / 10);
				cnt++;
			}
			digits.reverse();
			return digits;
		
		/*var numbers_array:Array = new Array();
		   var num_str:String = num.toString();
		   for (var i:int = 0; i < num_str.length; i++) {
		
		   var char:String = num_str.charAt(i);
		   if (!mcString.isNumber(char)) continue; //skip non number chars
		   var current_num:Number = Number(char) * Math.pow(10, num_str.length -1 - i);
		   numbers_array.push(current_num);
		   }
		   return numbers_array;*/
		}
		
		//if a + b is crossing over ten. etc. true --> 15+6 false --> 15+5
		static public function isOverTen(num_a:int, num_b:int):Boolean {
			
			if (num_a > 9) num_a = getLastDigit(num_a);
			if (num_b > 9) num_b = getLastDigit(num_b);
			return num_a + num_b > 10; //numbers from 0-9
		}
		
		//if a - b is crossing over ten. etc. true --> 15-6 false --> 15-5
		static public function isLessTen(num_a:int, num_b:int):Boolean {
			
			if (num_a > 9) num_a = getLastDigit(num_a);
			if (num_b > 9) num_b = getLastDigit(num_b);
			//trace(num_a+"-"+num_b+" is over:"+(num_a < num_b))
			return num_a < num_b;
		}
		
		static public function filterNumbersByOverTen(str_arr:Array):Array {
			
			var new_nums:Array = new Array();
			for each (var ex:String in str_arr) { //for each example 12+10 
				
				var num_arr:Array = ex.split("+");
				var num_a:Number = Number(num_arr[0]);
				var num_b:Number = Number(num_arr[1]);
				if (isOverTen(num_a, num_b)) continue; //skip results which cross over ten 
				new_nums.push(ex);
			}
			return new_nums;
		}
		
		/**
		 * Calculate percent from a given number
		 * @param	num	any number
		 * @param	percent	numbers between 1 - 100
		 * @param	fixed if not -1 then define how many decimals are in number.
		 * @return	number percent from given number
		 */
		static public function percentFromNumber(num:Number, percent:Number, fixed:int = -1):Number {
			
			var percent:Number = (num * percent) / 100;
			return fixed > -1 ? toFixed(percent, fixed) : percent;
		}
		
		static public function minMaxFrom(num:Number, min:Number, max:Number):Number {
			
			return Math.min(max, Math.max(num, min));
		}
		
		static public function maxMaxFrom(num:Number, min:Number, max:Number):Number {
			
			return Math.max(max, Math.max(num, min));
		}
		
		static public function double(num:Number):Number {
			
			return Number(num.toFixed(2));
		}
		
		/**
		 * Generate examples at range min_result to max_result. Plus min_number to max_number.
		 * @param	min_result minimum example result
		 * @param	max_result maximum example result
		 * @param	min_number minimum plus value
		 * @param	max_number maximum plus value
		 * @param	cross if wee can cross over 10
		 * @return	mcArray of examples
		 */
		static public function generatePlusExamples(min_result:Number, max_result:Number, min_number:Number, max_number:Number, cross:Boolean):mcArray {
			
			//trace("generatePlusExamples >>",min_result, max_result, min_number, max_number, cross)
			var examples:mcArray = new mcArray();
			for (var num_b:int = min_number; num_b < max_number; num_b++) {
				//trace("loop:"+num_b)
				for (var num_a:Number = min_result; num_a <= max_result; num_a++) {
					if (num_a + num_b > max_result) break;
					//trace(num_a + " + " + num_b + " = " + (num_a + num_b))
					if (!cross && isOverTen(num_a, num_b)) continue;
					//trace("accept")
					examples.addItem({"a": num_a, "b": num_b, "c": (num_a + num_b), "operator": "+"});
				}
			}
			return examples;
		}
		
		static public function generateMinusExamples(min_result:Number, max_result:Number, min_number:Number, max_number:Number, cross:Boolean):mcArray {
			
			var examples:mcArray = new mcArray();
			for (var num_b:int = min_number; num_b < max_number; num_b++) {
				
				for (var num_a:Number = max_result; num_a > min_result; num_a--) {
					if (num_a - num_b < min_result) break;
					if (!cross && isLessTen(num_a, num_b)) continue;
					//trace(num_a + " - " + num_b + " = " + (num_a - num_b))
					examples.addItem({"a": num_a, "b": num_b, "c": (num_a - num_b), "operator": "-"});
				}
			}
			return examples;
		}
		
		static public function generateDivideExamplesSimple(mod_numbers:Array, shuffle:Boolean = false, debug:Boolean = false):mcArray {
			
			var examples:mcArray = new mcArray();
			for each (var mod:int in mod_numbers) { //generate nums for each multiply digit
				
				var random_nums:mcArray = new mcArray(multiplyNumSimple(mod));
				if (shuffle) random_nums.shuffle();
				examples.addItem({"mod": mod, "nums": random_nums.toArray()});
				if (debug) trace("modify:" + mod + " random_nums:" + random_nums);
			}
			return examples;
		}
		
		static public function traceExamples(arr:mcArray):void {
			
			for each (var o:Object in arr.source) trace(o.a + (o.operator == "+" ? " + " : " - ") + o.b + " = " + o.c);
		}
		
		static public function multiplyNumSimple(num:Number):Array {
			
			var num_arr:Array = new Array();
			for (var i:int = 1; i <= 10; i++) {
				num_arr.push(num * i)
			}
			return num_arr;
		}
		
		/**
		 * Get index of a number which is most close to given index
		 * @param	numbers array of numbers
		 * @param	index
		 * @return	int array position
		 */
		static public function getClosestIndex(numbers:Array, index:int):int {
			
			var colsest_index:int = 0;
			var min_dist:Number = Math.abs(numbers[0] - index);
			for (var i:int = 0; i < numbers.length; i++) {
				
				var dist:Number = Math.abs(numbers[i] - index);
				//trace("min_dist:"+min_dist+" dist:"+dist + " num:"+numbers[i] + " index:"+index + " i:"+i)
				if (min_dist > dist) {
					
					colsest_index = i;
					min_dist = dist;
				}
			}
			return colsest_index;
		}
		
		/**
		 * Add replace decimals from one number to another 1.25, 56.3 == 56.25;
		 * @param	num_a
		 * @param	num_b
		 */
		static public function copyDecimalsFromTo(num_a:Number, num_b:Number):Number {
			
			var numa_arr:Array = splitDecimals(num_a);
			var numb_arr:Array = splitDecimals(num_b);
			return numb_arr[0] + numa_arr[1];
		}
		
		/**
		 * Generate list of modifyed number by three different ways:
		 * One number is always correct
		 * 1. plus
		 * 2. minus
		 * 3. plus & minus
		 * @param	num number which will be modified
		 * @param	all_mods ex.: [10, 20, 30, -10, -20, -30]
		 * @param	results how many modifications will be done
		 * @return	random selected numbers as mcArray (shuffled)
		 */
		static public function fakeNumberPlusMinusBoth(num:Number, all_mods:Array, mods:int):mcArray {
			
			//filter mods
			var random_mods:mcArray;
			switch (new mcArray(["plus", "minus", "both"]).getRandomItem()) {
			
			case "plus": 
				random_mods = filterNumbers(all_mods, "positive");
				break;
			case "minus": 
				random_mods = filterNumbers(all_mods, "negative");
				break;
			case "both": 
				random_mods = new mcArray(all_mods);
				break;
			}
			random_mods.shuffle();
			//modify number
			var all_results:mcArray = new mcArray([num]);
			for (var i:int = 0; i < mods; i++) {
				
				all_results.addItem(num + Number(random_mods.pop()));
			}
			all_results.shuffle();
			return all_results;
		}
		
		/**
		 * Modify a number to many variations(percent_range)
		 * @example
		 * var num:Number = 123;
		 * var percents:Array = [99, 101];
		 * var nums:Array = mcMath.fakeNumberPercenage(num, percents, 2, 2)
		 * ftrace("num: % mods: %", num, nums)
		 * output: num: 123 mods: 124.23,121.77
		 * @param	num a Number
		 * @param	percent_range Array of percents like: [95, 105]
		 * @param	mods how many modifications will output
		 * @return	Array of modified numbers
		 */
		static public function fakeNumberPercenage(num:Number, percent_range:Array, mods:int, fixed:int = -1):Array {
			
			if (percent_range.length != 2) {
				
				trace("range must have two numbers [from, to].")
				return [];
			}
			if (percent_range[1] - percent_range[0] < mods) {
				
				trace("mods length is exceeded percent_range.")
				return [];
			}
			var output:Array = new Array();
			var used_percents:Array = new Array();
			for (var i:int = 0; i < mods; i++) {
				
				var random_percent:Number = randomRange(percent_range[0], percent_range[1]);
				while (used_percents.indexOf(random_percent) != -1 || random_percent == 100) { //skip 100% 
					
					random_percent = randomRange(percent_range[0], percent_range[1]);
				}
				used_percents.push(random_percent);
				var mod_num:Number = percentFromNumber(num, random_percent, fixed);
				output.push(mod_num);
			}
			return output;
		}
		
		/**
		 * Collect numbers from given array by type: positive or negative
		 * @param	nums array of numbers ex.: [10, 20, 30, -10, -20, -30]
		 * @param	type
		 * @return
		 */
		static public function filterNumbers(nums:Array, type:String):mcArray {
			
			var nums_array:mcArray = new mcArray();
			for each (var num in nums) {
				
				switch (type) {
				
				case "positive": 
					if (num >= 0) nums_array.addItem(num);
					break;
				case "negative": 
					if (num < 0) nums_array.addItem(num);
					break;
				}
			}
			return nums_array;
		}
		
		static public function toFixed(num:Number, decimals:int):Number {
			
			return Number(num.toFixed(decimals));
		}
	}
}