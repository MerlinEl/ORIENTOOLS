package orien.tools {
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author intuitivepixel
	 * @author René Bača (Orien) 2016
	 */
	public class mcExecute extends EventDispatcher {
		
		private var _alert:mcMsgBox;
		private var _fpath:String;
		private var _response:String = "";
		private var _nativepcs:NativeProcess;
		private var _completeEvent:Event;
		public var exitCode:String;
		private var _error_list:Array = [
		
			"file not found",
			"native process unsupported",
			"illegal operation error",
			"argument error",
			"error",
			"0 = done",
			"1",
			"2 = aborted",
			"3",
			"4",
			"5",
			"abort or failed"
		]
		public var args:Vector.<String>;
		
		/**
		 * Execute and application with arguments
		 * @param	fpath	"C:\ffmpeg.exe";
		 * @param	params	"-i input.avi -b 64k output.avi";
		 */
		public function mcExecute():void {
			
		}
		
		public function load(fpath:String, params:String = ""):void {
			
			_fpath = fpath;
			_completeEvent = new Event(Event.COMPLETE, false, true);
			
			var file:File = File.applicationDirectory.resolvePath(fpath); //or var file:File = new File(fpath);
			if (!file.exists) {
				
				sendResponse("file not found", "File:[" + fpath + "] not found.");
				return;
			}
			
			if (NativeProcess.isSupported) {
				
				var npsi:NativeProcessStartupInfo = new NativeProcessStartupInfo();
				if (params.length != 0) {
					
					args = new Vector.<String>();
					var parameters:Array;
					parameters = params.split(" ");
					for each (var parameter:String in parameters) {
						args.push(parameter);
					}
					npsi.arguments = args;
				}
				
				npsi.executable = file;
				var work_dir:File = File.applicationDirectory.resolvePath(fpath.substring(0, fpath.lastIndexOf("/")));
				npsi.workingDirectory = work_dir;
				
				_response += "mcExecute > exePath:" + file.nativePath + "\nworkDir" + npsi.workingDirectory.nativePath + "\n"

				startExecution(npsi);
				
			} else {
				
				sendResponse("native process unsupported", "NativeProcess isnot supported.");
			}		
		}
		
		private function startExecution(npsi:NativeProcessStartupInfo):void {
			
			_nativepcs = new NativeProcess();
			_nativepcs.addEventListener(NativeProcessExitEvent.EXIT, onCloseApp);
			//_nativepcs.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, errorDataHandler);
			
			try {
				
				_nativepcs.start(npsi);
				_nativepcs.standardInput.writeUTFBytes(args + "\n"); 
				_response += "mcExecute > Trying to start process\n";
				
			} catch (error:IllegalOperationError) {
				
				sendResponse("illegal operation error", "Illegal Operation: " + error.toString());
				
			} catch (error:ArgumentError) {
				
				sendResponse("argument error", "Argument Error: " + error.toString());
				
			} catch (error:Error) {
				
				sendResponse("error", "Error: " + error.toString());
			}
			
			if (_nativepcs.running) {
				
				_response += "mcExecute > Native Process Support\n";
			}
		}
		
		private function onCloseApp(event:NativeProcessExitEvent):void {
			
			_nativepcs.removeEventListener(NativeProcessExitEvent.EXIT, onCloseApp);
			var code:String = event.exitCode == 0 ? "done" : "abort or failed"
			sendResponse(code, "Native Process Exit code: " + event.exitCode);
		}
		
		public function get response():String {
			
			return _response;
		}
		
		private function sendResponse(code:String, msg:String):void {
			
			exitCode = code;
			_response += "mcExecute > " + msg + "\n";
			dispatchEvent(_completeEvent);
		}
		
		/*private function errorDataHandler(event:ProgressEvent):void {
			
			//var errorBytes:ByteArray = new ByteArray();
			//errorBytes.writeBytes(_nativepcs.standardError.readBytes(_nativepcs.standardError.bytesAvailable)); 
			sendResponse("STANDARD_ERROR_DATA:");
		}*/
	}
}