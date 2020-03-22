package orien.tools {
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author René Bača 2017
	 */
	public class mcSound {
		
		public function mcSound() {
		
		}
		
		/**
		 * Get audio from library by name
		 * @param	snd_name library sound name
		 * @return	object Point(x, y)
		 */
		public static function getSoundFromLibraryByName(snd_name:String):Sound {
			
			var SoundClass:Class = getDefinitionByName(snd_name) as Class;
			ftrace("get sound:%", snd_name);
			return new SoundClass();
		}
	}
}