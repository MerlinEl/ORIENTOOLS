package orien.tools {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.text.TLFTextField;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcText {
		
		public function mcText() {
		
		}
		
		/**
		 * Copy textFormat from source in to target
		 * @param	source TextField or TLFTextField
		 * @param	target TextField or TLFTextField
		 */
		static public function copyTextFormat(source:*, target:*, text:Boolean = false):void{
			
			if (text) target.text = source.text;
			if (source is TextField){
			
				var tf:TextFormat = source.getTextFormat();
				target.setTextFormat(tf);

			} else if (source is TLFTextField){
				
				/*var dtf:TextFormat = source.defaultTextFormat;
				target.defaultTextFormat = dtf;*/
				var tlf:TextLayoutFormat = source.textFlow.hostFormat as TextLayoutFormat;
				target.textFlow.hostFormat = tlf;
				target.textFlow.flowComposer.updateAllControllers();
			}
		}
	}

}