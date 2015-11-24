package  
{
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Fireball extends Entity 
	{
		//public var anim:Spritemap = new Spritemap(FIREBALL, 16, 16);
		//[Embed(source="Assets/Graphics/SpriteSheets/fireball2_SS.png")]private static const FIREBALL:Class;
		private var _xSpeed:int = 0;
		private var _ySpeed:int = 0;
		private var ribbonTrail:RibbonTrail;
		
		private var ribbonCounter:int = 0;
		private var ribbonCounterMax:int = 1;
		
		public var inUse:Boolean = false;
		private var deadCounter:int = 0;
		public function Fireball() 
		{
			super(-500, -500);
			//graphic = anim;
			//anim.x = -8;
			//anim.y = -8;
			//var frameRate:int = LoadSettings.d.fireball.rotateSpeed;
			//anim.add("rotate",[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], frameRate, true);
			
			
			setHitbox(10, 10, -3, -3);
			layer = 260;
			type = "Fireball";
			
			ribbonTrail = new RibbonTrail(this, [0xFFA642], true, SettingsKey.GRAPHICS?10:5)
		}
		
		override public function added():void
		{
			ribbonTrail.setLevel(world);
		}
		
		public function startUse(X:int,Y:int, xSpeed:int, ySpeed:int):void
		{
			x = X;
			y = Y;
			_xSpeed = xSpeed;
			_ySpeed = ySpeed;
			
			active = true;
			collidable = true;
			inUse = true;
			TweenMax.killTweensOf(ribbonTrail);
		}
		
		public override function update():void
		{
			ribbonCounter++;
			if (ribbonCounter > ribbonCounterMax)
			{
				ribbonCounter = 0;
				ribbonTrail.update();
			}
			
			
			if (!collidable)
			{
				///dead, don't move
				deadCounter++;
				if (deadCounter > 20)
				{
					active = false;
					deadCounter = 0;
					world.remove(this);
					inUse = false;
					ribbonTrail.allKill();
				}
				return;
			}
			x += _xSpeed;
			y += _ySpeed;
			
			if (x > 640 || x < 0 ||y > 480 || y < 0 || collide("level", x, y) || collide("Dirt",x,y)  || collide("BlueLock", x, y) || collide("RedLock", x, y) || collide("YellowLock",x,y) )
			{
				die();
			}
		}
		
		public function die():void
		{
			collidable = false;
		}
		
		public function reset():void
		{
			die();
			deadCounter = 999;
		}
		
	}

}