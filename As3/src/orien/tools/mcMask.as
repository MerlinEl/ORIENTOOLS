package orien.tools {
	import flash.display.BlendMode;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcMask {
		
		public function mcMask() {
			
		}
				
		static public function rectInverse(container:DisplayObjectContainer, rect:Rectangle, mask_name:String = "mc_mask"):void{
			
			var sh:Shape = new Shape();
			sh.name = mask_name
			sh.graphics.beginFill(0x000000);
			sh.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			sh.graphics.endFill();
			sh.blendMode = BlendMode.ERASE;
			container.blendMode = BlendMode.LAYER;
			container.addChild(sh);
		}
		
		static public function unmask(container:DisplayObjectContainer, mask_name:String = "mc_mask"):void{
			
			var sh:Shape = container.getChildByName(mask_name) as Shape;
			if (!sh) return; 
			container.removeChild(sh);
			container.blendMode = BlendMode.NORMAL;
		}
		
		static public function rect(container:DisplayObjectContainer, rect:Rectangle, mask_name:String = "mc_mask"):void{
			
			var sh:Shape = new Shape();
			sh.name = mask_name
			sh.graphics.beginFill(0x000000);
			sh.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			sh.graphics.endFill();
			container.mask = sh;
		}
	}
}