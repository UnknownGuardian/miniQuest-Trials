package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Spike extends Entity 
	{
		public var anim:Spritemap = new Spritemap(TILES, 16, 16);
		[Embed(source = "Assets/Graphics/SpriteSheets/tiles_fixed.png")]private static const TILES:Class;
		public function Spike(X:int,Y:int, frameNum:int) 
		{
			super(X, Y);
			anim.setFrame(frameNum);
			graphic = anim;
			
			type = "Spike";
			
			setHitbox(16, 16, 0, 0);
			
			/*if(frameNum == 8)
				setHitbox(10, 8, -3, -8);
			else if(frameNum == 7)
				setHitbox(8, 10, 0, -3);
			else if(frameNum == 6)
				setHitbox(8, 10, -8, -3);
			else if(frameNum == 4)
				setHitbox(10, 8, -3, 0);*/
				
			reloadLoadSettings();
			layer = 280;
		}
		
		public function reloadLoadSettings():void
		{
			var obj:Object = LoadSettings.d.spike[LoadSettings.d.spike["tile" + anim.frame]];
			setHitbox(obj.width, obj.height, obj.x, obj.y);
		}
		
	}

}