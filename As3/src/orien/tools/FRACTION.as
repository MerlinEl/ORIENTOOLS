package orien.tools {
	
	/**
	 * ...
	 * Collection of two Numbers where first is numerator and second is denominator
	 * @author René Bača (Orien) & Ľudmila Bačova (Semanthiell) - 2018
	 */
	public final class FRACTION {
		
		private var _numerator:Number;
		private var _denominator:Number;
		
		public function FRACTION(numerator:Number = 0, denominator:Number = 0) {
			
			_numerator = numerator;
			_denominator = denominator;
		}
		
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			return 'FRACTION:[' + this.numerator + '/' + this.denominator + ']';
		}
		
		/**
		 * Conversion as
		 * @return as Object
		 */
		public function toObject():Object {
			
			return {"numerator": _numerator, "denominator": _denominator};
		}
		
		public function get numerator():Number {
			
			return _numerator;
		}
		
		public function set numerator(value:Number):void {
			
			_numerator = value;
		}
		
		public function get denominator():Number {
			
			return _denominator;
		}
		
		public function set denominator(value:Number):void {
			
			_denominator = value;
		}
		
		/**
		 * @example
		fraction FRACTION:[180/1000] reduced to FRACTION:[9/50]
			FRACTION:[9/50]
			FRACTION:[18/100]
			FRACTION:[36/200]
			FRACTION:[45/250]
			FRACTION:[90/500]
			FRACTION:[180/1000]
		 * @return	Array of all variations
		 */
		public function getAllReductions():Array{
			
			var gcd:FRACTION = reduce();
			return gcd.developTo(this);
		}
		
		/**
		 * Reduce fraction by finding the Greatest Common Divisor and dividing by it.
		 * @param	n
		 * @param	d
		 * @return	new FRACTION
		 */
		public function reduce():FRACTION {
			
			var n:Number = Math.min(numerator, denominator) //citatel
			var d:Number = Math.max(numerator, denominator) //jmenovatel
			//recursive search for Greatest Common Divisor
			var gcd = function gcd(a, b) {
				
				return b ? gcd(b, a % b) : a;
			}
			//divide each number with gcd
			gcd = gcd(n, d);
			return new FRACTION(n / gcd, d / gcd);
		}
		
		/**
		 * Get all multiplyed variations fractions where modulo is zero
		 * @param	fr
		 * @return
		 */
		public function developTo(fr:FRACTION):Array {
			
			var arr:Array = new Array(this);
			var mul:int = 2;
			var new_fr:FRACTION = new FRACTION(numerator * mul, denominator * mul);
			while (sameOrSmaller(new_fr, fr)) {
				
				if (divisibleWithoutRest(fr, new_fr)) arr.push(new_fr);
				mul++;
				new_fr = new FRACTION(numerator * mul, denominator * mul);
			}
			return arr;
		}
		
		public function sameOrSmaller(src:FRACTION, trgt:FRACTION):Boolean{
			
			return src.numerator <= trgt.numerator && src.denominator <= trgt.denominator;
		}
		
		public function divisibleWithoutRest(src:FRACTION, trgt:FRACTION):Boolean{
			
			return src.numerator % trgt.numerator == 0 && src.denominator % trgt.denominator == 0;
		}
	}
}