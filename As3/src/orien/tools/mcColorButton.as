package orien.tools {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import imost.InitAfterValidate;
	import orien.tools.mcEffect;
	import orien.tools.mcSimpleButton;
	
	public class mcColorButton extends mcSimpleButton{
		
		//instance parameters reserved
		public var color_inner:uint;
		public var color_outer:uint;
		public var color_text:uint;
		//instance components	
		private var _btn_text:TextField;
		private var _skin_inner:MovieClip;
		private var _skin_outer:MovieClip;
	
		public function mcColorButton() {
			
			super();
			new InitAfterValidate(this, "enabled", initParams2); //wait for variable is accesible
		}

		private function initParams2():void{
		
			tintSkin(); //tint skin if colorize is defined and not black
		}

		override public function afterDown():void{
			
			tintSkin();
		}
		
		override public function afterUp():void{
			
			tintSkin();
		}
		
		public function tintSkin():void {
			_btn_text 	= this.getChildByName ("btn_text") as TextField
			_skin_inner = this.getChildByName ("skin_inner") as MovieClip
			_skin_outer = this.getChildByName ("skin_outer") as MovieClip
			//ftrace("_btn_text:% _skin_inner:% _skin_outer:%", _btn_text, _skin_inner, _skin_outer)
			//ftrace("color_inner:% color_outer:% color_text:%", color_inner, color_outer, color_text)
			//if button not undefined and color is not undefiner and color is not black 
			if (_skin_inner && color_inner && color_inner != 0x000000) mcEffect.tint(_skin_inner, color_inner, 0.8);
			if (_skin_outer && color_outer && color_outer != 0x000000) mcEffect.tint(_skin_outer, color_outer, 0.8);
			if (_btn_text && color_text) _btn_text.textColor = color_text;
		}
	}
}