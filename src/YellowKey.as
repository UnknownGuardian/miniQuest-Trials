package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class YellowKey extends KeyItem 
	{
		[Embed(source = "Assets/Graphics/Items & Objects/a_yellow_key.png")]private const KEY:Class;
		public function YellowKey(X:int, Y:int) 
		{
			super(X, Y,"YellowLock",160+174,8);
			graphic = new Image(KEY);
			
			type = "YellowKey";
		}
	}

}