/*
import orien.tools.mcMultiLoadXML;
var server_dir:String = "http://www.novaskolabrno.cz/downloads"
var fnames:Array = ["IUc_Patch_List.xml", "IUc_Product_List.xml", "IUc_Settings.xml"]
var url_list:Array = new Array();
for each(var fname in fnames) {
	url_list.push(server_dir + "/" + fname);
}

var ml:mcMultiLoadXML = new mcMultiLoadXML(url_list);
ml.addEventListener(Event.COMPLETE, onComplete);
function onComplete(e:Event):void {
	
	ml.removeEventListener(Event.COMPLETE, onComplete);
	ml.sortBy("label");
	var xml_data:Array = ml.getAllXML();
	for each (var xml:XML in xml_data) ftrace("xml data:\n%", xml);
}
 */

package orien.tools {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author pkyeck
	 * @author Orien
	 */
	public class mcMultiLoadXML extends EventDispatcher {
		
		private var urlLoader:URLLoader;
		private var queue:Array = new Array();
		private var data:Array = []; //XML array

		public function mcMultiLoadXML(xml_paths:Array) {
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
			for each (var path in xml_paths) {
				
				loadData(path);
			}
			doQueue();
		}
		
		private function loadData(url:String):void {
			
			ftrace("Loading url:%", url)
			var request:URLRequest = new URLRequest(url);
			queue.push(request);
		}
		
		private function doQueue() {
			
			if (queue.length > 0) {
				var arr:Array = queue.splice(0, 1);
				var req:URLRequest = arr[0] as URLRequest;
				urlLoader.load(req);
			} else {
				trace("mcMultiLoadXML > queue done !");
				urlLoader.removeEventListener(Event.COMPLETE, onComplete);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function onComplete(event:Event):void {
			
			try {
				var loader:URLLoader = URLLoader(event.target);
				var result:XML = new XML(loader.data);
				data.push(result);// suppose data is Array and a property in the class.
				
			} catch (error:Error) {
				
				trace("Could not load XML: " + error);
			}
			doQueue();
		}
		
		private function onIOError(e:IOErrorEvent):void {
			
			trace("An error occured trying to load the XML: " + e.text);
		}
		
		public function getAllXML():Array {
			
			return data;
		}
		
		public function sortBy(key:String):void {
			
			for (var i:int = 0; i < data.length; i++) {
				
				data[i] = mcTranXML.sortXMLByAttribute(data[i], key);
			}
		}
	}
}