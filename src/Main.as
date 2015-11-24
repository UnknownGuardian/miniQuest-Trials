package 
{
	import com.profusiongames.net.Kong;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import org.kaisergames.assets.GamesOneLogo;
	import org.kaisergames.engine.framework.Framework;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(640, 480, LoadSettings.d.framerate, true);
		}
		override public function init():void 
		{

			
			GlobalScore.init();
			
			trace("FlashPunk has started successfully!");
			Data.id = "profusion";
			Data.load("miniQuestTrials");
			
			
			
			Kong.connectToKong(stage, startSubmit);
			
			
			
			
			
			
			GameStats.loadStats();
			
			SettingsKey.init();
			
			Framework.initializeGame(this.stage);
			var logo : GamesOneLogo = new GamesOneLogo();
			logo.start(function() : void {
				Input.define("Any", Key.Z, Key.UP, Key.DOWN, Key.RIGHT, Key.LEFT, Key.W, Key.A, Key.S, Key.D);
				FP.world = new SplashScreen();
			});
		}
		
		private function startSubmit():void 
		{
			if(Kong.stats) Kong.stats.submit("Played", 1);
		}
	}

}