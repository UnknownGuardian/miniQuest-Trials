package org.kaisergames.engine.animation {
	/**
	 * @author Phimo
	 */
	public interface ISequence {
		function parse(phase : Number, transition : Transition) : void;
	}
}
