package orien.tools {
	
	/**
	 * ...
	 * @author Orien
	 */
	public class mcArange {
		
		public function mcArange() {
		
		}
		
		public static function animateCardsRandomUnique(cards:Array):void {
			
			var total_frames:int = cards[0].totalFrames;
			var card_frames:mcArray = new mcArray(mcMath.numbersInRange(1, total_frames));
			card_frames.shuffle();
			for each (var c in cards) c.gotoAndStop(card_frames.pop());
		}
		
		public static function align(cards:Array, offset:Number, way:String = "left"):void {//not tested
			
			for each (var c in cards) {
				
				switch (way) {
				
				case "left": 
					//cards.x -= cage.getBounds(this).left - left_margin;
					break;
				case "right": 
					//cards.x += cage.getBounds(this).right + left_margin;
					break;
				}
				
			}
		}
	
	}
}