package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class BlueKey extends KeyItem
	{
		[Embed(source = "Assets/Graphics/Items & Objects/b_blue_key.png")]private const KEY:Class;
		public function BlueKey(X:int, Y:int) 
		{
			super(X, Y, "BlueLock",187+174,8);
			graphic = new Image(KEY);
			
			type = "BlueKey";
		}		
	}

}