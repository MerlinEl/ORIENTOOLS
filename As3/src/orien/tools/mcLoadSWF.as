package orien.tools {
	
	import com.greensock.TweenLite;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class mcLoadSWF extends MovieClip {
		
		public var swf_reference:MovieClip;
		private var _class_path:String;
		private var _loader:Loader;
		private var _offset:Point;
		private var _swf_path:String;
		private var _loaded:Boolean = false;
		
		public function mcLoadSWF():void {
		/*
		   import orien.tools.mcLoadSWF;
		   import flash.events.Event;
		   var lo:mcLoadSWF = swf_container_01 as mcLoadSWF;
		   btn_01.on_up = function(){
		   lo.addEventListener(Event.COMPLETE, loadModel);
		   lo.loadSWF("earth_01.swf");
		   }
		   function loadModel(e:Event):void{
		   lo.removeEventListener(Event.COMPLETE, loadModel);
		   stage.addEventListener(Event.RESIZE, onResize);
		   }
		   function onResize(event:Event = null):void {
		   lo.swf_reference["fitTo"](lo.width, lo.height);
		   }
		   btn_02.on_up = function(){
		   lo.swf_reference["fitTo"](500, 500);
		   }
		   btn_03.on_up = function(){
		   lo.swf_reference["fitTo"](600, 600);
		   }
		   btn_04.on_up = function(){
		   lo.unloadSWF();
		   }
		 */
		}
		
		public function loadSWF(swf_path:String):void {
			
			if (_loaded) unloadSWF();
			_loader = new Loader();
			_swf_path = swf_path;
			//ftrace("mcLoadSWF > loadSWF > swf path:%", swf_path);
			var ldrContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_loader.load(new URLRequest(swf_path), ldrContext);
		}
		
		public function unloadSWF():void {
			
			if (!_loaded) return;
			if (swf_reference) removeChild(swf_reference);
			SoundMixer.stopAll();
			_loader = null;
			_loaded = false;
			swf_reference = null;
		}
		
		private function completeHandler(e:Event):void {
			
			unregister();
			swf_reference = LoaderInfo(e.currentTarget).content as MovieClip;
			//ftrace("mcLoadSWF > completeHandler > swf_reference:%", swf_reference);
			
			swf_reference.alpha = 0;
			addChild(swf_reference);
			_loaded = true;
			
			TweenLite.to(swf_reference, 1.2, {alpha: 1, delay: 0.1, onComplete: function() {
				
				dispatchEvent(new Event(Event.COMPLETE));
			}});
		}
		
		private function onError(e:IOErrorEvent):void {
			
			ftrace("Unable to load:%", e.text);
			unregister();
		}
		
		private function unregister():void {
			
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
		}
	}
}
