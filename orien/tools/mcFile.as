package orien.tools {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import imag.JPGEncoder;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author René Bača
	 */
	public class mcFile extends MovieClip {
		
		public function mcFile() {
		}
		
		static public function saveFile(data:String, path:String):Boolean {
			
			var fname:File = File.desktopDirectory.resolvePath(path);
			var fileStream:FileStream = new FileStream();
			fileStream.open(fname, FileMode.WRITE); //open or create file in write mode
			fileStream.writeUTFBytes(data);//write data to the file
			fileStream.close(); //finally, close the filestream
			return true;
		}
		
		static public function readFile(path:String):String {
			
			var fileStream:FileStream = new FileStream(); // Create our file stream
			var fname:File = File.desktopDirectory.resolvePath(path);
			if (!fname.exists) return "undefined";
			fileStream.open(fname, FileMode.READ);
			var content:String = fileStream.readUTFBytes(fileStream.bytesAvailable); // Read the contens of the 
			fileStream.close(); // Clean up and close the file stream
			return content;
		}
		
		static public function readXML(path:String):XML {
			
			var fname:File = File.desktopDirectory.resolvePath(path);
			if (!fname.exists) return null;
			var xml:XML = new XML(readFile(path));
			return xml;
		}
		
		static public function saveXML(xml:XML, path:String):Boolean {
			
			return saveFile(xml, path)
		}
		
		static public function isFileExists(path:String):Boolean {
			
			var fname:File = File.desktopDirectory.resolvePath(path);
			return (fname.exists);
		}
		
		/**
		 * Get directory that is parent of current directory
		 * @return String
		 */
		static public function getApplicationUpperDir():String {
			
			var upper_dir:String = new File(File.applicationDirectory.nativePath).resolvePath("./../").nativePath;
			return upper_dir;
		}
		
		static public function appPathFromName(fname:String):String {
			
			return File.applicationDirectory.resolvePath(fname).nativePath;
		}
		
		static public function goLevelUp(fpath:String):String {
			
			var last_slash:int = fpath.lastIndexOf("\\");
			return fpath.substring(0, last_slash);
		}
		
		static public function saveImage(bd:BitmapData, path:String):void {
			
			//convert bitmapData to byteArray
			var jpgEncoder:JPGEncoder = new JPGEncoder(78);
			var byteArray:ByteArray = jpgEncoder.encode(bd);
			var fname:File = File.desktopDirectory.resolvePath(path);
			//trace("saving file to:"+fname.nativePath)
			var fileStream:FileStream = new FileStream();
			fileStream.open(fname, FileMode.WRITE); //open or create file in write mode
			fileStream.writeBytes(byteArray);//write byteArray to the file
			fileStream.close(); //finally, close the filestream
		}
		
		static public function loadImageTo(canvas:DisplayObjectContainer, path:String):void {
			
			var bytes:ByteArray = new ByteArray();
			var fs:FileStream = new FileStream();
			var f:File = File.desktopDirectory.resolvePath(path);
			
			fs.addEventListener(Event.COMPLETE, fileCompleteHandler)
			fs.openAsync(f, FileMode.READ);
			
			function fileCompleteHandler(event:Event):void {
				
				fs.readBytes(bytes);
				
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
				loader.loadBytes(bytes);
				
				function imageLoaded(e:Event):void {
					
					fs.removeEventListener(Event.COMPLETE, fileCompleteHandler);
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoaded);
					var bmp:Bitmap = Bitmap(loader.content);
					bmp.smoothing = true; //enable anti-aliasing.
					canvas.addChild(bmp);
					fs.close();
				}
			}
		}
		
		static public function getAppDir():String {
			
			//replacing backslashes with forward slashes
			return File.applicationDirectory.nativePath.replace( /\\/g, '/');
		}
	}
}