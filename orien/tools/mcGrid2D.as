/*
   import orien.tools.mcGrid2D;
   var grid:mcGrid2D = new mcGrid2D(10,10);
   //trace("rows:"+grid.rows)
   //trace("columns:"+grid.columns)
   grid.print();
   for (var i:int = 0; i< grid.count; i++ ){

   trace("add item at index:"+i)
   grid.addItemAt("I'm an item", i);
   }

   var cell = grid.getItemAt(45);
   trace("cel 45:"+cell)
 */

/*
   2D / 1D - mapping is pretty simple. Given x and y,
   and 2D array sizes width and height,
   you can calculate the according index i in 1D space (zero-based) by

   i = x + width*y;

   and the reverse operation is

   x = i % width;    // % is the "modulo operator", the remainder of i / width;
   y = i / width;    // where "/" is an integer division

   You can extend this easily to 3 or more dimensions.
   For example, for a 3D matrix with dimensions "width", "height" and "depth":

   i = x + width*y + width*height*z;

   and reverse:

   x = i % width;
   y = (i / width)%height;
   z = i / (width*height);
 */

package orien.tools {
	
	import flash.geom.Point;
	
	public class mcGrid2D {
		
		public var count:int = 0;
		private var total_columns:int = 10;
		private var total_rows:int = 10;
		private var source:Array = new Array();
		
		public function mcGrid2D(columns:int, rows:int) {
			
			var index:int = 0;
			for (var x:int = 0; x < columns; x++) {
				
				var row:Array = new Array();
				for (var y:int = 0; y < rows; y++) {
					
					var cell:CELL = new CELL(new Point(x, y), index)
					row.push(cell);
					//trace("Add cell:" + cell + " at column:" + x + " row:" + y + " index:" + index);
					index++;
				}
				source.push(row);
			}
			count = index;
		}
		
		/**
		 * Add an object in to first empty CELL
		 * @param	item
		 */
		public function addItem(item:Object):void {
			
			var first_empty_cell:CELL = getEmptyCell();
			if (!first_empty_cell) {
				
				errorMSG(3);
				return;
			}
			first_empty_cell.addItem(item);
		}
		
		/**
		 * Search for cell which is empty
		 * @return empty CELL object
		 */
		private function getEmptyCell():CELL {
			
			var first_empty_cell:CELL;
			for each (var arr:Array in source) {
				for each (var cell:CELL in arr) {
					if (!cell.item) return cell;
				}
			}
			return first_empty_cell;
		}
		
		/**
		 * Get item from cell if is not empty.
		 * @param	index
		 * @return
		 */
		public function getItemAt(index:int):* {
			
			if (outOfRange(index)) {
				errorMSG(1, index);
				return null;
			}
			var cell:CELL = getCellByIndex(index);
			if (isCellEmpty(cell)) {
				errorMSG(4, index);
				return null;
			}
			return cell.item;
		}
		
		public function getAllItems():Array {
			
			var all_items:Array = new Array();
			for each (var arr:Array in source) {
				for each (var cell:CELL in arr) {
					if (cell.item) all_items.push(cell.item);
				}
			}
			return all_items;
		}
		
		/**
		 * Add an object in specified CELL
		 * @param	item an object
		 * @param	index begin from 0 to max count
		 * @param	replace replace object if exist in same place
		 */
		public function addItemAt(item:Object, index:int, replace:Boolean = true):void {
			
			if (outOfRange(index)) {
				errorMSG(1, index);
				return;
			}
			var cell:CELL = getCellByIndex(index);
			//trace("addItemAt >> " + index + " item:" + item + " cell:" + cell)
			if (!replace && !isCellEmpty(cell)) {
				errorMSG(2, index);
				return;
			}
			cell.addItem(item);
		}
		
		private function errorMSG(index:int, value:* = null):void {
			
			switch (index) {
			
			case 1: 
				trace("Index:[" + value + "] is out of range.");
				break;
			case 2: 
				trace("addItemAt Failed! Cell at place:[" + value + "] is not empty. Try another one.");
				break;
			case 3: 
				trace("addItem Failed! Grid is full");
				break;
			case 4: 
				trace("getItemAt Failed! Cell is empty.");
				break;
			}
		}
		
		private function getCellByIndex(index:int):CELL {
			
			if (outOfRange(index)) {
				errorMSG(1, index);
				return null;
			}
			var column:int = mcMath.mod(index, columns);
			var row:int = Math.floor(index / rows)
			//if (total_columns == rows && mcMath.mod(index, rows) != 0) row += 1;
			return source[column][row];
		}
		
		private function outOfRange(index:int):Boolean {
			
			var is_out:Boolean = columns * rows < index;
			return is_out;
		}
		
		private function isCellEmpty(cell:CELL):Boolean {
			
			return cell.item == null;
		}
		
		public function get columns():int {
			
			return total_columns;
		}
		
		public function get rows():int {
			
			return total_rows;
		}
		
		public function set total(value:int):void {
			
			total_rows = value;
		}
		
		public function print():void {
			
			for each (var arr:Array in source) {
				for each (var cell:CELL in arr) {
					trace("Cell:" + cell + " at:" + cell.pos + " index:" + cell.index);
				}
			}
		}
	}
}
import flash.geom.Point;

class CELL {
	
	private var _pos:Point
	private var _index:int;
	private var _item:Object;
	
	public function CELL(pos:Point, index:int, item:Object = null):void {
		
		_pos = pos;
		_index = index;
		_item = item;
	}
	
	public function addItem(item:Object):void {
		
		_item = item;
	}
	
	public function removeItem():void {
		
		_item = null;
	}
	
	public function get index():int {
		
		return _index;
	}
	
	public function get pos():Point {
		
		return _pos;
	}
	
	public function get item():Object {
		
		return _item;
	}
}