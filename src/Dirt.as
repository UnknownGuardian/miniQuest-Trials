package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Dirt extends Entity
	{
		public static var DISTANCE_ABOVE_FOR_COLLISION:Number = 0;
		public var hasBeenTouched:Boolean = false;
		public var anim:Spritemap = new Spritemap(TILES, 16, 16);
		[Embed(source = "Assets/Graphics/SpriteSheets/block_SS.png")]private static const TILES:Class;
		public function Dirt(X:int,Y:int) 
		{
			super(X, Y);
			graphic = anim;
			type = "Dirt";
			setHitbox(16, 16, 0, 0);
			layer = 281;
			var animSpeed:int = LoadSettings.d.dirt.disolveSpeed;
			anim.add("Die", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27], animSpeed, false);
			anim.callback = die;
		}
		
		private function die():void 
		{
			collidable = false;
			anim.setFrame(4, 5);
		}
		
		public function reset():void
		{
			collidable = true;
			hasBeenTouched = false;
			anim.setFrame();
		}
		
		public function deteriorate():void
		{
			if (hasBeenTouched)
				return;
			anim.play("Die");
			hasBeenTouched = true;
		}
		
	}

}