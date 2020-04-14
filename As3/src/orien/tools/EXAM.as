package orien.tools {
	
	/**
	 * ...
	 * Collection of two Numbers and calculated result
	 * @author René Bača (Orien) 2018
	 */
	public final class EXAM {
		
		private var _num_a:Number;
		private var _num_b:Number;
		private var _operator:String;
		private var _decimals:int;
		
		public function EXAM(num_a:Number = 0, num_b:Number = 0, operator:String = "+", decimals:int = 0) {
			
			_num_a = num_a;
			_num_b = num_b;
			_operator = operator;
			_decimals = decimals
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'EXAM(' + this.num_a + ' ' +this.operator+ ' ' + this.num_b + ' = ' + this.result + ')';
		}
		
		/**
		 * Conversion as
		 * @return as Object
		 */
		public function toObject():Object{
            
			return {"num_a":this.num_a, "num_b":this.num_b, "operator":this.operator, "result":this.result};
        }
		
		/**
		 * Convert object to EXAM
		 * @example 
		 * cage["range_a"] = {num_a:1000, num_b:9000 operator:10 result:0};
		 * var range_a:EXAM = new EXAM().fromObject(cage["range_a"]);
		 * @param	obj
		 * @return	EXAM
		 */
		public function fromObject(obj:Object):EXAM{
			
			_num_a = obj.num_a;
			_num_b = obj.num_b;
			_operator = obj.operator;
			return this;
		}
		
		public function get num_a():Number {
			return _num_a;
		}
		
		public function set num_a(value:Number):void {
			_num_a = value;
		}
		
		public function get num_b():Number {
			return _num_b;
		}
		
		public function set num_b(value:Number):void {
			_num_b = value;
		}
		
		public function get operator():String {
			return _operator;
		}
		
		public function set operator(value:String):void {
			_operator = value;
		}
		
		public function get result():Number {
			
			var output:Number = 0;
			switch (_operator) {
			
			case "+": 
				output = _num_a + _num_b;
				break;
			case "-": 
				output = _num_a - _num_b;
				break;
			case "*":
				output = _num_a * _num_b;
				break;
			case "/": 
				output = _num_a / _num_b;
				break;
			}
			//ftrace("math % % % = before fixed:%",num_a, _operator, num_b, output)
			return mcMath.toFixed(output, _decimals);
		}
		
		/**
		 * RANDOM GENERÁTOR VELKÉ NÁSOBILKY Orien (2018)
		 * @param	examples_count
		 * @param	print
		 * @return	mcArray of examples
		 */
		static public function bigMultilier(examples_count:int, print:Boolean = false):mcArray{
			
			var multi:Array = mcMath.numbersInRange(11, 20);
			var maths:mcArray = mcMath.generateDivideExamplesSimple(multi, true);
			var examples:mcArray = new mcArray();
			for (var i:int = 0 ; i < examples_count; i++){
				
				var random_math:Object = maths.getRandomItem();
				var max_nums:Array = random_math.nums as Array;
				var math:EXAM = new EXAM(Number(max_nums.pop()), Number(random_math.mod), "/", 1);
				examples.addItem(math);
			}
			if (print) examples.print();
			return examples;
		}
	}
}