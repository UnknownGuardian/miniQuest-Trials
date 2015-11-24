package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class RedLock extends Lock 
	{
		[Embed(source = "Assets/Graphics/Items & Objects/f_red_lock.png")]private const LOCK:Class;
		public function RedLock(X:int, Y:int ) 
		{
			graphic = new Image(LOCK);
			super(X, Y);
			
			type = "RedLock";
		}
		
	}

}