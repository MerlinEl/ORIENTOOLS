package orien.tools {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.describeType;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2015
	 */
	public class mcObject {
		
		public function mcObject() {
		
		}
		
		static public function length(obj:Object):uint {
			
			var len:uint = 0;
			for (var s:* in obj) len++;
			return len;
		}
		
		static public function print(obj:Object, level:int = 0):void {
			
			for (var key:String in obj) {
				
				var val:Object = obj[key];
				var t:String = tabs(level);
				trace(t + "key:" + key + " value:" + val);
				if (!isEmpty(val)) {
					print(val, level + 1);
				}
			}
		}
		
		static public function isEmpty(obj:Object):Boolean {
			
			if (obj == null) return true;
			var is_empty:Boolean = true;
			for (var n:* in obj) {
				is_empty = false;
				break;
			}
			return is_empty;
		}
		
		static private function tabs(cnt:int):String {
			
			var tab:String = "";
			for (var i:int = 0; i < cnt; i++) tab += "\t";
			return tab;
		}
		
		static public function cloneTextFormat(tf:TextFormat):TextFormat {
			
			var new_tf:TextFormat = new TextFormat();
			var props:Array = ["font", "size", "color", "bold", "italic", "underline", "url", "target", "align", "leftMargin", "rightMargin", "indent", "leading"]
			for each (var p:String in props) {
				//trace("prop:" + p)
				new_tf[p] = tf[p];
			}
			return new_tf;
		}
		
		/**
		 * @example	mcObject.setParams(this, params);
		 * @param	target_obj		MovieClip
		 * @param	input_params	{"decimals":1, "color_fill":0x428FDD, "color_border":0xFFFFFF, "thickness":2}
		 * @param	target_param_prefix	"decimals" >> "_decimals"
		 */
		static public function setParams(target_obj:Object, input_params:Object, target_param_prefix:String = "_"):void {
			
			for (var key:String in input_params) {
				
				//ftrace("get param key:% val:%", key, input_params[key]);
				if (target_obj[target_param_prefix + key]) target_obj[target_param_prefix + key] = input_params[key];
			}
		}
		
		/**
		 * Get parameter if exists, else return default value
		 * @example	
			var params:Object = {"fill":false, "fill_color":0xFF99FF, "age":45};
			var out1:uint = mcObject.pick(params, "fill_color", 0xFFFFFF);
			var out2:Number = mcObject.pick(params, "age", 25);
			var out3:String = mcObject.pick(params, "greeting", "heloo");
			var out4:Boolean = mcObject.pick(params, "fill", true);
			ftrace("out1:% out2:% out3:% out4:%", out1, out2, out3, out4)
			out1:16751103 out2:45 out3:heloo out4:false
		 * @param	params
		 * @param	key
		 * @param	default_value
		 * @return
		 */
		static public function pick(params:Object, key:String, default_value:*):*{
			
			if (isEmpty(params)) params = { };
			return isNaN(params[key]) ? default_value : params[key];
		}
		
		/**
		 * This Clone is used but not finished. TODO
		 * @param	o
		 * @return
		 */
		static public function cloneDisplayObject(o:DisplayObject):* {
			
			if (o is MovieClip) {
				return cloneMovieClip(o as MovieClip);
				
			} else if (o is TextField) {
				return cloneTextField(o as TextField);
				
			} else if (o is Bitmap) {
				//return cloneBitmap(o as Bitmap);
				
			}
			return null;
		}
		
		static public  function cloneTextField(tf:TextField):TextField {
			
			var clone:TextField = new TextField();
			var description:XML = describeType(tf);
			for each (var item:XML in description.accessor) {
				if (item.@access != 'readonly') {
					try {
						clone[item.@name] = tf[item.@name];
					} catch (error:Error) {
						// N/A yet.
					}
				}
			}
			clone.defaultTextFormat = tf.getTextFormat();
			return clone;
		}
	
		static public  function cloneMovieClip(mc:MovieClip):MovieClip {
			
			var targetClass:Class = Object(mc).constructor;
			var clone:MovieClip = new targetClass();
			
			clone.transform = mc.transform;
			clone.filters = mc.filters;
			clone.cacheAsBitmap = mc.cacheAsBitmap;
			clone.opaqueBackground = mc.opaqueBackground;
			if (mc.scale9Grid) {
				var rect:Rectangle = mc.scale9Grid;
				clone.scale9Grid = rect;
			}
			return clone;
		}
		
		static public function toRectangle(o:Object):Rectangle{
			
			return new Rectangle(o.x, o.y, o.width, o.height);
		}
	}
}