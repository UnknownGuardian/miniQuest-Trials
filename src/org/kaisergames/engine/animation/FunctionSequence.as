package org.kaisergames.engine.animation {
	/**
	 * @author Phimo
	 */
	public class FunctionSequence extends BaseSequence {
		protected var func : Function;
		protected var args : Array;
		protected var thisContext : *;
		
		public function FunctionSequence(from : Number, to : Number, thisContext : *, func : Function, args : Array, transition : Transition = null) {
			super(from, to, transition);
			this.thisContext = thisContext;
			this.func = func;
			this.args = args;
		}

		public function getArgs() : Array {
			return this.args;
		}
		
		public function getFunction() : Function {
			return this.func;
		}
		
		public function getThisContext() : * {
			return this.thisContext;
		}
		
		public function setFunction(func : Function) : void {
			this.func = func;
		}
		
		public function setArgs(args : Array) : void {
			this.args = args;
		}
		
		public function setThisContext(context : *) : void {
			this.thisContext = context;
		}
		
		override public function parse(phase : Number, transition : Transition) : void {
			var trans : Transition = this.transition;
			if (trans == null) trans = transition;
			if (trans != null) {
				var value : Number = from + ((to - from) * trans.getValue(phase));
				var args2 : Array = [];
				for (var i : int = 0; i < this.args.length; i++) {
					if (args[i] == VALUE) args2[i] = value;
					else if (args[i] == VALUE_INT) args2[i] = Math.floor(value) as int;
					else if (args[i] == VALUE_INT_ROUND) args2[i] = Math.round(value) as int;
					else if (args[i] == VALUE_INT_CEIL) args2[i] = Math.ceil(value) as int;
					else args2[i] = args[i];
				}
				this.func.apply(this.thisContext, args2);
			}
		}
	}
}