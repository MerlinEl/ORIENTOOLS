package orien.tools {
	
	/**
	 * ...
	 * @author René Bača 2016 (Orien)
	 */
	public class mcURLData {
		
		public var DATE:String = "Date";
		public var SERVER:String = "Server";
		public var LAST_MODIFIED:String = "Last-Modified";
		public var ETAG:String = "ETag";
		public var ACCEPT_RANGES:String = "Accept-Ranges";
		public var CONTENT_LENGTH:String = "Content-Length";
		public var CONNECTION:String = "Connection";
		public var CONTENT_TYPE:String = "Content-Type";
		
		private var source:Object;
		
		public function mcURLData() {
		
			source = new Object();
		}
		
		public function setValue(key:String, val:*):void {
			
			source[key] = val;
		}
		
		/**
		 * @example
		 * var da:mcURLData = uc.data;
		 * var bytesTotal:Number = da.getValue(da.CONTENT_LENGTH);
		 * @param	key
		 * @return
		 */
		public function getValue(key:String):*{
			
			return source[key];
		}
		
		public function print():void{
			
			for (var key:String in source){
				
				trace("key:" + key + " val:" + source[key]);
			}
		}
	}
}

/*
header name:Content-Length value:601728
header name:Content-Type value:application/x-msdos-program
header name:Last-Modified value:Wed, 07 Dec 2016 16:40:47 GMT
key:Content-Length val:601728
key:Last-Modified val:Wed, 07 Dec 2016 16:40:47 GMT
key:Content-Type val:application/x-msdos-program
*/