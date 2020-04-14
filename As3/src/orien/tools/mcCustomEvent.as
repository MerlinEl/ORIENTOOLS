package orien.tools {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author René Bača (Orien) 2017
	 */
	public class mcCustomEvent extends Event {
		
		static public const MOVED:String = "moved";
		static public const IS_ON_GRID:String = "isOnGrid";
		static public const AFTER_CHOICE:String = "afterChoice";
		static public const ON_ACCEPT:String = "onAccept";
		static public const ON_CLOSED:String = "onClosed";
		static public const FINISHED:String = "finished";
		static public const TASK_FINISHED:String = "taskFinished";
		static public const OBJECT_LOADED:String = "objectLoaded";
		static public const OBJECT_CREATED:String = "objectCreated";
		static public const ON_PROGRESS:String = "OnProgress";
		static public const UPON_ARRIVAL:String = "uponArrival";
		static public const AFTER_LEAVING:String = "afterLeaving";
		static public const COMPONENT_INITIALIZED:String = "componentInitialized";
		static public const CARD_CLICK:String = "cardClick";
		static public const CARD_DRAG:String = "cardDRAG";
		static public const CARD_DROP:String = "CardDropped";
		static public const HIT_TARGET:String = "hitTarget";
		static public const PARAMRTERS_SET:String = "paramrtersSet";
		static public const ON_SUMMONED:String = "onSummoned";
		static public const EFFECT_COMPLETE:String = "effectComplete";
		static public const ANIMATION_COMPLETE:String = "animationComplete";
		static public const MORPH_COMPLETE:String = "morphComplete";
		static public const ANIMATION_STOP:String = "animationStop";
		static public const ANIMATION_GOOD:String = "animationGood";
		static public const ANIMATION_BAD:String = "animationBad";
		static public const STAGE_LOADED:String = "stageLoaded";
		static public const TIME_EXPIRED:String = "timeExpired";
		static public const NOT_MOVED:String = "notMoved";
		static public const MDOWN:String = "mDown";
		static public const MUP:String = "mUp";
		
		// this is the object you want to pass through your event.
		public var result:Object;
		
		public function mcCustomEvent(type:String, result:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			//trace("mcCustomEvent: >Item:" + result + " is:" + type);
			super(type, bubbles, cancelable);
			this.result = result;
		}
		
		public override function clone():Event {
			
			return new mcCustomEvent(type, result, bubbles, cancelable);
		}
		
		public override function toString():String {
			
			return formatToString("FocusEvent", "type", "result", "bubbles", "cancelable", "eventPhase");
		}
	}

}