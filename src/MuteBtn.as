package  
{
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class MuteBtn extends Sprite
	{
		[Embed(source = "Assets/Graphics/HUD/mute_button.png")]private var mute:Class;
		private var bit:Bitmap = new mute();
		public function MuteBtn() 
		{
			addChild(bit);
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			x = 640 - 204 - 38;
			y = -40;
			useHandCursor = true;
		}
		
		private function kill(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, kill);
			removeEventListener(MouseEvent.CLICK, toggleMute);
			removeEventListener(MouseEvent.ROLL_OVER, rOver);
			removeEventListener(MouseEvent.ROLL_OUT, rOut);
			
			y = -40;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			TweenMax.to(this, 1, {  y:0 } );
			addEventListener(MouseEvent.CLICK, toggleMute);
			addEventListener(MouseEvent.ROLL_OVER, rOver);
			addEventListener(MouseEvent.ROLL_OUT, rOut);
			addEventListener(Event.REMOVED_FROM_STAGE, kill);
		}
		
		private function rOver(e:MouseEvent):void 
		{
			filters = [new GlowFilter(0xFFFFFF, 1, 2, 2)];
		}
		
		private function rOut(e:MouseEvent):void 
		{
			filters = [];
		}
		
		public function moveOffScreen():void
		{
			TweenMax.to(StaticCache.mute, 0.48, {  y: -40, onComplete:function():void { FP.stage.removeChild(StaticCache.mute);} } );
		}
		
		private function toggleMute(e:MouseEvent):void 
		{
			SettingsKey.MUSIC = !SettingsKey.MUSIC;
			SettingsKey.SOUND = SettingsKey.MUSIC;
			
			correctDisplay();
		}
		
		public function correctDisplay():void
		{
			if (SettingsKey.MUSIC)
			{
				alpha = 1;
			}
			else
			{
				alpha = 0.5;
			}
		}
		
	}

}