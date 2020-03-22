
package orien.tools {
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcDate {
		
		public function mcDate() {
		
		}
		
		static public function engDate():String {
			
			var date:Object = parseDate();
			return date.month + "/" + date.day + "/" + date.year; // Month/Day/Year == mm:03 dd:01 yyyy:2014
		}
		
		static public function czDate():String {
			
			var date:Object = parseDate();
			return date.day + "/" + date.month + "/" + date.year; // Day/Month/Year == dd:01 mm:03 yyyy:2014
		}
		
		static private function parseDate():Object {
			
			var date:Date = new Date();  //Wed Dec 18 10:18:45 GMT+0100 2013
			var year:String = String(date.getFullYear());
			var month:String = String(date.getMonth() + 1);
			if (month.length == 1) {
				month = "0" + month;
			}
			var day:String = String(date.getDate());
			if (day.length == 1) {
				day = "0" + day;
			}
			return {"day": day, "month": month, "year": year};
		}
	}
}