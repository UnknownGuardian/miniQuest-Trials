package org.kaisergames.engine.events {
	import flash.events.Event;
	/**
	 * @author Hamster
	 */
	public class AnimatorEvent extends Event {
		public static const COMPLETE : String = "AnimatorComplete";
		
		public function AnimatorEvent(type : String) {
			super(type);
		}
	}
}
