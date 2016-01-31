package orien.tools {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author René Bača (Orien)
	 */
	public class mcCollect {
		static public var DEBUG:int = 0
		
		public function mcCollect() {
		
		}
		
		/**
		 * Collect objects from container by condition string
		 * @param	container
		 * @param	condition String >
		 * "all":	get all objects inside container
		 * "name":	get objects with given name
		 * "part":	get objects which contains given string
		 * "prefix":get objects with given prefix_
		 * "except":get all objects, except given name
		 * "data":	get all objects data by given parameter
		 * @param	str name or prefix
		 * @param	arg object parameter
		 * @return	Array of objects
		 */
		static public function byCondition(container:DisplayObjectContainer, condition:String, str:String = "", arg:String = ""):Array {
			
			var output:Array = new Array();
			for (var i:Number = 0; i <= container.numChildren - 1; i++) {
				
				var o:Object = container.getChildAt(i);
				if (!o.hasOwnProperty("name")) continue; //all objects with name can pass 
				switch (condition) {
				
				case "all": 
					output.push(o);
					break;
				case "name": 
					if (o.name == str) output.push(o);
					break;
				case "part": 
					if (o.name.indexOf(str) != -1) output.push(o);
					break;
				case "part_visible": //collect visible objects with name part
					if (o.name.indexOf(str) != -1 && o.visible) output.push(o);
					break;
				case "part_not_hidden": //collect visible objects with name part
					if (o.name.indexOf(str) != -1 && o.alpha > 0) output.push(o);
					break;
				case "part_names": //collect names from objects with name part
					if (o.name.indexOf(str) != -1) output.push(o.name);
					break;
				case "prefix": 
					if (o.name.split("_")[0] == str) output.push(o);
					break;
				case "except": 
					if (o.name.indexOf(str) == -1) output.push(o);
					break;
				case "data": //collect data from each object by given arg
					if (o.name.indexOf(str) != -1) output.push(o[arg]);
					break;
				}
			}
			return output;
		}
		
		/**
		 * Gather defined parameters from object
		 * @param	params Array of parameters like ["name", "pos"]
		 * @param	collection	Array of objects
		 * @return	Array of objects
		 */
		static public function paramsFromObject(collection:Array, params:Array):Array {
			
			var new_arr:Array = new Array();
			for each (var o:* in collection) {
				
				var new_obj:Object = new Object();
				for each (var p:String in params) {
					
					new_obj[p] = getValueByParam(o, p);
				}
				new_arr.push(new_obj);
			}
			return new_arr;
		}
		/**
		 * Detect special parameters and construct Objects
		 * @param	obj	Object, Movieclip, Sprite....
		 * @param	param String attribute
		 * @return	value
		 */
		static public function getValueByParam(obj:*, param:String):* {
			
			var value:*;
			switch (param) {
			
			case "pos": 
				value = new Point(obj.x, obj.y);
				break;
			default: 
				value = obj[param];
				break;
			}
			return value;
		}
		
		/**
		 * Get closest dropTarget from target_obj children by source_obj position and given Name part
		 * @param	target_obj DisplayObjectContainer where other object dropped
		 * @param	str part of name, which we are loking for
		 * @param	source_obj Object which is dropped on target_obj
		 * @return	DisplayObject or null
		 */
		static public function dropTargetUnderCardByNamePart(target_obj:DisplayObjectContainer, str:String, source_obj:Object, max_dist:Number = 400):DisplayObject {
			
			var objs:Array = byCondition(target_obj, "part", str);
			if (objs.length == 1) return objs[0] as DisplayObject;
			var objs_with_distance:mcArray = new mcArray(objs);
			var internal_point:Point = target_obj.globalToLocal(new Point(source_obj.x, source_obj.y));
			if (DEBUG == 1) trace("internal_point:" + internal_point)
			objs_with_distance.sortByDistance(internal_point);
			var closest_object:DisplayObject = objs_with_distance.getItemAt(0) as DisplayObject;
			return mcTran.twoPointsDistance(mcTran.pos(closest_object), internal_point) <= max_dist ? closest_object : null;
		}
		
		/**
		 * targetUnderPointByNamePart will be deleted
		 * When object A is dropped on object B. Search in obj B for children with given name at drop pos
		 * @param	obj object where ve want to search
		 * @param	str part of name we are loking for
		 * @param	p1 positinon mouseX, mouseY
		 * @return	display object or null
		 */
		/*static public function targetUnderPointByNamePart(obj:DisplayObjectContainer, str:String, p1:Point):DisplayObject {
		
		   if (DEBUG == 1) trace("obj:"+obj+" str:"+str+" p1:"+p1);
		   var targets:Array = obj.getObjectsUnderPoint(p1);
		   if (DEBUG == 1) trace("targets:"+targets);
		   for each (var t:DisplayObject in targets) {
		   if (DEBUG == 1) trace("display object:"+t);
		   //if object with given name found stop here!
		   if (t.name.indexOf(str) != -1) return t as DisplayObject;
		   //get all parents of each object
		   var parents:Array = getParentsChain(t);
		   //search in parents
		   for each (var p:DisplayObject in parents) {
		   if (DEBUG == 1) trace("parent object:"+p);
		   //if object with given name found stop here!
		   if (p.name.indexOf(str) != -1) return p as DisplayObject;
		   }
		   }
		   return null;
		   }*/
		/**
		 * Get all parents of an object leaf > branches > tree
		 * @param	o children object
		 * @return	array of parents
		 */
		static public function getParentsChain(o:DisplayObject):Array {
			
			var parents:Array = new Array(), p:DisplayObject = o;
			while (p != null) {
				parents.push(p);
				p = p.parent;
			}
			return parents;
		}
	}

}