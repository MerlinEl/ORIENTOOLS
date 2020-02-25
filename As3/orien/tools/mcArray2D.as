package orien.tools {
	import flash.text.TextField;
	import orien.tools.mcArray;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 * @default	A 2 Dimensional mcArray: (MENU)
	 * @example Shuffle cards horizontal and vertical in mcArray2D, after this generate examples which will be shuffled too :) 
	 *
	 * A container with many columns, and each column have many rows
	 *	[column]	[column]	[column]
	 * 	-row		-row		-row
	 * 	-row		-row		-row
	 * 	-row		-row		-row
	 */
	public class mcArray2D {
		
		public var source:mcArray = new mcArray();
		
		public function mcArray2D(column_cnt:int = 0) {
			
			for (var i:int = 0; i < column_cnt; i++) source.addItem(new COLUMN(i));
		}
		
		//COLUMNS operation
		public function addColumn(column:COLUMN):void {
			
			source.addItem(column);
		}
		
		public function removeColumn(index:int):void {
			
			source.removeItemAt(index);
		}
		
		public function getColumn(index:int):COLUMN {
			
			return source.getItemAt(index) as COLUMN;
		}
		
		public function shuffleColumns():void {
			
			source.shuffle();
		}
		
		//ROWS operation
		public function addRow(column_index:int, data:Object, key:String):void {
			
			var column:COLUMN = getColumn(column_index);
			column.addData(data, key);
		}
		
		public function shuffleRows(key:String):void {
			
			for each (var column:COLUMN in source) column.shuffle(key);
		}
		
		public function getRow(column_index:int, key:String):Object {
			
			var column:COLUMN = getColumn(column_index);
			return column.getData(key);
		}
		
		//Optional operations
		
		public function printData(key:String):void {
			
			for (var i:int = 0; i < source.length; i++) {
				
				var column:COLUMN = getColumn(i);
				trace("Column index:"+ column.index+" data:["+key+"] "+ column.getData(key));
			}
		}
		
		public function get length():int {
			
			return source.length;
		}
	}
}