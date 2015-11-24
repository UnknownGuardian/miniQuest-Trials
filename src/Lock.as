package  
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Lock extends Entity 
	{
		
		public function Lock(X:int, Y:int ) 
		{
			super(X, Y);
			setHitbox(16,16);
		}
		
		public function hideLock():void
		{
			visible = false;
			collidable = false;
		}
		
		public function reset():void
		{
			visible = true;
			collidable = true;
		}
	}

}