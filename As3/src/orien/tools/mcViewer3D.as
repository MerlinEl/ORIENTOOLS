package orien.tools {
	
	import a3d.dim3.SceneWithControls;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import iface.AllertBox;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcViewer3D {
		
		private var _win:NativeWindow;
		private var _swf:MovieClip;
		private var _old_fps:int;
		private var btn_exit:btnExit;
		private var btn_rotate:btnPlay;
		private var btn_offset:Number = 40;
		private var btn_audio:btnAudio;
		private var text_box:txtLabel;
		private var _debug:Boolean = false;
		
		public function mcViewer3D() {
			
			//http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html
		}
		
		/**
		 *
		 * @param	fpath
		 * @param	full_screen
		 * @param	transparent
		 * @param	optional	centred, width, height
		 */
		public function show(owner:NativeWindow, fpath:String, full_screen:Boolean = true, transparent:Boolean = false, optional:Object = null):void {
			
			var op:NativeWindowInitOptions = new NativeWindowInitOptions();
			op.type = NativeWindowType.UTILITY
			op.renderMode = "direct";
			//set parent window (when parent close this close too)
			op.owner = owner;
			
			if (transparent) {
				
				op.transparent = true;
				op.systemChrome = NativeWindowSystemChrome.NONE;
			}
			if (optional["borderless"]) op.systemChrome = NativeWindowSystemChrome.NONE;
			//op.resizable = true;
			//op.maximizable = true;
			//op.minimizable = true;
			_win = new NativeWindow(op);
			_old_fps = _win.stage.frameRate;
			//_win.stage.stageWidth = 800; //not works
			//_win.stage.stageHeight = 800;
			if (full_screen) {
				
				_win.stage.align = StageAlign.TOP_LEFT;
				_win.stage.scaleMode = StageScaleMode.NO_SCALE;
				_win.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			} else {

				if (optional["bounds"]) _win.bounds = optional["bounds"];
			}
			_win.title = "Ns 3DViewer v0.01";
			if (optional["front"]) _win.alwaysInFront = true;
			//_win.alwaysInFront = false;
			if (_debug) {
				
				text_box = new txtLabel();
				text_box.initParams({"x": 0, "y": 0, "name": "text_box"});
				text_box.text = "Loading...";
				//text_box.text = "old fps:"+_old_fps + "\ncurrent fps:" + _win.stage.frameRate;
				_win.stage.addChild(text_box);
			}
			_win.activate();
			if (optional["centred"]) centerToScreen();
						
			var swfLoader:Loader = new Loader();
			swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadSWFToWindow)
			swfLoader.load(new URLRequest(fpath));
			function loadSWFToWindow(e:Event):void {
				
				swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadSWFToWindow)
				_swf = e.target.content as MovieClip;
				_swf.addEventListener("PRELOADER_FINISHED", stageLoaded);
				_win.stage.addChild(_swf);
				function stageLoaded(e:Event):void {
					
					_swf.removeEventListener("PRELOADER_FINISHED", stageLoaded);
					if (_debug) text_box.text = "stageLoaded";
					addButtons(optional ? optional["buttons"] : null);
					_win.stage.addEventListener(Event.RESIZE, onWindowResized);
					_swf.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
					owner.stage.dispatchEvent(new mcCustomEvent(mcCustomEvent.OBJECT_LOADED, null));
				}
			}
		}
		
		private function onDown(e:MouseEvent):void {
			
			btn_rotate.pressed = false;
		}
		
		private function onWindowResized(e:Event):void {
			
			btn_exit.moveTo(_win.stage.stageWidth - btn_exit.width / 2 - btn_offset, _win.stage.stageHeight - btn_exit.height / 2 - btn_offset);
		}
		
		private function addButtons(btn_names:Array = null):void {
			
			var offset_x:Number = 0;
			var offset_y:Number = 0;
			
			if (!btn_names || btn_names.indexOf("rotate") != -1) {
				
				btn_rotate = new btnPlay();
				offset_x = btn_rotate.width / 2 + btn_offset;
				offset_y = _win.stage.stageHeight - btn_rotate.height / 2 - btn_offset;
				btn_rotate.initParams({"x": offset_x, "y": offset_y, "scale": 1.7, "name": "btn_rotate"});
				btn_rotate.on_enabled = function() {
					
					_swf._autoRotate = true;
				}
				btn_rotate.on_disabled = function() {
					
					_swf._autoRotate = false;
				
				}
				_win.stage.addChild(btn_rotate);
				btn_rotate.pressed = true;
			}
			
			if (!btn_names || btn_names.indexOf("audio") != -1) {
				
				btn_audio = new btnAudio();
				offset_x = btn_rotate ? btn_rotate.x + btn_rotate.width / 2 + btn_audio.width / 2 + btn_offset : btn_audio.width / 2 + btn_offset;
				;
				offset_y = _win.stage.stageHeight - btn_audio.height / 2 - btn_offset;
				btn_audio.initParams({"x": offset_x, "y": offset_y, "scale": 1.7, "name": "btn_audio"})
				btn_audio.on_enabled = function() {
					
					_swf.playAudio = true;
				}
				btn_audio.on_disabled = function() {
					
					_swf.playAudio = false;
				}
				_win.stage.addChild(btn_audio);
				btn_audio.pressed = true;
			}
			
			if (!btn_names || btn_names.indexOf("zoom") != -1) {
				
				var zoom_btn:btnSlider = new btnSlider();
				var zoom_length:Number = 300;
				var zoom_min:Number = _swf._zoom_min;
				var zoom_max:Number = _swf._zoom_max;
				offset_x = zoom_btn.height / 2 + btn_offset;
				offset_y = _win.stage.stageHeight / 2 - zoom_length / 2;
				zoom_btn.initParams({"x": offset_x, "y": offset_y, "length": zoom_length, "name": "zoom_button", "horizontal": false, "custom_range": [zoom_min, zoom_max], "alpha": 0.8, "zom_speed":_swf._zoom_speed});
				zoom_btn.value = _swf.cameraDistance;
				zoom_btn.on_move = function() {
					
					//text_box.text = String(zoom_btn.value);
					_swf.cameraDistance = zoom_btn.value;
				}
				_swf.addEventListener("WHEEL_ZOOM_CHANGED", function() {
					
					//text_box.text = String(zoom_btn.value);
					zoom_btn.value = _swf.cameraDistance;
				})
				_win.stage.addChild(zoom_btn);
			}
			
			/*if (!btn_names || btn_names.indexOf("zoomin") != -1) {
			
			   var btn_zoomin:btnZoomIn = new btnZoomIn();
			   offset_x = btn_zoomin.width / 2 + btn_offset;
			   offset_y = _win.stage.stageHeight / 2 - 60;
			   btn_zoomin.initParams({"x": offset_x, "y": offset_y, "scale": 1.7, "name": "btn_zoomin"});
			   btn_zoomin.on_down = function() {
			
			   _swf.zoomIn(true);
			   }
			   btn_zoomin.on_up = function() {
			
			   _swf.zoomIn(false);
			   }
			   _win.stage.addChild(btn_zoomin);
			   }
			
			   if (!btn_names || btn_names.indexOf("zoomout") != -1) {
			
			   var btn_zoomout:btnZoomOut = new btnZoomOut();
			   offset_x = btn_zoomout.width / 2 + btn_offset;
			   offset_y = _win.stage.stageHeight / 2 + 60;
			   btn_zoomout.initParams({"x": offset_x, "y": offset_y, "scale": 1.7, "name": "btn_zoomout"});
			   btn_zoomout.on_down = function() {
			
			   _swf.zoomOut(true);
			   }
			   btn_zoomout.on_up = function() {
			
			   _swf.zoomOut(false);
			   }
			   _win.stage.addChild(btn_zoomout);
			   }*/
			
			if (!btn_names || btn_names.indexOf("exit") != -1) {
				
				btn_exit = new btnExit();
				offset_x = _win.stage.stageWidth - btn_exit.width / 2 - btn_offset;
				offset_y = _win.stage.stageHeight - btn_exit.height / 2 - btn_offset;
				btn_exit.initParams({"x": offset_x, "y": offset_y, "scale": 1.7, "name": "btn_exit"});
				btn_exit.on_up = function() {
					
					close();
				}
				_win.stage.addChild(btn_exit);
			}
		}
		
		/*private function fixSWFButtons():void {
		
		   //var console:AllertBox = new AllertBox(_win.stage, "init...", "Console");
		   //listStage(console, _win.stage);
		   //listStage(console, _swf);
		
		   // Set SWF buttons on TOP to be clickable
		   for (var i:int = 0; i < _swf.numChildren; i++) {
		
		   var btn:* = _swf.getChildAt(i);
		   if (btn is mcSwitchButton || mcSimpleButton) {
		
		   _swf.setChildIndex(btn, _swf.numChildren - 1);
		   }
		   }
		   }*/
		
		private function listStage(console:AllertBox, st:DisplayObjectContainer):void {
			
			for (var i:int = 0; i < st.numChildren; i++) console.append("children:" + st.getChildAt(i));
		}
		
		public function centerToScreen():void {
			
			_win.x = (Capabilities.screenResolutionX - _win.width) / 2;
			_win.y = (Capabilities.screenResolutionY - _win.height) / 2;
		}
		
		public function minimize() {
			
			_win.minimize();
		}
		
		public function restore() {
			
			_win.restore();
		}
		
		public function close() {
			
			if (!_win) return;
			_win.stage.frameRate = _old_fps;
			if (btn_audio) btn_audio.pressed = false;
			_win.close();
		}
		
		public function stagePointToScreen(p:Point):Point{
			
			if (!_win) return null;
			return _win.globalToScreen(p);
		}
		
		public function get bounds():Rectangle{
			
			if (!_win) return null;
			return _win.bounds;
		}
		
		public function set pos(location:Point):void{
			
			if (!_win) return;
			_win.x = location.x;
			_win.y = location.y;
		}
		
		public function get pos():Point{
			
			if (!_win) return null;
			return new Point(_win.x, _win.y);
		}
		
		public function set size(rect:Rect):void {
			
			if (!_win) return;
			_win.width = rect.width;
			_win.height = rect.height;
		}
		
		public function get size():Rect {
			
			if (!_win) return null;
			return new Rect(_win.width, _win.height);
		}
		
		public function getSWF():MovieClip{
			
			if (!_win) return null;
			return _swf;
		}
	}
}

/*
NativeWindowType.NORMAL – Typické okno. Běžná okna používají vzhled v plné velikosti a zobrazí se na hlavním panelu operačního systému Windows nebo Linux.
NativeWindowType.UTILITY – Paleta nástrojů. Okna nástrojů používají užší verzi systémového vzhledu a nezobrazují se na hlavním panelu operačního systému Windows.
NativeWindowType.LIGHTWEIGHT – zjednodušená okna nemohou mít systémový vzhled a nezobrazují se na hlavním panelu operačního systému Windows nebo Linux. 
Zjednodušená okna navíc nemají v operačním systém Windows systémovou nabídku (Alt-mezerník). Zjednodušená okna jsou vhodná pro oznámení a ovládací prvky, 
například rozbalovací seznamy, které otevřou krátkodobou obrazovou oblast. 
Při použití zjednodušeného typu musí mít vlastnost systemChrome nastavenu hodnotu NativeWindowSystemChrome.NONE.
*/