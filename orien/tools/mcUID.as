package orien.tools {
	
	/**
	 * ...
	 * @author Rene
	 */
	public class mcUID {
		
		public function mcUID() {
		
		}
		
		public static function create(prefix:String):String {
			
			return prefix + "_" + String(new Date().time);
		}
	
	}
}