package orien.tools {
	
	import flash.display.MovieClip;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import imost.InitAfterValidate;
	import orien.tools.mcEffect;
	
	public class mcColorClip extends MovieClip {
		
		//instance parameters reserved
		public var color_tint:uint;

		public function mcColorClip(init_force:Boolean = false) {
			
			
			new InitAfterValidate(this, "enabled", init); //wait for variable is accesible
		}
		
		private function init():void {
			
			tintSkin(); //tint skin if colorize is defined and not black
		}

		public function tintSkin():void {
		
			//colorize background
			if (color_tint != 0x000000) mcEffect.tint(this, color_tint, 0.8);
			
			var myBevel:BevelFilter = new BevelFilter();
			myBevel.type = BitmapFilterType.INNER;
			myBevel.distance = 3;
			myBevel.highlightColor = 0xFFFFFF;
			myBevel.shadowColor = 0x000000;
			myBevel.blurX = 5;
			myBevel.blurY = 5;
			this.filters = [myBevel];
		}
	}
}