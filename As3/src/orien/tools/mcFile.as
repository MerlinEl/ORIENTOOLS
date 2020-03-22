package orien.tools {
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import imag.JPGEncoder;
	import flash.display.MovieClip;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import imost.CustomEvent;
	
	/**
	 * ...
	 * @author René Bača
	 */
	public class mcFile extends MovieClip {
        
		//C:\Users\user\Desktop
		static public const desktop_dir:File = File.desktopDirectory;
		//windows temporary directory folder for the System
		//%Temp% C:\Users\<username>\AppData\Local\Temp
		static public const user_dir:File = File.userDirectory.resolvePath("AppData/Local/Temp/");
		
		public function mcFile() {
		
		}
		
		static public function systemDrive():String {
			
			return desktop_dir.nativePath.charAt(0);
		}
		
		static public function saveFile(data:String, path:String):Boolean {
			
			var file:File = File.desktopDirectory.resolvePath(path);
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE); //open or create file in write mode
			fileStream.writeUTFBytes(data);//write data to the file
			fileStream.close(); //finally, close the filestream
			return true;
		}
		
		static public function readFile(path:String):String {
			
			var fileStream:FileStream = new FileStream(); // Create our file stream
			var file:File = File.desktopDirectory.resolvePath(path);
			if (!file.exists) return "undefined";
			fileStream.open(file, FileMode.READ);
			var content:String = fileStream.readUTFBytes(fileStream.bytesAvailable); // Read the contens of the 
			fileStream.close(); // Clean up and close the file stream
			return content;
		}
		
		static public function readXML(path:String):XML {
			
			var file:File = File.desktopDirectory.resolvePath(path);
			ftrace("file:% exist:%", file.nativePath, file.exists)
			if (!file.exists) return null;
			var xml:XML = new XML(readFile(path));
			return xml;
		}
		
		static public function saveXML(xml:XML, path:String):Boolean {
			
			return saveFile(xml, path)
		}
		
		static public function isFileExists(fpath:String):Boolean {
			
			var file:File = File.desktopDirectory.resolvePath(fpath);
			return (file.exists);
		}
		
		static public function deleteFile(fpath:String):Boolean {
			
			if (!isFileExists(fpath)) return false;
			var file:File = File.documentsDirectory.resolvePath(fpath);
			try {
				
				file.deleteFile();
				
			} catch (e:Error) {
				
				ftrace("Unable delete file:% \n%", fpath, e);
				return false;
			}
			return true;
		}
		
		/**
		 * Get directory that is parent(level) of current directory
		 * @param	levels how many level up from app dir
		 * @return	String
		 */
		static public function getApplicationUpperDir(levels:int = 1):String {
			
			var level_mask:String = "./";
			for (var i:int = 0; i < levels; i++) level_mask += "../"
			var upper_dir:String = new File(File.applicationDirectory.nativePath).resolvePath(level_mask).nativePath;
			return upper_dir;
		}
		
		static public function appPathFromName(fname:String):String {
			
			return File.applicationDirectory.resolvePath(fname).nativePath;
		}
		
		static public function goLevelUp(fpath:String):String {
			
			var last_slash:int = fpath.lastIndexOf("\\");
			return fpath.substring(0, last_slash);
		}
		
		static public function getLastDir(dpath:String):String {
			
			var last_slash:int = dpath.lastIndexOf("\\");
			return dpath.substring(last_slash + 1, dpath.length);
		}
		
		static public function saveImage(bd:BitmapData, path:String):void {
			
			//convert bitmapData to byteArray
			var jpgEncoder:JPGEncoder = new JPGEncoder(78);
			var byteArray:ByteArray = jpgEncoder.encode(bd);
			var file:File = File.desktopDirectory.resolvePath(path);
			//trace("saving file to:"+file.nativePath)
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE); //open or create file in write mode
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
		
		static public function getAppDir(slashes_backward:Boolean = false):String {
			
			if (slashes_backward) return File.applicationDirectory.nativePath;
			//replacing backslashes with forward slashes
			return File.applicationDirectory.nativePath.replace(/\\/g, '/');
		}
		
		static public function getSystemTempDir(new_dir:String = "", slashes_backward:Boolean = false):String {
			
			var dir:String = new_dir.length == 0 ? user_dir.nativePath : user_dir.resolvePath(new_dir).nativePath;
			if (slashes_backward) return dir;
			//replacing backslashes with forward slashes
			return dir.replace(/\\/g, '/');
		}
		
		/**
		 * Collect files from directory by given extension
		 * @param	dir
		 * @param	extension file extension
		 * @return	array of files
		 */
		static public function getFilesFromDir(path:String, extension:String = "all"):Array {
			
			var root_dir:File = File.applicationDirectory.resolvePath(path);
			var all_files:Array = root_dir.getDirectoryListing();
			if (extension == "all") return all_files;
			var chossen_files:Array = new Array();
			for each (var f:File in all_files) {
				
				var ext:String = f.name.split(".").pop();
				if (ext == extension) chossen_files.push(f);
			}
			return chossen_files;
		}
		
		static public function getFileFromPath(path:String):File {
			
			return File.applicationDirectory.resolvePath(path);
		}
		
		static public function getDirectories(path:String, in_native:Boolean = false, include_path:Boolean = false):Array {
			
			var root_dir:File = File.applicationDirectory.resolvePath(path);
			var all_files:Array = root_dir.getDirectoryListing();
			var directories:Array = include_path ? [root_dir] : new Array();
			for each (var f:File in all_files) {
				
				if (!f.isDirectory) continue;
				directories.push(in_native ? f.nativePath : f);
			}
			return directories;
		}
		
		/**
		 * Read file on web and return size
		 * @example
		   var url_stream:URLStream = new URLStream();
		   url_stream.addEventListener(CustomEvent.FINISHED, onReadFile);
		   mcFile.bytesAvailable(url_stream, web_file);
		   function onReadFile(e:CustomEvent):void {
		
		   url_stream.removeEventListener(CustomEvent.FINISHED, onReadFile);
		   var web_size:Number = Number(e.result);
		   iuGlobal.log("web file size:"+ web_size);
		   }
		 * @param	url_stream
		 * @param	url
		 */
		static public function bytesAvailable(url_stream:URLStream, url:String):void {
			
			var url_request:URLRequest = new URLRequest(url);
			try {
				
				url_stream.load(url_request);
				
			} catch (error:Error){
				
				trace("Could not load XML: " + error);
				url_stream.dispatchEvent(new CustomEvent(CustomEvent.FINISHED, 0));
				return;
			}
			
			
			url_stream.addEventListener(ProgressEvent.PROGRESS, onProgress);
			function onProgress(e:ProgressEvent):void {
				
				url_stream.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				url_stream.dispatchEvent(new CustomEvent(CustomEvent.FINISHED, e.bytesTotal));
			}
		}
		
		static public function getSize(fpath:String):Number {
			
			var file:File = File.desktopDirectory.resolvePath(fpath);
			return file.exists ? file.size : 0;
		}
		
		static public function exitApplication():void {
			
			NativeApplication.nativeApplication.exit();
		}
	}
}