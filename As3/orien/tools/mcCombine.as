package orien.tools {
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcCombine {
		
		/**
		 * Create pair combinations from two arrays A,B. If back_forward A,B and B,A will be combined.
		 * @param	arr1 input array A
		 * @param	arr2 input array B
		 * @param	comb_arr Output array combinations
		 * @param	back_forward two ways combinations A,B and B,A
		 */
		public static function combineTwoArrays(arr1:Array, arr2:Array, comb_arr:Array, back_forward:Boolean = false):void {
			
			var i:int, j:int;
			//forward
			for (i = 0; i < arr1.length; i++) {
				for (j = 0; j < arr2.length; j++) {
					comb_arr.push(new Array(arr1[i], arr2[j]));
				}
			}
			//backward
			if (!back_forward) return;
			for (i = 0; i < arr2.length; i++) {
				for (j = 0; j < arr1.length; j++) {
					comb_arr.push(new Array(arr2[i], arr1[j]));
				}
			}
		}
		
		/**
		 * Create all possible combinations with predefined length from the given set of values
		 * @author 2014. Nicolas Siver (http://siver.im)
		 * @param values possible values for combinations
		 * @param length combination length
		 * @return array of all possible combinations
		 */
		public static function combineElements(values:Array, length:uint):Array {
			
			var i:uint, j:uint, result:Array, start:Array, end:Array, len:uint, innerLen:uint;
			
			if (length > values.length || length <= 0) {
				return [];
			}
			
			if (length == values.length) {
				return values;
			}
			
			if (length == 1) {
				result = [];
				len = values.length;
				for (i = 0; i < len; ++i) {
					result[i] = [values[i]];
				}
				return result;
			}
			
			result = [];
			len = values.length - length;
			for (i = 0; i < len; ++i) {
				start = values.slice(i, i + 1);
				end = combineElements(values.slice(i + 1), length - 1);
				innerLen = end.length;
				for (j = 0; j < innerLen; ++j) {
					result.push(start.concat(end[j]));
				}
			}
			return result;
		}
	}
}