package orien.tools {
	
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import imost.InitAfterValidate;
	import orien.tools.mcArray;
	
	public class mcImageSlice extends MovieClip {
		
		//interface parameters
		public var shuffle:Boolean = false;
		public var rotate:Boolean = false;
		public var tiles_h:Number = 4;
		public var tiles_v:Number = 4;
		
		private var all_tiles:mcArray;
		private var sliced:Boolean = false;
		
		public function mcImageSlice() {
			
			
		}
		
		public function slice():void{
			
			new InitAfterValidate(this, "tiles_h", sliceImage); //wait for variable is accesible
		}
		
		private function sliceImage():void {
			
			if (!sliced){ 
			
				var bd_source:BitmapData = new BitmapData(width, height);
				bd_source.draw(this);
				
				//ftrace("tiles:[%,%]", tiles_v, tiles_h)
				//var bmp:Bitmap = new Bitmap(bd_source); 
				//parent.addChild(bmp)
				
				all_tiles = new mcArray();
				var tile_width:Number = mcMath.roundTo(width / tiles_v, 2);
				var tile_height:Number = mcMath.roundTo(height / tiles_h, 2);
				var pos_x:Number = 0;
				var pos_y:Number = 0;
				var tiles_total:int = tiles_v * tiles_h;
				while (tiles_total > 0){
					
					tiles_total--;
					//if row end reached
					if (pos_x+tile_width > tile_width*tiles_v){
						
						pos_x = 0; //go to start
						pos_y += tile_height; //add new line
					}
					var pos:Point = new Point(pos_x, pos_y);
					//ftrace("get tile at pos:%", pos)
					var tile:MovieClip = getImageTile(bd_source, tile_width, tile_height, pos);
					tile.x = pos.x;
					tile.y = pos.y;
					tile["start_tm"] = {"rotation":tile.rotation, "pos":mcTran.pos(tile)};
					pos_x += tile_width;
					addChild(tile);
					all_tiles.addItem(tile);
				}
				sliced = true;
				removeChildAt(0); //remove original image
			}
			randomize();
		}
		
		public function randomize():void{
			
			var tile:MovieClip;
			if (shuffle){
			
				var all_pos:Array = all_tiles.extractPositions();
				all_tiles.shuffle();
				for each (tile in all_tiles.source) mcTran.pos(tile, all_pos.pop());
			}
			if (rotate) {
					
				var all_angles:mcArray = new mcArray([90, 180, -90, -180]) 
				for each (tile in all_tiles.source) {
					
					var random_angle:int = all_angles.getRandomItem(); 
					mcTran.rotateAroundCenter(tile, random_angle);		
				}	
			}
		}
	
		//get section from image bdata
		private function getImageTile(bd_source:BitmapData, w:Number, h:Number, pos:Point):MovieClip {
			
			var bd_target = new BitmapData(w, h, false, 0x000000FF);
			var rect:Rectangle = new Rectangle(pos.x, pos.y, w, h);
			bd_target.copyPixels(bd_source, rect, new Point(0, 0));
			var tile:MovieClip = new MovieClip();
			tile.addChild(new Bitmap(bd_target));
			return tile;
		}

		public function restore():void{
			
			var next_delay:Number = 0.1;
			for each (var t:MovieClip in all_tiles.source) {
				
				var pos:Point = t.start_tm.pos as Point;
				var angle:Number = t.start_tm.rotation;
				TweenLite.to(t, 1, {x:pos.x, y:pos.y, rotation:angle, delay:next_delay})
				next_delay += 0.1;
			}
		}
	}

}
