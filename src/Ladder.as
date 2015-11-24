package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Ladder extends Entity
	{
		public var anim:Spritemap = new Spritemap(TILES, 16, 16);
		[Embed(source = "Assets/Graphics/SpriteSheets/tiles_fixed.png")]private static const TILES:Class;
		public function Ladder(X:int,Y:int, frameNum:int) 
		{
			super(X, Y);
			anim.setFrame(frameNum);
			graphic = anim;
			
			setHitbox(16, 16, 0, 0);
			type = "Ladder";
			layer = 272;
		}
		
	}

}