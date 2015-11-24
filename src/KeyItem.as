package  
{
	import com.greensock.TweenLite;
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class KeyItem extends Entity 
	{
		public var taken:Boolean = false;
		private var _lockClassName:String = "";
		private var _collectedX:int = 0;
		private var _collectedY:int = 0;
		private var _originalX:int = 0;
		private var _orignialY:int = 0;
		public function KeyItem(X:int, Y:int, lockClassName:String, collectedX:int, collectedY:int) 
		{
			super(X, Y);
			_lockClassName = lockClassName;
			_originalX = X;
			_orignialY = Y;
			_collectedX = collectedX;
			_collectedY = collectedY;
			setHitbox(16,16);
		}
		
		public function takeKey():void
		{
			if (taken) return;
			taken = true;
			collidable = false;
			//visible = false;
			//x = _collectedX;
			//y = _collectedY;
			//graphic.scrollX = 0;
			//graphic.scrollY = 0;
			TweenLite.to(graphic, 1, { alpha:0, y:-40 } );
			
			var locks:Array = [];
			world.getType(_lockClassName, locks);
			for (var i:int = 0; i < locks.length; i++)
			{
				locks[i].hideLock();
			}
			
			SettingsKey.playSound(SettingsKey.S_KEY_TAKEN);
		}
		
		public function reset():void
		{
			//x = _originalX;
			//y = _orignialY;
			//visible = true;
			TweenLite.killTweensOf(graphic, false);
			this["graphic"].alpha = 1;
			this["graphic"].y = 0;
			taken = false;
			collidable = true;
			//graphic.scrollX = 1;
			//graphic.scrollY = 1;
			
			var locks:Array = [];
			world.getType(_lockClassName, locks);
			for (var i:int = 0; i < locks.length; i++)
			{
				locks[i].reset();
			}
		}
	}

}