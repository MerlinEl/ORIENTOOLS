/*
import orien.tools.mcGrid2D;
import flash.geom.Point;
var all_rows:Array = [
						
	[10, 15, 90, 12, 8,  78, 14, 48, 66, 30],
	[9,  11, 42, 29, 21, 17, 25, 43, 35, 13],
	[2,  4,  18, 63, 56, 24, 33, 72, 99, 45],
	[5,  25, 65, 30, 85, 90, 40, 50, 16, 20],
	[8,  31, 17, 61, 29, 6,  34, 60, 23, 16],
	[3,  18, 12, 9,  36, 27, 44, 25, 55, 85],
	[7,  35, 17, 5,  31, 40, 27, 9,  24, 35],
	[4,  40, 60, 96, 48, 19, 49, 65, 33, 80],
	[6,  54, 66, 13, 12, 30, 42, 36, 29, 15],
	[1,  45, 19, 26, 32, 7,  55, 24, 81, 70]
]
var grid:mcGrid2D = new mcGrid2D(10,10);
for (var col:int = 0; col < grid.columns; col++){

	for (var row:int = 0; row < grid.rows; row++ ){	
		
		var val:int = all_rows[col][row];
		//ftrace("add item[%] at pos[x:%, y:%]",val, row, col)
		grid.addItemAtPos(val, new Point(row, col));
	}
}

//grid.print();
grid.printAsGrid();

var cell = grid.getItemAt(45);
trace("cel 45:"+cell)
 */


package orien.tools {
	
	import flash.geom.Point;
	
	public class mcGrid2D {
		
		public var DEBUG:Boolean = false;
		private var _columns:int = 0;
		private var _rows:int = 0;
		private var _source:Array = []; //rows array
		
		public function mcGrid2D(columns:int, rows:int) {
			
			_columns = columns;
			_rows = rows;
			var index:int = 0;
			for (var y:int = 0; y < columns; y++){
	
				var row_arr:Array = [];
				if (DEBUG) ftrace("mcGrid2D > Add ROW[%]", y);
				for (var x:int = 0; x < rows; x++ ){	
					
					var cell:CELL = new CELL(new Point(x, y), index);
					row_arr.push(cell);
					if (DEBUG) ftrace("mcGrid2D > Build > %", cell);
					index++;
				}
				_source.push(row_arr);
			}
		}

		/**
		 * Get item from cell if is not empty.
		 * @param	index
		 * @return
		 */
		public function getItemByIndex(index:int):* {
			
			if (outOfRange(index)) {
				errorMSG(1, index);
				return null;
			}
			var pos:Point = indexToPos(index); 
			var cell:CELL = getCellFrom(pos);
			if (cell.isEmpty()) {
				errorMSG(4, index);
				return null;
			}
			if (DEBUG) ftrace("mcGrid2D > getItemAt > index:% got:%", index, cell.index);
			return cell.item;
		}
		
		private function indexToPos(index:int):Point {
			
			var pos:Point = new Point();
			if (index < 10){
			
				pos.x = index;
				pos.y = 0;
			} else {
				
				var num_arr:Array = String(index).split("");
				pos.x = int(num_arr[1]);
				pos.y = int(num_arr[0]);
			}
			return pos;
		}
		
		private function getCellFrom(pos:Point):CELL {
		
			if (pos.x > _rows || pos.y > _columns){
				
				errorMSG(1, pos);
				return null;
			}
			return _source[pos.y][pos.x] as CELL;
		}
		
		/**
		 * Add an Object at specified position in Grid
		 * @param	item
		 * @param	pos
		 * @param	replace
		 */
		public function addItemAtPos(item:Object, pos:Point, replace:Boolean = true):void {
			
			if (pos.x > _rows || pos.y > _columns){
				
				errorMSG(1, pos);
				return;
			}
			var cell:CELL = _source[pos.y][pos.x] as CELL;
			if (!replace && !cell.isEmpty()) {
				errorMSG(2, pos);
				return;
			}
			cell.addItem(item);
		}
		
		/*public function getRow(column_index:int):Array{
			
			if (column_index > _columns){
				
				errorMSG(1, column_index);
				return null;
			}
			return _source[column_index] as Array;
		}*/
		
		private function outOfRange(index:int):Boolean {
			
			var is_out:Boolean = columns * rows < index;
			return is_out;
		}
	
		public function get columns():int {
			
			return _columns;
		}
		
		public function get rows():int {
			
			return _rows;
		}
		
		public function get length():int {
			
			return _columns * _rows;
		}
		
		public function print():void {
			
			for (var y:int = 0; y < _source.length; y++) {
				
				var arr:Array = _source[y];
				ftrace("mcGrid2D > Get ROW[%]:", y);
				for each (var cell:CELL in arr) {
					
					trace(cell);
				}
			}
		}
		
		public function printAsGrid():void{
			
			var out:String = "";
			for (var y:int = 0; y < _source.length; y++) {
				
				var arr:Array = _source[y];
				for each (var cell:CELL in arr) {
					
					out += cell.item + "\t";
				}
				out += "\n";
			}
			ftrace("GRID ITEMS [%]:\n%", length, out);
		}
	
		public function reverseRows():void{
			
			_source.reverse();
		}
		
		public function reverseCollumns():void{
			
			for each (var row:Array in _source) row.reverse();
		}
		
		private function errorMSG(index:int, value:* = null):void {
			
			switch (index) {
			
			case 1: 
				trace("Index:[" + value + "] is out of range.");
				break;
			case 2: 
				trace("addItemAtPos Failed! Cell at place:[" + value + "] is not empty. Try another one.");
				break;
			case 3: 
				trace("addItem Failed! Grid is full");
				break;
			case 4: 
				trace("getItemAt Failed! Cell is empty.");
				break;
			}
		}
	}
}
import flash.geom.Point;

internal class CELL {
	
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
	
	public function isEmpty():Boolean {
			
		return _item == null;
	}
	
	public function toString() {
		
		return 'CELL(pos:' + _pos + ' index:' + _index + ' item:' + _item + ')';
	}
}

/*
Not Used Yet | Not Tested

public function addItemAtIndex(item:Object, index:int, replace:Boolean = true):void {
	
	if (outOfRange(index)) {
		errorMSG(1, index);
		return;
	}
	var cell:CELL = getCellByIndex(index);
	//trace("addItemAt >> " + index + " item:" + item + " cell:" + cell)
	if (!replace && !cell.isEmpty()) {
		errorMSG(2, index);
		return;
	}
	cell.addItem(item);
}

public function getAllItems():Array {
	
	var all_items:Array = new Array();
	for each (var arr:Array in _source) {
		for each (var cell:CELL in arr) {
			if (!cell.isEmpty()) all_items.push(cell.item);
		}
	}
	return all_items;
}
*/