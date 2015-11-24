package org.kaisergames.engine.animation {
	/**
	 * @author Phimo
	 */
	public class PropertySequence extends BaseSequence {
		protected var property : String;
		protected var type : int;
		protected var object : *;
		
		public function PropertySequence(from : Number, to : Number, object : *, property : String, type : int = VALUE, transition : Transition = null) {
			super(from, to, transition);
			this.object = object;
			this.property = property;
			this.type = type;
		}

		public function getType() : int {
			return this.type;
		}
		
		public function getProperty() : String {
			return this.property;
		}
		
		public function getObject() : * {
			return this.object;
		}
		
		public function setType(type : int) : void {
			this.type = type;
		}
		
		public function setProperty(property : String) : void {
			this.property = property;
		}
		
		public function setObject(object : *) : void {
			this.object = object;
		}
		
		override public function parse(phase : Number, transition : Transition) : void {
			var trans : Transition = this.transition;
			if (trans == null) trans = transition;
			if (trans != null) {
				var value : Number = from + ((to - from) * trans.getValue(phase));
				if (this.type == VALUE) {
					this.object[this.property] = value;
				} else {
					var val : int = 0;
					if (this.type == VALUE_INT) val = Math.floor(value) as int;
					else if (this.type == VALUE_INT_ROUND) val = Math.round(value) as int;
					else if (this.type == VALUE_INT_CEIL) val = Math.ceil(value) as int;
					this.object[this.property] = val;
				}
			}
		}
	}
}
