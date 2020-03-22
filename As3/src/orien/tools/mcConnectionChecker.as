package orien.tools {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	/// @eventType	orien.tools.mcConnectionChecker.CHECK_COMPLETED
	[Event(name = "checkCompleted", type = "flash.events.Event")]
	public class mcConnectionChecker extends EventDispatcher {
		
		public static const CHECK_COMPLETED:String = "checkCompleted";
		
		// Though google.com might be an idea, it is generally a better practice
		// to use a url with known content, such as http://foo.com/bar/mytext.txt
		// By doing so, known content can also be verified.
		// This would make the checking more reliable as the wireless hotspot sign-in
		// page would negatively intefere the result.
		private var _urlToCheck:String = "http://www.google.com";
		private var _contentToCheck:String = "head";
		
		private var loader:URLLoader;
		public var success:Boolean = false;
		
		/**
		 * @example
		   private function checkConnection():void {
		
		   checker = new mcConnectionChecker();
		   checker.addEventListener(mcConnectionChecker.CHECK_COMPLETED, checkCompleted);
		   checker.check();
		   }
		
		   private function checkCompleted(e:Event):void {
		
		   checker.removeEventListener(mcConnectionChecker.CHECK_COMPLETED, checkCompleted);
		   if (checker.result == "success") {
		
		   console.text = "NS Registry FIX 2017 > The internet connection estabilished.";
		
		   } else {
		
		   console.text = "> There is no internet connection.";
		   }
		   }
		 */
		public function mcConnectionChecker() {
			
			super();
		}
		
		public function check():void {
			
			var urlRequest:URLRequest = new URLRequest(_urlToCheck);
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			try {
				loader.load(urlRequest);
			} catch (e:Error) {
				dispatchEvent(new Event(CHECK_COMPLETED));
			}
		}
		
		private function onComplete(e:Event):void {
			
			unregister();
			var textReceived:String = loader.data as String;
			//ftrace("textReceived:%", textReceived)
			if (textReceived) {
				if (textReceived.indexOf(_contentToCheck) != -1) {
					success = true;
					dispatchEvent(new Event(CHECK_COMPLETED));
				} else {
					dispatchEvent(new Event(CHECK_COMPLETED));
				}
			} else {
				dispatchEvent(new Event(CHECK_COMPLETED));
			}
		}
		
		private function onError(e:IOErrorEvent):void {
			
			unregister();
			dispatchEvent(new Event(CHECK_COMPLETED));
		}
		
		private function unregister():void {
			
			loader.removeEventListener(Event.COMPLETE, onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
		}
	}
}