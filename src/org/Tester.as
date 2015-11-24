package org {
	import org.kaisergames.engine.framework.Framework;
	import flash.display.Sprite;
	import org.kaisergames.assets.GamesOneLogo;
	/**
	 * @author p.mohrenstecher
	 */
	public class Tester extends Sprite {
		public function Tester() {
			Framework.initializeGame(this.stage);
			var logo : GamesOneLogo = new GamesOneLogo();
			logo.start(function() : void {
				trace("FINISH");
			});
		}
	}
}
