package  
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class CenterLogoSplash extends Entity 
	{
		[Embed(source = "Assets/Graphics/Menus/sponsor_logo_big.png")]private const LOGO:Class;
		private var logo:Sprite = new Sprite();
		private var _image:Image;
		public var isMovingOff:Boolean = false;
		public function CenterLogoSplash(X:int = 0, Y:int = 0)
		{
			super(X, Y);
			
			logo.addChild(new LOGO());
			logo.addEventListener(MouseEvent.CLICK, gotoSite);
			logo.buttonMode = true;
			logo.useHandCursor = true;
		}
		
		private function gotoSite(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.games1.com/?utm_medium=brandedgames_external&utm_campaign=miniquesttrials&utm_source=host&utm_content=menu_center"));
		}
		
		public function place(X:int = 0, Y:int = 0):void
		{
			x = X - 128;
			y = Y - 35;
		}
		
		public override function added():void
		{
			logo.x = 320 -128;
			logo.y = -logo.height - 10;
			logo.alpha = 0;
			TweenMax.to(logo, 1, {  y:190-35, alpha:1, overwrite:true } );
			FP.stage.addChild(logo);
		}
		
		public override function removed():void
		{
			super.removed();
		}
		
		
		public function moveOffScreen():void 
		{
			isMovingOff = true;
			TweenMax.to(logo, 0.48, {  y:-logo.height-10, alpha:0, overwrite:true, onComplete:function():void { FP.stage.removeChild(logo);} } );
		}
	}

}