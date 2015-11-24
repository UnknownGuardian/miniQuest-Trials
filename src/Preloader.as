package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Preloader extends MovieClip 
	{
		[Embed(source = "Assets/Graphics/Menus/sponsor_logo_big.png")]private const SPONSOR:Class;
		[Embed(source = "Assets/Graphics/Backgrounds/tiled.png")]private const TILED:Class;
		[Embed(source = "Assets/Graphics/Menus/mQLogo_big+shadow.png")]private const LOGO:Class;
		[Embed(source="Assets/Graphics/HUD/top_bar_title.png")]private const HUD:Class;
		private var _container:Sprite;
		private var _mask:Sprite;
		private var _text:TextField;
		private var _sponsor:Sprite;
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			// TODO show loader
			
			addChild(new TILED());
			
			var logo:Bitmap = new LOGO();
			logo.x = 320 - 242;
			logo.y = 120 - 70;
			addChild(logo);
			
			_container = new Sprite();
			_container.addChild(new HUD());
			_container.x = 320 - _container.width/2;
			_container.y = 240;
			addChild(_container);
			
			_mask = new Sprite();
			_mask.graphics.beginFill(0xFFFFFF, 1);
			_mask.graphics.drawRect(0, 0, 640 * .1, 480);
			_mask.graphics.endFill();
			_container.mask = _mask;
			
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat("Arial", 12, 0xDDDDDD, true, null, null, null, null, 'center');
			_text.width = _container.width;
			_text.x = _container.x;
			_text.y = _container.y + _container.height + 5;
			_text.text = "is loading - 0%";
			addChild(_text);
			
			_sponsor = new Sprite();
			_sponsor.addChild(new SPONSOR());
			_sponsor.addEventListener(MouseEvent.CLICK, visitSponsor);
			_sponsor.x = 320 - _sponsor.width / 2;
			_sponsor.y = _container.y + _container.height + 35;
			addChild(_sponsor);
		}
		
		private function visitSponsor(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.games1.com/?utm_medium=brandedgames_external&utm_campaign=miniquesttrials&utm_source=host&utm_content=preloader"));
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
			_text.text = "An error occured! " + e.text;
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			var percent:Number = e.bytesLoaded / e.bytesTotal;
			_mask.graphics.beginFill(0xFFFFFF, 1);
			_mask.graphics.drawRect(0, 0, 204 * percent + 640/2 - 102, 480);
			_mask.graphics.endFill();
			_container.mask = _mask;
			
			_text.text = "is loading - " + int(percent * 100) + "%";
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			removeChild(_sponsor);
			_sponsor.removeEventListener(MouseEvent.CLICK, visitSponsor);
			removeChild(_text);
			removeChild(_container);
			
			LoadSettings.load(startup);
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}