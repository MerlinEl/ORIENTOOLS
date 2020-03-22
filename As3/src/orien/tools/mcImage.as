package orien.tools {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
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
		
		static public function fitImageTo(bmp:Bitmap, width:Number, height:Number):Bitmap {
			
			//resize image to fit container
			var m:Matrix = new Matrix();
			m.scale(width / bmp.width, height / bmp.height);
			var fit_bmp:BitmapData = new BitmapData(width, height, false);
			fit_bmp.draw(bmp, m);
			return new Bitmap(fit_bmp);
		}

	}
}		
/*

* Cuts the bitmap out in the shape provided. Please ensure that shape.x and shape.y are
* relative to bitmap (for example 0,0 is top left of bitmap). This way you can position the
* shape within the bitmap. It can also be rotated and scaled etc. Important: The original bitmap
* is unchanged and a new bitmap is created.
* @param bitmapData The source image
* @param shape The shape to cut out
* 
public function cutShapeFromBitmapData( bitmapData : BitmapData, shape : Shape ):BitmapData {
    // Copy the shape to a bitmap
    var shapeBitmapData : BitmapData = new BitmapData( bitmapData.width, bitmapData.height, true, 0x00000000 );
    shapeBitmapData.draw( shape, shape.transform.matrix, null, null, null, true );
    // Now keep the alpha channel, but copy all other channels from the source
    var p : Point = new Point(0, 0);
    shapeBitmapData.copyChannel( bitmapData, bitmapData.rect, p, BitmapDataChannel.RED, BitmapDataChannel.RED );
    shapeBitmapData.copyChannel( bitmapData, bitmapData.rect, p, BitmapDataChannel.GREEN, BitmapDataChannel.GREEN );
    shapeBitmapData.copyChannel( bitmapData, bitmapData.rect, p, BitmapDataChannel.BLUE, BitmapDataChannel.BLUE );
    // Tada!
    return shapeBitmapData;
}

//Draw the mask on to dest using BlendMode.ERASE. This will cut out a hole the same shape as your mask

static public function copyAlphaFromTo(imgBitmap:Bitmap, maskBitmap:Bitmap):Bitmap {
	
	var img:BitmapData = imgBitmap.bitmapData;
	var mask:BitmapData = maskBitmap.bitmapData;
	var mergeBmp:BitmapData = new BitmapData(img.width, img.height, true, 0);
	var rect:Rectangle = new Rectangle(0, 0, img.width, img.height);
	mergeBmp.copyPixels(img, rect, new Point());
	mergeBmp.copyChannel(mask, new Rectangle(0, 0, img.width, img.height), new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
	return new Bitmap(mergeBmp);
}

static public function getAlphaChannel(bmp:Bitmap):BitmapData {
	
	var bd:BitmapData = bmp.bitmapData.clone();
	var alpha_channel:BitmapData = new BitmapData(bd.width, bd.height, true, 0);
	//First lock the data so it shows no changes while we are doing the changes.
	alpha_channel.lock();
	//We now copy the Alpha channel
	alpha_channel.copyChannel(bd, bd.rect, new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
	//After the change we can unlock the bitmapData.
	alpha_channel.unlock();
	return alpha_channel;
}

static public function makeOverlayBitMap(theWidth:int, theHeight:int, theColor:uint):Bitmap{
var bd:BitmapData = new BitmapData(theWidth,theHeight,false, theColor);
var bmp:Bitmap = new Bitmap(bd);
return bmp;

}*/