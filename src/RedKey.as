package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class RedKey extends KeyItem
	{
		[Embed(source = "Assets/Graphics/Items & Objects/c_red_key.png")]private const KEY:Class;
		public function RedKey(X:int, Y:int) 
		{
			super(X, Y,"RedLock",212+174,8);
			graphic = new Image(KEY);
			
			type = "RedKey";
		}
		
	}

}