package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class BlueLock extends Lock 
	{
		[Embed(source = "Assets/Graphics/Items & Objects/e_blue_lock.png")]private const LOCK:Class;
		public function BlueLock(X:int, Y:int ) 
		{
			graphic = new Image(LOCK);
			super(X, Y);
			
			type = "BlueLock";
		}
		
	}

}