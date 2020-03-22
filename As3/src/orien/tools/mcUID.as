package orien.tools {
	
	/**
	 * ...
	 * @author René Bača 2016 (Orien)
	 */
	public class mcUID {
		
		public function mcUID() {
		
		}
		/**
		 * @example var id:String = mcUID.create();
		 * @return
		 */
		static public function create(prefix:String = ""):String {
			
			var time:Number = new Date().getTime();
			return prefix + ( "0000000" + time.toString( 16 ).toUpperCase() ).substr( -8 );
		}
	}
}