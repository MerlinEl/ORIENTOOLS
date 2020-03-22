package orien.tools {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class mcMultiURLChecker extends EventDispatcher {
		
		private var _urlLoader:URLLoader;
		private var _urlRequest:URLRequest;
		private var _data:Object;
		private var _array:Array;
		private var _completeEvent:Event;
		private var _progressEvent:Event;
		private var _failed:Array;
		private var _progressData:Object;
		
		public function mcMultiURLChecker():void {
		
		}
		
		public function loadUrlList(url_list:Array):void {
			
			_array = url_list;
			_data = new Object();
			_failed = new Array();
			_completeEvent = new Event(Event.COMPLETE, false, true);
			_progressEvent = new Event(Event.ADDED, false, true);
			_urlRequest = new URLRequest();
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			//catch errors
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorEventHandler);
			//get more files data
			//_loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, _httpStatusResponse);
			
			loadAsset();
		}
		
		private function loadAsset():void {
			
			if (_array.length > 0) {
				
				var url:String = _array.shift();
				loadNonDisplayAsset(url);
				
			} else {
				
				_urlLoader.removeEventListener(ProgressEvent.PROGRESS, _onProgress);
				_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, _ioErrorEventHandler);
				dispatchEvent(_completeEvent);
				trace("mcMultiURLChecker > queue done !");
			}
		}
		
		private function loadNonDisplayAsset(url:String):void {
			
			_urlRequest.url = url;
			try {
				_urlLoader.load(_urlRequest);
			} catch (e:Error) {
				
				ftrace("mcMultiURLChecker > URL [%] is not found or is corupted. ERROR:\n%", url, e.message);
				_failed.push(url);
			}
		}
		
		private function _onProgress(e:ProgressEvent):void {
			
			//ftrace("mcMultiURLChecker > _onProgress url:% bytes loaded:% total:% ", _urlRequest.url, e.bytesLoaded, e.bytesTotal);
			var fname:String = _urlRequest.url.split("/").pop();
			_progressData = { "fname":fname, "url":_urlRequest.url, "size":e.bytesTotal };
			_data[fname] = _progressData;
			dispatchEvent(_progressEvent);
			loadAsset();
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function get failed():Array {
			return _failed;
		}
		
		public function get progressData():Object {
			return _progressData;
		}
		
		private function _ioErrorEventHandler(e:IOErrorEvent):void {
			
			ftrace("mcMultiURLChecker > _ioErrorEventHandler:%", e.toString());
		}
		
		private function _securityErrorHandler(e:SecurityErrorEvent):void {
			
			ftrace("mcMultiURLChecker > _securityErrorHandler:%", e.toString());
		}
	
	/*private function _httpStatusResponse(e:HTTPStatusEvent):void {
	
	   var success:Boolean = (e.status >= 200 && e.status < 300);
	   if (success) { //collect parameters
	
	   for each (var h:URLRequestHeader in e.responseHeaders) {
	   //ftrace("header name:% value:%", h.name, h.value);
	   if (h.name != "Content-Length") continue;
	
	   var mb:Number = Math.floor(Number(h.value) / 1048576); //convert bytes to MB
	   ftrace("url:% size:%MB bytes:%b", _url, mb, h.value);
	   data.push({"size": h.value, "url": _url, "status": "OK"});
	   }
	   } else {
	
	   data.push({"size": 0, "url": _url, "status": "MISS"});
	   }
	   }*/
	}
}

/*
import flash.events.Event;
import orien.tools.mcMultiURLChecker;

var url_list:Array = ["http://www.novaskolabrno.cz/downloads/IUc-Manager-v1.2.exe",
"http://www.novaskolabrno.cz/downloads/1-056-IUc-Matematika-1-v3.4.exe",
"http://www.novaskolabrno.cz/downloads/2-056-IUc-Matematika-2-v3.4.exe",
"http://www.novaskolabrno.cz/downloads/3-056-IUc-Matematika-3-v3.4.exe",
"http://www.novaskolabrno.cz/downloads/4-056-IUc-Matematika-4-v3.4.exe"]

var len:int = url_list.length;
var nmc:mcMultiURLChecker = new mcMultiURLChecker();
nmc.addEventListener(Event.COMPLETE, onComplete);
nmc.addEventListener(Event.ADDED, onAdded)
nmc.loadUrlList(url_list);
function onAdded(e:Event):void{
	
	ftrace("Added:%(all)", nmc.progressData);
}

function onComplete(e:Event):void{
	
	nmc.removeEventListener(Event.COMPLETE, onComplete);
	for (var fname:String in nmc.data){
		
		var item:Object = nmc.data[fname]; 
		ftrace("Server files fname:% size:%", fname, item["size"]);
	}
}
*/