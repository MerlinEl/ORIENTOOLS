package orien.tools {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2018
	 */
	public class mcDispenser extends EventDispatcher {
		
		//public variables
		static public var debug:Boolean = false;
		public var breakWith:String = "exit";
		
		private var _progress:int;
		private var _objects:Array;
		private var _ename:String;
		private var _fname:String;
		private var _args:Array;
		private var _next_obj:*;
		private var _switch:String;
		
		/**
		 * @example
		 *
		 * 	A) For each children do same operation
		   var children:Array = mcCollect.byCondition(this, "prefix", "tile");
		   var mcd:mcDispenser = new mcDispenser(children, mcCustomEvent.ANIMATION_COMPLETE, "spin", ["fold", 10]);
		   mcd.breakWith = "exit";
		   mcd.addEventListener(mcCustomEvent.TASK_FINISHED, onFinished);
		
		   function onFinished(e:Event):void{
				mcd.removeEventListener(mcCustomEvent.TASK_FINISHED, onFinished);
				ftrace("all tile was fold");
		   }
		   
		   children must fire: dispatchEvent(new mcCustomEvent(mcCustomEvent.ANIMATION_COMPLETE, this));
		   or with error     : dispatchEvent(new mcCustomEvent(mcCustomEvent.ANIMATION_COMPLETE, "exit"));
		 *
		   B) For one object do different operations
			var angles:Array = generateExample();
			ftrace("initLesson > example:%", angles);
			var mcd:mcDispenser = new mcDispenser(
				[ACTOR], 
				mcCustomEvent.ANIMATION_COMPLETE, 
				"", 
				[
					{"fn":"setAngle", "args":[angles[1], "right", true]}, 
					{"fn":"setAngle", "args":[angles[0], "left", true]}
				]
			);
			mcd.addEventListener(mcCustomEvent.TASK_FINISHED, onFinished);
			function onFinished(e:mcCustomEvent):void{

			   mcd.removeEventListener(mcCustomEvent.TASK_FINISHED, onFinished);
			   ftrace("all angles was set");
			}
				   
		   ACTOR must fire: dispatchEvent(new mcCustomEvent(mcCustomEvent.ANIMATION_COMPLETE, this));
		   or with error  : dispatchEvent(new mcCustomEvent(mcCustomEvent.ANIMATION_COMPLETE, "exit"));
		 * @param	obj_arr
		 * @param	event_name
		 * @param	fn_name
		 * @param	args
		 */
		public function mcDispenser(obj_arr:Array, event_name:String, fn_name:String, args:Array):void {
			
			if (obj_arr.length == 1) {
				
				_progress = args.length;
				_switch = "single";
			} else {
				_progress = obj_arr.length;
				_switch = "multi";
			}
			if (debug) ftrace("mcDispenser\nOBJECTS	> %\nPARAMS	> event_name:% fn:% args:%", obj_arr, event_name, fn_name, args);
			_objects = obj_arr.concat(); //clone array
			_ename = event_name;
			_fname = fn_name
			_args = args;
			addEventListener(mcCustomEvent.TASK_FINISHED, addNextTask);
			addNextTask(null); //{"result":null}
		}
		
		private function addNextTask(e:Event = null):void {
			
			if (debug) ftrace("mcDispenser > addNextTask > type:% remains:%", _switch, _progress);
			if (e && e["result"] && e["result"] == breakWith) {
				
				finished("failed");
				return;
			}
			if (_next_obj) _next_obj.removeEventListener(_ename, addNextTask);
			if (_progress == 0) {
				
				finished("success");
				return;
			}
			_progress--;
			
			if (_switch == "single") {
				
				_next_obj = _objects[0];
				_next_obj.addEventListener(_ename, addNextTask);
				var cmd:Object = _args.shift();
				mcFun.call(cmd.fn as String, _next_obj, cmd.args as Array);
			} else {
				
				_next_obj = _objects.shift(); //get next object from begin
				if (debug) ftrace("add task:% cnt:% args:% len:%", _next_obj.name, _objects.length, _args, _args.length)
				_next_obj.addEventListener(_ename, addNextTask);
				mcFun.call(_fname, _next_obj, _args);
			}
		}
		
		private function finished(result:String):void {
			
			removeEventListener(mcCustomEvent.TASK_FINISHED, addNextTask);
			dispatchEvent(new mcCustomEvent(mcCustomEvent.TASK_FINISHED, result));
		}
	}
}