package orien.tools {
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import orien.tools.mcTricolora;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcButtonFilters3 {
		
		private var _filter_glow:DropShadowFilter = new DropShadowFilter();
		private var _filter_border:GlowFilter = new GlowFilter();
		private var _filter_shadow:DropShadowFilter = new DropShadowFilter();
		
		private var _filters:Array = new Array();
	
		/**
		 * @usage
		 * private var all_colors:mcArray = new mcArray(RainbowColors.HAPPY_COLORS);
		 * var colors:mcTricolora = new mcTricolora(all_colors.getRandomItem() as uint);
		 * var bf:mcButtonFilters3 = new mcButtonFilters3({
			
				"glow": { "color":colors.glow, "blurX":sldGlowBlur.value, "blurY":sldGlowBlur.value, "alpha":sldGlowAlpha.value, "strength":sldGlowStrength.value},
				"border": { "color":colors.border, "blurX":sldBorderBlur.value, "blurY":sldBorderBlur.value, "alpha":sldBorderAlpha.value, "strength":sldBorderStrength.value},
				"shadow": { "color":0x000000, "blurX":sldShadowBlur.value, "blurY":sldShadowBlur.value, "alpha":sldShadowAlpha.value, "strength":sldShadowStrength.value}
			});
		 * @usage
			var bf:mcButtonFilters3 = new mcButtonFilters3( {
				"glow":{"color":colors.glow},
				"border":{"color":colors.border}
			});
		 * @param	params["glow"] == {"color":0xFFFFFF, "blurX":1, "blurY":1, "alpha":1, "strength":2 }
		 */
		public function mcButtonFilters3(params:Object = null):void {
			
			if (!params) params = { };
			//DEFAULT GLOW
			_filter_glow.color = 2759285;
			_filter_glow.blurX = 5;
			_filter_glow.blurY = 5;
			_filter_glow.alpha = 1;
			_filter_glow.strength = 6;
			_filter_glow.inner = true;
			_filter_glow.angle = 0;
			_filter_glow.distance = 0;
			
			//DEFAULT BORDER
			_filter_border.color = 2954410;	
			_filter_border.blurX = 21;
			_filter_border.blurY = 21;
			_filter_border.alpha = 0.4;
			_filter_border.strength = 2;
			_filter_border.inner = true;
			
			//DEFAULT SHADOW
			_filter_shadow.color = 0x000000;
			_filter_shadow.blurX = 10;
			_filter_shadow.blurY = 10;
			_filter_shadow.alpha = 0.2;
			_filter_shadow.strength = 2;
			_filter_shadow.angle = 45;
			_filter_shadow.distance = 5;
			
			//CUSTOM OVERRIDE
			if (params["glow"]) mcObject.setParams(_filter_glow, params["glow"], ""); 
			if (params["border"]) mcObject.setParams(_filter_border, params["border"], "");
			if (params["shadow"]) mcObject.setParams(_filter_shadow, params["shadow"], "");

			_filters = [_filter_border, _filter_glow, _filter_shadow];
		}
		
				
		/**
		 * Automatically used when trace
		 */
		public function toString() {
			
			var info:String = '{object mcButtonFilters3('
			var o:Object = toObject();
			for (var ftype:String in o){
				
				info += "\n\t\"" + ftype + "\":{";
				for (var key:String in o[ftype]){
					
					info += "\"" + key + "\":" + o[ftype][key] + ", ";	
				}
				info = info.substring(0, info.lastIndexOf(",")); //remove comma in last loop
				info += "}"
			}
			info += "\n)};"
			return info;
		}
		
		/**
		 * Collect input filters settings
		 * @return	filters settings Object
		 */
		public function toObject():Object {
			
			var obj:Object = { };
			obj.glow = { "color":_filter_glow.color, "blur":_filter_glow.blurX, "alpha":_filter_glow.alpha , "strength":_filter_glow.strength };
			obj.border = { "color":_filter_border.color, "blur":_filter_border.blurX, "alpha":_filter_border.alpha , "strength":_filter_border.strength };
			obj.shadow = { "color":_filter_shadow.color, "blur":_filter_shadow.blurX, "alpha":_filter_shadow.alpha , "strength":_filter_shadow.strength };
			return obj;
		}
		
		public function get filters():Array {
			return _filters;
		}
	}
}
