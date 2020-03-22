
package orien.tools { //can be used only in Air because of HTTPStatusEvent.HTTP_RESPONSE_STATUS
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	
	/**
	 * ...
	 * @author George Profenza
	 * @author Serkan Camur
	 * @author Orien
	 */
	public class mcURLChecker extends EventDispatcher {
		private var _url:String;
		private var _request:URLRequest;
		private var _loader:URLLoader;
		private var _success:Boolean;
		private var _liveStatuses:Array;
		private var _completeEvent:Event;
		private var _dispatched:Boolean;
		private var _log:String = '';
		private var _request_data:Array = new Array("Date", "Last-Modified", "Content-Length", "Content-Type");
		private var _data:mcURLData;
		
		public function mcURLChecker(target:IEventDispatcher = null) {

			super(target);
			init();
		}
		
		private function init():void {
			
			_loader = new URLLoader();
			_loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, _httpStatusResponse);
			//_loader.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorEventHandler);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);
			
			_completeEvent = new Event(Event.COMPLETE, false, true);
		}
		
		/**
		 * Check url and collect requested params
		 * @param	url file url. like: 'http://stackoverflow.com'
		 * @param	req Array of request params. like: ["Date", "Last-Modified", "Content-Length", "Content-Type"]
		 */
		public function check(url:String, req:Array = null):void {
			ftrace("checker check url:%", url)
			
			_liveStatuses = [];//add other acceptable http statuses here
			_dispatched = false;
			_url = url;
			_log = "";
			if (req) _request_data = req;
			_data = new mcURLData();
			_request = new URLRequest(url);
			//_request.method = URLRequestMethod.HEAD; // crash
			_loader.load(_request);
			_log += 'mcURLChecker > load for ' + _url + ' started : ' + new Date() + '\n';
		}
		
		private function _httpStatusResponse(e:HTTPStatusEvent):void {
			//ftrace("_httpStatusResponse...")
			_log += "mcURLChecker > " + e.toString() + ' at ' + new Date() + '\n';
			_success = (e.status >= 200 && e.status < 300);
			if (_success) { //collect parameters
				
				for each (var h:URLRequestHeader in e.responseHeaders) {
					
					if (_request_data.indexOf(h.name) == -1) continue;
					_data.setValue(h.name, h.value);
					//ftrace("header name:% value:%", h.name, h.value);
				}
			}
			dispatchEvent(_completeEvent);
			_dispatched = true;
			unregisterAll();
		}
		
		private function _ioErrorEventHandler(e:IOErrorEvent):void {

			//ftrace("_ioErrorEventHandler...")
			_log += "mcURLChecker > " + e.toString() + ' at ' + new Date() + '\n';
			_success = false;
			if (!_dispatched) {
				//trace("io error dispatch")
				dispatchEvent(_completeEvent);
				_dispatched = true;
				unregisterAll();
			}
		}
		
		private function _securityErrorHandler(e:SecurityErrorEvent):void {
			
			//ftrace("_securityErrorHandler...")
			_log += "mcURLChecker > " + e.toString() + ' at ' + new Date() + '\n';
			_success = false;
			if (!_dispatched) {
				dispatchEvent(_completeEvent);
				_dispatched = true;
				unregisterAll();
			}
		}
		
		public function get success():Boolean {  return _success }
		
		public function get log():String {  return _log }
		
		public function get data():mcURLData {  return _data }
		
		public function get url():String { return _url }
		
		public function unregisterAll():void {
			
			_loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, _httpStatusResponse);
			//_loader.removeEventListener(IOErrorEvent.IO_ERROR, _ioErrorEventHandler); //causing crash
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);
		}
	
	}

}

/* 
//EXAMPLE

import orien.tools.mcURLChecker;
import flash.events.Event;
import orien.tools.mcURLData;

var uc:mcURLChecker = new mcURLChecker();
uc.addEventListener(Event.COMPLETE, onURLCecked);
uc.check('http://www.novaskolabrno.cz/downloads/22-30-0-v2.0-Prvouka-2.exe5');

function onURLCecked(e:Event):void{
	
	var da:mcURLData = uc.data;
	uc.success ? trace('bytes total:'+ da.getValue(da.CONTENT_LENGTH)) : trace ("Error read url.");
	da.print();
}

//EXAMPLE


 DROPPED
 
_loader.addEventListener(Event.COMPLETE, _completeHandler);
_loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, _httpStatusHandler);
private function onProgress(e:ProgressEvent):void {

   trace("progressHandler loaded:" + e.bytesLoaded + " total: " + e.bytesTotal);
   if (!_download && !_dispatched) {
   _bytesTotal = e.bytesTotal;
   _success = _bytesTotal != 0;
   dispatchEvent(_completeEvent);
   _dispatched = true;
   unregisterAll();
   }
   }

   private function _completeHandler(e:Event):void {

   _log += e.toString() + ' at ' + new Date();
   _success = true;
   if (!_dispatched) {
   dispatchEvent(_completeEvent);
   _dispatched = true;
   unregisterAll();
   }
   }

   private function _httpStatusHandler(e:HTTPStatusEvent):void {

   //trace("status:" + e.status + " headers:" + e.responseHeaders)
   _log += e.toString() + ' at ' + new Date();
   _success = (e.status >= 200 && e.status < 300);
   if (!_dispatched) {
   //trace("status dispatch")
   dispatchEvent(_completeEvent);
   _dispatched = true;
   unregisterAll();
   }
*/