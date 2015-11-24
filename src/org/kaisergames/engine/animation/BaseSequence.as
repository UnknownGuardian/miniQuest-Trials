package org.kaisergames.engine.animation {
	/**
	 * @author Phimo
	 */
	public class BaseSequence implements ISequence {
		protected var transition : Transition;
		protected var from : Number;
		protected var to : Number;
		public static const VALUE : int = 1;
		public static const VALUE_INT : int = 2;
		public static const VALUE_INT_ROUND : int = 3;
		public static const VALUE_INT_CEIL : int = 4;
		
		public function BaseSequence(from : Number, to : Number, transition : Transition) {
			this.from = from;
			this.to = to;
			this.transition = transition;
		}
		
		public function getTo() : Number {
			return this.to;
		}
		
		public function getFrom() : Number {
			return this.from;
		}
		
		public function getTransition() : Transition {
			return this.transition;
		}
		
		public function setFrom(from : Number) : void {
			this.from = from;
		}
		
		public function setTo(to : Number) : void {
			this.to = to;
		}
		
		public function setTransition(trans : Transition) : void {
			this.transition = trans;
		}
		

		public function parse(phase : Number, transition : Transition) : void {
		}
	}
}
