package org.kaisergames.engine.animation {
	/**
	 * @author Phimo
	 */
	public class Transition {
		public static const EASE_IN : int = 1;
		public static const EASE_OUT : int = 2;
		public static const EASE_INOUT : int = 3;
		public static const LINEAR : int = 1;
		public static const EXPO : int = 2;
		public static const CIRC : int = 3;
		public static const SINE : int = 4;
		public static const BOUNCE : int = 5;
		public static const QUAD : int = 6;
		public static const CUBIC : int = 7;
		public static const QUART : int = 8;
		public static const QUINT : int = 9;
		
		protected var type : int = 1;
		protected var ease : int = 1;
		
		public function Transition(type : int = Transition.LINEAR, ease : int = Transition.EASE_IN) {
			this.type = type;
			this.ease = ease;
		}
		
		public function setEase(ease : int) : void {
			this.ease = ease;
		}
		
		public function getEase() : int {
			return this.ease;
		}
		
		public function setType(type : int) : void {
			this.type = type;
		}
		
		public function getType() : int {
			return this.type;
		}
		
		public function getValue(phase : Number) : Number {
			if (phase > 1) phase = phase % 1;
			if (ease == EASE_OUT) phase = 1 - phase;
			if (ease == EASE_INOUT) {
				if (phase < 0.5) phase = 2 * phase;
				else phase = 2 * (1 - phase);
			}
			var ret : Number = 0;
			switch(this.type) {
				case LINEAR:
					ret = phase;
					break;
				case EXPO:
					ret = Math.pow(2, 8 * (phase -1));
					break;
				case CIRC:
					ret = 1 - Math.sin(Math.acos(phase));
					break;
				case SINE:
					ret = 1 - Math.cos(phase * Math.PI / 2);
					break;
				case BOUNCE:
					var i : Number = 0;
					var j : Number = 1;
					var found : Boolean = true;
					while(found) {
						if (phase >= (7 - 4 * i) / 11) {
							ret = j * j - Math.pow((11 - 6 * i - 11 * phase) / 4, 2);
							found = false;
						}
						i = i+j;
						j = j/2;
					}
					break;
				case QUAD:
					ret = Math.pow(phase, 2);
					break;
				case CUBIC:
					ret = Math.pow(phase, 3);
					break;
				case QUART:
					ret = Math.pow(phase, 4);
					break;
				case QUINT:
					ret = Math.pow(phase, 5);
					break;
				default:
					ret = phase;
					break;
			}
			if (ease == EASE_OUT) ret = 1 - ret;
			if (ease == EASE_INOUT) ret = ret / 2;
			return ret;
		}
	}
}
