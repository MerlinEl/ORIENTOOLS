/*
	var n:mcLoadXML = new mcLoadXML("../BubbleText.xml");
	n.addEventListener(Event.COMPLETE, onComplete);
	function onComplete(event:Event):void {
		
		n.removeEventListener(Event.COMPLETE, onComplete);
		XML_DATA = n.getXML();
		sortXmlByLabel();
	}
   
   //Used by: LessonBubble
 */

package orien.tools {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Serkan Camur
	 * @author Orien
	 */
	public class mcLoadXML extends EventDispatcher {
		
		private var data:XML;
		private var urlLoader:URLLoader;
		
		public function mcLoadXML(xml_save_path:String) {
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
			urlLoader.load(new URLRequest(xml_save_path));
		}
		
		private function onComplete(event:Event):void {
			
			try {
				data = new XML(event.target.data);
				//trace("data:"+data)
				urlLoader.removeEventListener(Event.COMPLETE, onComplete);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				
				dispatchEvent(new Event(Event.COMPLETE));
			} catch (error:Error) {
				trace("Could not load XML: " + error);
			}
		}
		
		private function onIOError(e:IOErrorEvent):void {
			
			trace("An error occured trying to load the XML: " + e.text);
		}
		
		public function getXML():XML {
			
			return data;
		}
	}
}