package orien.tools {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcBitmapData {
		
		public function mcBitmapData() {
		
		}
		
		static public function colorize(bd:BitmapData, color:uint):void {
			
			var rgb:Object = mcColor.hexToRgb(color);
			var matrix:Array = new Array();
			matrix = matrix.concat([rgb.r / 255, 0, 0, 0, 0]); // red
			matrix = matrix.concat([rgb.g / 255, 0, 0, 0, 0]); // green
			matrix = matrix.concat([rgb.b / 255, 0, 0, 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			bd.applyFilter(bd, bd.rect, new Point(), filter);
		}
		
		static public function blackToTransparent(bd:BitmapData):BitmapData {
			
			var new_bd:BitmapData = new BitmapData(bd.width, bd.height, true, 0xFFFFFFFF);
			new_bd.copyChannel(bd, new_bd.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
			return new_bd;
		}

		/** Not used not tested
		 * clear bitmap data transparent or black
		 * @param	bd
		 * @param	transparent
		 */
		static private function clear(bd:BitmapData, transparent:Boolean = true):void {
			
			transparent ? bd.fillRect(bd.rect, 0xFFFFFFFF) : bd.fillRect(bd.rect, 0x000000);
		}
		
		/**
		 * get bitmapData from object with pivot at TopLeft (transparent)
		 * @param	obj		movieclip with graphics inside
		 * @param	tint	if is defined bitmap data will be colorized
		 * @return
		 */
		static public function fromObject(obj:DisplayObject, tint:uint = undefined):BitmapData{
			
			var bd:BitmapData = new BitmapData(obj.width, obj.height, true, 0xFFFFFF);
			bd.draw(obj);
			if (tint) mcBitmapData.colorize(bd, tint); //colorize if set
			return bd;
		}
		
		
		/** NOT USED because of complexity of use is better have always graphic from TopLeft :)))
		 *	get bitmapData from object with pivot at center
		 *	shift bitmapData back to center >
		 * 	var b:Bitmap = new Bitmap(bd);
		 *	b.x -= obj.width / 2;
		 *	b.y -= obj.height / 2;
		 * @param	obj		movieclip with graphics inside
		 * @param	tint	if is defined bitmap data will be colorized
		 * @return
		 */
		static public function fromObjectCenter(obj:DisplayObject, tint:uint = undefined):BitmapData{
			
			//shift rect from Center at TopLeft
			var m:Matrix = new Matrix(1, 0, 0, 1, (obj.width / 2), (obj.height / 2));
			//create new bitmapdata at obj size
			var bd:BitmapData = new BitmapData(obj.width, obj.height, true, 0xFFFFFF); //get trasparent
			bd.draw(obj, m); //draw data by shifted matrix
			if (tint) colorize(bd, tint); //colorize if set
			return bd;
		}
		
		/*static public function colorFromObject(obj:DisplayObject, find_clr:Array, debug:Boolean = true):BitmapData{
			
var new_obj:Sprite = new Sprite();
var new_bd:BitmapData = new BitmapData(obj.width, obj.height, true); //, 0xFFFFFF 0x000000
			var bd:BitmapData = fromObject(obj);
			for (var x:int = 0;  x < obj.width; x++){
			
				for (var y:Number = 0; y < obj.height; y++){
					
					var clr:int = bd.getPixel(x, y);
					if (!colorExists(clr, find_clr)) continue;
					if (debug) new_bd.setPixel(x, y, clr);
				}
			}
if (debug) new_obj.addChild(new Bitmap(new_bd));			
if (debug) obj.parent.parent.addChild(new_obj);
			return new_bd;
		}*/
		
		/**
		 * Not wery accurate mut be tested again....
		 * @example var bg_pixels_count:int = mcBitmapData.pixelsCountByColor(_canvas, [_color_fill, _color_border]);
		 * @param	obj
		 * @param	find_clr
		 * @param	debug
		 * @return
		 */
		static public function pixelsCountByColor(obj:DisplayObject, find_clr:Array, debug:Boolean = false):int{
			
			var pixels_count:int = 0;
var new_obj:Sprite = new Sprite();
var new_bd:BitmapData = new BitmapData(obj.width, obj.height, false, 0x2FFF17);
			var bd:BitmapData = fromObject(obj);
			for (var x:int = 0;  x < obj.width; x++){
			
				for (var y:Number = 0; y < obj.height; y++){
					
					var clr:int = bd.getPixel(x, y);
					if (!colorExists(clr, find_clr)) continue;
					pixels_count++;
					new_bd.setPixel(x, y, clr);
					//ftrace("[x:%, y:%] clr:% clr16:%", x, y, clr, clr.toString(16));
				}
			}
if (debug) new_obj.addChild(new Bitmap(new_bd));			
if (debug) obj.parent.parent.addChild(new_obj);
			return pixels_count;
		}
		
		
		static public function colorExists(find_clr:uint, clr_arr:Array):Boolean{
			
			for each (var clr:uint in clr_arr){
				
				if (clr == find_clr) return true;
			}
			return false;
		}
	}
}