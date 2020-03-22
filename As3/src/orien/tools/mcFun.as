package orien.tools {
	
	/**
	 * ...
	 * @author René Bača (Orien) 2016
	 */
	public class mcFun {
		
		public static function parseFunc(func:*, scope:Object):Function {
			
			if (func is String && scope && scope.hasOwnProperty(func)) {
				func = scope[func] as Function;
			}
			return func is Function ? func : null;
		}
		
		public static function call(func:*, scope:Object, args:Array):* {
			
			func = parseFunc(func, scope);
			if (func) {
				switch (args.length) { //6 args for now
				case 0: return func.call(scope);
				case 1: return func.call(scope, args[0]);
				case 2: return func.call(scope, args[0], args[1]);
				case 3: return func.call(scope, args[0], args[1], args[2]);
				case 4: return func.call(scope, args[0], args[1], args[2], args[3]);
				case 5: return func.call(scope, args[0], args[1], args[2], args[3], args[4]);
				case 6: return func.call(scope, args[0], args[1], args[2], args[3], args[4], args[5]);
				// Continue...
				}
			}
			return null;
		}
		
		public static function apply(func:*, scope:Object, argArray:* = null):* {
			
			func = parseFunc(func, scope);
			return func != null ? func.apply(scope, argArray) : null;
		}
	}
}