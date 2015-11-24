package org.kaisergames.engine.animation {
	/**
	 * @author Phimo
	 */
	public class MovieClipSequence {
		protected var name : String;
		protected var from : int;
		protected var to : int;
		protected var transition : Transition = new Transition();
		protected var duration : int;
		protected var phase : Number = 0.0;
		protected var repeats : int = -1;
		
		public function MovieClipSequence(name : String, from : int, to : int) : void {
			this.name = name;
			this.from = from;
			this.to = to;
			this.duration = (to-from)*100;
		}
		
		public function setTransition(transition : Transition) : void {
			this.transition = transition;
		}
		
		public function getTransition() : Transition {
			return this.transition;
		}
		
		public function setDuration(duration : int) : void {
			this.duration = duration;
		}
		
		public function getDuration() : int {
			return this.duration;
		}
		
		public function getPhase() : Number {
			return this.phase;
		}
		
		public function setRepeats(repeats : int) : void {
			this.repeats = repeats;
		}
		
		public function setPhase(phase : Number) : void {
			this.phase = phase;
		}
		
		public function getName() : String {
			return this.name;
		}
		
		public function replay() : void {
			this.phase = 0.0;
		}
		
		public function parse(deltaTime : int) : int {
			var frame : int = 0;
			if (this.repeats == -1 || (this.phase < this.repeats)) 
				this.phase += (deltaTime / this.duration);
			if (this.repeats != -1 && this.phase >= this.repeats) {
				this.phase = this.repeats;
			}
			if (this.repeats == -1 && this.phase > 1) {
				this.phase = this.phase % 1;
			}
			
			frame = this.from + this.transition.getValue(this.phase) * (this.to - this.from + 1);
			if (frame > to) frame = to;
			return frame;
		}
	}
}
