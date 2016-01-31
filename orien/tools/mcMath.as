package orien.tools {
	
	/**
	 * ...
	 * @author René Bača (Orien) 2015
	 */
	public class mcMath {
		
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
		 * Round a number to dozens
		 * @param	num a Number we want to round
		 * @param	to 10, 20, 30, ...
		 * @return	rounded number
		 */
		static public function roundToDozen(num:Number, to:int = 10):int {
			
			return Math.round(num / to) * to;
		}
		
		/**
		 * Generate a random number between defined range
		 * @param	min_num minimum number
		 * @param	max_num maximum number
		 * @return	number
		 */
		static public function randomRange(min_num:Number, max_num:Number):Number {
			
			return (Math.floor(Math.random() * (max_num - min_num + 1)) + min_num);
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
		 * Generate an array of unmbers between min | max range
		 * @param	min_num minimum number
		 * @param	max_num maximum number
		 * @param	type all, even, odd
		 * @param	step skip each 1,2,3... element
		 * @return	array of numbers
		 */
		static public function numbersInRange(min_num:Number, max_num:Number, type:String = "all", step:int = 1):Array {
			
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
		
		static public function getNumArraySum(arr:Array):Number {
			
			var sum:Number = 0;
			for each (var o:Number in arr) sum += o;
			return sum;
		}
		
		static public function randomSwitch():Boolean {
			
			return randomRange(0, 1) == 0;
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
	
	}

}