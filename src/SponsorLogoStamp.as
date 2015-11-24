package  
{
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
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
	public class SponsorLogoStamp extends Entity
	{
		[Embed(source = "Assets/Graphics/Menus/sponsor_logo_small.png")]private const LOGO:Class;
		private var logo:Sprite = new Sprite();
		private var _image:Image;
		public var isMovingOff:Boolean = false;
		public function SponsorLogoStamp(X:int = 0, Y:int = 0)
		{
			super(X, Y);
			//_image = new Image(LOGO);
			//graphic = _image;
			
			logo.addChild(new LOGO());
			logo.addEventListener(MouseEvent.CLICK, gotoSite);
			logo.buttonMode = true;
			logo.useHandCursor = true;
			trace("Sponsor->Created");
		}
		
		private function gotoSite(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.games1.com/?utm_medium=brandedgames_external&utm_campaign=miniquesttrials&utm_source=host&utm_content=menu_corner"));
		}
		
		public function place(X:int = 0, Y:int = 0):void
		{
			trace("Sponsor->Placed");
			x = X - 128;
			y = Y - 35;
		}
		
		public override function added():void
		{
			trace("Sponsor->Added");
			logo.x = 640 -124;
			logo.y = 480;
			TweenMax.to(logo, 1, {  y:455-35, overwrite:true } );
			FP.stage.addChild(logo);
		}
		
		public override function removed():void
		{
			trace("Sponsor->Removed");
			super.removed();
		}
		
		
		public function moveOffScreen():void 
		{
			trace("Sponsor->Moving off screen");
			isMovingOff = true;
			TweenMax.to(logo, 0.48, {  y:480, overwrite:true, onComplete:function():void { FP.stage.removeChild(logo);} } );
		}
		
	}

}