package  
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Enemy extends Entity
	{
		protected var _health:Number = 100;
		public function Enemy(X:int=0,Y:int=0) 
		{
			super(X, Y);
		}
		
		public function takeDamage(num:Number):void
		{
			_health -= num;
			if (_health < 0)
			{
				if (world != null) world.remove(this);
			}
		}
		
	}

}