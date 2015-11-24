package  
{
	import com.greensock.TweenLite;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Chest extends Entity 
	{
		private var _collectedX:int = 0;
		private var _collectedY:int = 0;
		private var _originalX:int = 0;
		private var _orignialY:int = 0;
		public var anim:Spritemap = new Spritemap(TILES, 16, 16);
		[Embed(source = "Assets/Graphics/SpriteSheets/treasure_SS.png")]private static const TILES:Class;
		public function Chest(X:int,Y:int,collectedX:int=411, collectedY:int=8) 
		{
			super(X, Y);
			
			_originalX = X;
			_orignialY = Y;
			_collectedX = collectedX;
			_collectedY = collectedY;
			
			
			graphic = anim;
			type = "Chest";
			setHitbox(16, 16, 0, 0);
			layer = 282;
			var frameRate:int = LoadSettings.d.chest.flashSpeed;
			anim.add("sparkle",[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], frameRate, true);
			anim.play("sparkle");
		}
		
		public function takeChest():void
		{
			collidable = false;
			//visible = false;
			//x = _collectedX;
			//y = _collectedY;
			TweenLite.to(anim, 1, { alpha:0, y: -40 } );
			SettingsKey.playSound(SettingsKey.S_CHEST_TAKEN);
		}
		
		public function reset():void
		{
			TweenLite.killTweensOf(anim, false);
			collidable = true;
			//visible = true;
			anim.alpha = 1;
			anim.y = 0;
			//x = _originalX;
			//y = _orignialY;
		}
		
	}

}