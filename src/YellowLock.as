package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class YellowLock extends Lock 
	{
		[Embed(source = "Assets/Graphics/Items & Objects/d_yellow_lock.png")]private const LOCK:Class;
		public function YellowLock(X:int, Y:int ) 
		{
			graphic = new Image(LOCK);
			super(X, Y);
			
			type = "YellowLock";
		}
		
	}

}