package  
{
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Sine;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenMax;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class SplashScreen extends World
	{
		[Embed(source = "Assets/Graphics/Profusion/intro_logo.png")]private static const LOGO:Class;
		[Embed(source = "Assets/Graphics/Profusion/intro_text.png")]private static const TEXT:Class;
		[Embed(source = "Assets/Graphics/Profusion/intro_bkg.jpg")]private static const BLUE_BACKGROUND:Class;
		
		private var _logo:Entity;
		private var _text:Entity;
		private var _bg:Entity;
		public function SplashScreen() 
		{			
			
			
			_logo = new Entity(640 / 2 - 200 / 2, 480 / 2 - 200 / 2 - 20, new Image(LOGO));
			add(_logo);
			
			_text = new Entity(640 / 2 - 392 / 2, 480 / 2 + 100, new Image(TEXT));
			add(_text);
			
			_bg = new Entity(0, 0, new Image(BLUE_BACKGROUND));
			_bg.layer = 9999;
			add(_bg);
		
			TweenPlugin.activate([BlurFilterPlugin]);
			
			TweenMax.from(_bg.graphic, 2, { alpha:0 , ease:Cubic.easeOut } );
			TweenMax.from(_logo.graphic, 2, { alpha:0 , ease:Cubic.easeOut } );
			TweenMax.from(_text.graphic, 2, { delay:0.1, alpha:0,  ease:Cubic.easeOut, onComplete:out } );
			
			SettingsKey.playSound(SettingsKey.S_SPLASH);
			
			FP.stage.addEventListener(MouseEvent.CLICK, gotoSite);
		}
		
		private function gotoSite(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://profusiongames.com/?gameref=miniQuestTrials"));
		}
		
		private function out():void 
		{
			TweenMax.to(_logo.graphic, 1, { delay:1.5,  alpha:0, ease:Sine.easeInOut } );
			TweenMax.to(_bg.graphic, 1, { delay:1.6,  alpha:0, ease:Sine.easeInOut, onComplete:kill  } );
			TweenMax.to(_text.graphic, 1, { delay:1.5, alpha:0, ease:Sine.easeInOut} );
		}
		
		private function kill():void 
		{
			FP.stage.removeEventListener(MouseEvent.CLICK, gotoSite);
			
			removeAll();
			//FP.world = new TutorialWorld();
			FP.world = new MainMenu("");
		}
		
	}

}