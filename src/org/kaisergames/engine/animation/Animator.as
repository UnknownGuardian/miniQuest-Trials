package org.kaisergames.engine.animation {
	import flash.events.EventDispatcher;
	import org.kaisergames.engine.events.AnimatorEvent;
	/**
	 * @author Phimo
	 */
	public class Animator extends EventDispatcher {
		protected var transition : Transition;
		protected var phase : Number = 0;
		protected var duration : int; // speed 1000 means 1 second for a loop through 2000 means 2s
		protected var repeats : int = -1;
		protected var sequences : Array = [];
		protected var event : Boolean = false;
		
		public function Animator(duration : Number = 1000, transition : Transition = null) {
			if (transition == null) transition = new Transition();
			this.transition = transition;
			this.duration = duration;
		}
		
		public function setRepeats(repeats : int) : void {
			this.repeats = repeats;
		}
		
		public function replay() : void {
			this.event = false;
			this.phase = 0.0;
		}
		
		public function setDuration(duration : int) : void {
			this.duration = duration;
		}
		
		public function setTransition(transition : Transition) : void {
			this.transition = transition;
		}
		
		public function getTransition() : Transition {
			return this.transition;
		}
		
		public function addSequence(sequence : ISequence) : void {
			this.sequences.push(sequence);
		}
		
		public function removeSequence(sequence : ISequence) : Boolean {
			var index : int = this.sequences.indexOf(sequence);
			if (index >= 0) {
				this.sequences.splice(index, 1);
				return true;
			}
			return false;
		}
		
		public function update() : void {
			if (this.repeats == -1 || (this.phase < this.repeats)) {
				this.phase += 30 / this.duration;
				if (this.phase > this.repeats && this.repeats != -1) {
					this.phase = this.repeats;
					if (event == false) {
						this.dispatchEvent(new AnimatorEvent(AnimatorEvent.COMPLETE));
						event = true;
					}
				}
				for (var i : int = 0; i < this.sequences.length; i++) {
					(this.sequences[i] as ISequence).parse(this.phase, this.transition);
				}
			}
		}
		
		public function getType() : String {
			return "Animator";
		}
	}
}
