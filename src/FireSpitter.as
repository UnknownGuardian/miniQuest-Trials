package  
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class FireSpitter extends Enemy 
	{
		public var anim:Spritemap = new Spritemap(TILES, 16, 16);
		[Embed(source = "Assets/Graphics/SpriteSheets/tiles_fixed.png")]private static const TILES:Class;
		private var _fireballCounter:int = 110;
		private var ballXSpeed:int = 0;
		private var ballYSpeed:int = 0;
		public function FireSpitter(X:int,Y:int, frameNum:int) 
		{
			super(X, Y);
			anim.setFrame(frameNum);
			graphic = anim;
			
			var ballSpeed:int = 2;
			if (frameNum == 38)///right
				ballXSpeed = ballSpeed;
			else if (frameNum == 37) ///left
				ballXSpeed = -ballSpeed;
			else if (frameNum == 36)
				ballYSpeed = ballSpeed;
			else if (frameNum == 35)
				ballYSpeed = ballSpeed;
			
			setHitbox(16, 16);
			type = "FireSpitter";
			layer = 270			
		}
		
		public override function update():void
		{
			_fireballCounter++;
			if (_fireballCounter > 120)
			{
				_fireballCounter = 0;
				var fireball:Fireball = StaticCache.getFireball();
				fireball.startUse(x,y,ballXSpeed,ballYSpeed);
				world.add(fireball);
			}
		}
		
		public function reset():void
		{
			_fireballCounter = 120;
		}
		
	}

}