package orien.tools {
	public class mcKeyboard {
		
		/* GLOBAL CONSTANTS */
		public static const ALPHABET_ENG_UP:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		public static const ALPHABET_CZ_LOW:String = "aábcčdďeéěfghchiíjklmnňoópqrřsštťuúůvwxyýzž"
		public static const ALPHABET_CZ_UP:String = "AÁBCČDĎEÉĚFGHCHIÍJKLMNŇOÓPQRŘSŠTŤUÚŮVWXYÝZŽ"
		public static const ALPHABET_CZ_LOWUP:String = "AaÁáBbCcČčDdĎďEeÉéĚěFfGgHhCHChchIiÍíJjKkLlMmNnŇňOoÓóPpQqRrŘřSsŠšTtŤťUuÚúŮůVvWwXxYyÝýZzŽž"
		public static const LANG_ENG:String = "eng";
		public static const LANG_CZ:String = "cze";
		public static const ALPHABET_GR:String = "αβγδεζηθικλμνξοπρσςτυφχψω"
		
		/* PRIVATE VARIABLES */
		protected var m:Array = [];
		
		/**
		 * used by CLASSES.TextpadWithDisplay.as
		 * @param	lang
		 */
		public function mcKeyboard(lang:String = "cze") {
			
			switch (lang) {
			
			case "eng": 
				initEngTable();
				break;
			case "cze": 
				initCzeTable();
				break;
			}

		}

		private function initCzeTable():void { //simplyfied
			m[48] = "é";
			m[49] = "+";
			m[50] = "ě";
			m[51] = "š";
			m[52] = "č";
			m[53] = "ř";
			m[54] = "ž";
			m[55] = "ý";
			m[56] = "á";
			m[57] = "í";
			m[65] = "a";
			m[66] = "b";
			m[67] = "c";
			m[68] = "d";
			m[69] = "e";
			m[70] = "f";
			m[71] = "g";
			m[72] = "h";
			m[73] = "i";
			m[74] = "j";
			m[75] = "k";
			m[76] = "l";
			m[77] = "m";
			m[78] = "n";
			m[79] = "o";
			m[80] = "p";
			m[81] = "q";
			m[82] = "r";
			m[83] = "s";
			m[84] = "t";
			m[85] = "u";
			m[86] = "v";
			m[87] = "w";
			m[88] = "x";
			m[89] = "y";
			m[90] = "z";
			m[186] = "ů";
			m[187] = "´";
			m[189] = "=";
			m[219] = "ú";
			m[221] = ")";
		}
		
		private function initEngTable():void {  //not tested
			m[65] = "A";
			m[66] = "B";
			m[67] = "C";
			m[68] = "D";
			m[69] = "E";
			m[70] = "F";
			m[71] = "G";
			m[72] = "H";
			m[73] = "I";
			m[74] = "J";
			m[75] = "K";
			m[76] = "L";
			m[77] = "M";
			m[78] = "N";
			m[79] = "O";
			m[80] = "P";
			m[81] = "Q";
			m[82] = "R";
			m[83] = "S";
			m[84] = "T";
			m[85] = "U";
			m[86] = "V";
			m[87] = "W";
			m[88] = "X";
			m[89] = "Y";
			m[90] = "Z";
			m[48] = "0";
			m[49] = "1";
			m[50] = "2";
			m[51] = "3";
			m[52] = "4";
			m[53] = "5";
			m[54] = "6";
			m[55] = "7";
			m[56] = "8";
			m[57] = "9";
			m[65] = "a";
			m[66] = "b";
			m[67] = "c";
			m[68] = "d";
			m[69] = "e";
			m[70] = "f";
			m[71] = "g";
			m[72] = "h";
			m[73] = "i";
			m[74] = "j";
			m[75] = "k";
			m[76] = "l";
			m[77] = "m";
			m[78] = "n";
			m[79] = "o";
			m[80] = "p";
			m[81] = "q";
			m[82] = "r";
			m[83] = "s";
			m[84] = "t";
			m[85] = "u";
			m[86] = "v";
			m[87] = "w";
			m[88] = "x";
			m[89] = "y";
			m[90] = "z";
			
			m[96] = "Numpad 0";
			m[97] = "Numpad 1";
			m[98] = "Numpad 2";
			m[99] = "Numpad 3";
			m[100] = "Numpad 4";
			m[101] = "Numpad 5";
			m[102] = "Numpad 6";
			m[103] = "Numpad 7";
			m[104] = "Numpad 8";
			m[105] = "Numpad 9";
			m[106] = "Multiply";
			m[107] = "Add";
			m[13] = "Enter";
			m[109] = "Subtract";
			m[110] = "Decimal";
			m[111] = "Divide";
			
			m[112] = "F1";
			m[113] = "F2";
			m[114] = "F3";
			m[115] = "F4";
			m[116] = "F5";
			m[117] = "F6";
			m[118] = "F7";
			m[119] = "F8";
			m[120] = "F9";
			m[122] = "F11";
			m[123] = "F12";
			m[124] = "F13";
			m[125] = "F14";
			m[126] = "F15";
			
			m[8] = "Backspace";
			m[9] = "Tab";
			m[13] = "Enter";
			m[16] = "Shift";
			m[17] = "Control";
			m[20] = "Caps Lock";
			m[27] = "Esc";
			m[32] = "Spacebar";
			m[33] = "Page Up";
			m[34] = "Page Down";
			m[35] = "End";
			m[36] = "Home";
			m[37] = "Left Arrow";
			m[38] = "Up Arrow";
			m[39] = "Right Arrow";
			m[40] = "Down Arrow";
			m[45] = "Insert";
			m[46] = "Delete";
			m[144] = "Num Lock";
			m[145] = "ScrLk";
			m[19] = "Pause/Break";
			m[186] = "; :";
			m[187] = "= +";
			m[189] = "- _";
			m[191] = "/ ?";
			m[192] = "` ~";
			m[219] = "[ {";
			m[220] = "\ |";
			m[221] = "] }";
			m[222] = "\" '";
			m[188] = ",";
			m[190] = ".";
			m[191] = "/";
		}
		
		public function keyName(keyCode:int):String {
			if (keyCode < 0 || keyCode > 255)
				return "UNKNOWN";
			var ret:String = m[keyCode];
			if (ret == null)
				ret = "UNKNOWN";
			return ret;
		}
		
		public function insertTone(key_name:String, to_lower:Boolean = true):String{
			
			var ret:String = key_name;
			switch (key_name.toLowerCase()){
				
				case "a":ret = "á"; break;
				case "e":ret = "é"; break;
				case "i":ret = "í"; break;
				case "o":ret = "ó"; break;
				case "u":ret = "ú"; break;
				case "y":ret = "ý"; break;
			}
			return ret;
		}
		
		public function insertHook(key_name:String, to_lower:Boolean = true):String{
			
			var ret:String = key_name;
			switch (key_name.toLowerCase()){
				
				case "c":ret = "č"; break;
				case "d":ret = "ď"; break;
				case "e":ret = "ě"; break;
				case "n":ret = "ň"; break;
				case "r":ret = "ř"; break;
				case "s":ret = "š"; break;
				case "t":ret = "ť"; break;
				case "z":ret = "ž"; break;
			}
			return ret;
		}
	}
}