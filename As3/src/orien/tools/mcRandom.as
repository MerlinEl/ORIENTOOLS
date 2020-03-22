package orien.tools {
	
	public class mcRandom {
		
		private var _range:mcArray // [1, 2, 3, 4...]
		private var _pattern:Array //[ ["aple", 10], ["banana", 45], ["lemon", 0.01] ];
		private var _used_indexes:Object = new Object();
		
		public function mcRandom(range:Array = null) {
			
			if (!range || range.length == 0) return;
			_range = new mcArray(range);
		}
		
		/**
		 * Create an mcArray from given range
		 * @param	from
		 * @param	to
		 * @param	by
		 */
		public function addRange(from:Number, to:Number, step:Number = 1):void {
			
			_range = new mcArray(mcMath.numbersInRange(from, to, "all", step));
		}
		
		/**
		 * Pattern is made from Array of objects and his drop percentage (1-100)
		 * @param	pattern [ ["apple", 12], ["orange", 35], ["banana", 80], ["cherry", 1] ]
		 */
		public function addPattern(pattern:Array):void {
			
			if (!pattern || pattern.length == 0) return;
			_pattern = pattern;
		}
		
		/**
		 * Get nex titem in row endless loop
		 * @return
		 */
		public function getNext():* {
			
			if (!_range || _range.length == 0) return null;
			return _range.getNextItem();
		}
		
		/**
		 * Each time return one item from Array. Item can be same like before (max_repeat times)
		 * var fruitsContainer:mcRandom = new mcRandom(["pen", "bottle", "ruller", "fence"]);
		 * for (var i:int = 0; i < 300; i++) ftrace("next item:%", fruitsContainer.getNextUnique(2));
		 * @param	max_repeat drop same items consecutively
		 * @return
		 */
		public function getNextUnique(max_repeat:int):Object {
			
			if (!_range || _range.length == 0) return null;
			var data:Object = _range.getRandomItemAndIndex();
			//if index was used max times, get next one
			while (_used_indexes[data.index] && _used_indexes[data.index] >= max_repeat) {
				
				data = _range.getRandomItemAndIndex();
			}
			//add/append last index to used indexes	
			!_used_indexes[data.index] ? _used_indexes[data.index] = 1 : _used_indexes[data.index]++;
			//if all is used max times
			if (isHistoryFull(max_repeat)) {
				
				//ftrace("<clear used indexes!>")
				_used_indexes = new Object();
				_used_indexes[data.index] = max_repeat;
			}
			return data; //item and index
		}
		
		private function isHistoryFull(max_repeat:int):Boolean {
			
			var choices_left:int = _range.length;
			for (var key in _used_indexes) {
				
				if (!_used_indexes[key]) continue;
				if (_used_indexes[key] >= max_repeat) choices_left--;
			}
			return choices_left <= 0;
		}
		
		/**
		 * Percentage drop items from pattern
		 * Create pattern first: addPattern( [ ["apple", 12], ["orange", 35], ["banana", 80], ["cherry", 1] ] );
		   for (var i:int = 0; i < 30; i++){
		
				dropItem("brick");
		   }
		 * @param	default_item
		 * @return
		 */
		public function dropItem(default_item:* = null):* {
			
			if (!_pattern || _pattern.length == 0) return null;
			var dropped:Boolean = false;
			for (var i:int = 0; i < _pattern.length; i++) {
				
				var p_random:Number = Math.random() * 100; //number in range 1 - 100
				var item:* = _pattern[i][0];
				var p:Number = _pattern[i][1];
				//ftrace("--------------percentage:% random:%", p, p_random);
				if (p > p_random) {
					//ftrace("Item % with % chance is dropped.", item, p);
					return item;
					break;
				}
			}
			if (dropped == false) {
				//ftrace("Dropping default item %", default_item);
				return default_item;
			}
			return null;
		}
	}
}
