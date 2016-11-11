package orien.tools {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author René Bača (Orien 2016)
	 */
	public class mcImage {
		
		public function mcImage() {
		
		}
		
		static public function drawTiledImageTo(sp:Sprite, bmp:Bitmap, width:Number, height:Number, tiles:int):void {
			
			//resize image to fit container tiled
			var m:Matrix = new Matrix();
			var scale:Number = Math.round((width / tiles) / bmp.width);
			m.scale(scale, scale);
			//tile image
			sp.graphics.clear();
			sp.graphics.beginBitmapFill(bmp.bitmapData, m, true, true);
			sp.graphics.drawRect(0, 0, width, height);
			sp.graphics.endFill();
		}
		
		static public function drawFitImageTo(sp:Sprite, bmp:Bitmap, width:Number, height:Number):void {
			
			var fit_bmp:Bitmap = fitImageTo(bmp, width, height);
			//fit image
			sp.graphics.clear();
			sp.graphics.beginBitmapFill(fit_bmp.bitmapData);
			sp.graphics.drawRect(0, 0, width, height);
			sp.graphics.endFill();
		}
		
		static public function fitImageTo(bmp:Bitmap, width:Number, height:Number):Bitmap{
			//resize image to fit container
			var m:Matrix = new Matrix();
			m.scale(width / bmp.width, height / bmp.height);
			var fit_bmp:BitmapData = new BitmapData(width, height, false);
			fit_bmp.draw(bmp, m);
			return new Bitmap(fit_bmp);
		}
	}
}