package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Boss extends Enemy
	{
		/*[Embed(source = "Assets/Graphics/Enemies/Boss.png")]private const BOSS:Class;*/
		private var _image:Image;
		
		private var spikeFireDelay:Number = 0;
		private var spikeFireDelayMax:Number = 90;
		private var _fireFromLeft:Boolean = true;
		
		private var _goLeft:Boolean = true;
		private var _goUp:Boolean = true;
		private var heightCeil:Number = 0;
		private var heightFloor:Number = 0;
		
		private var healthBar:Image;
		public function Boss(X:int, Y:int ) 
		{
			super(X, Y);
			/*_image = new Image(BOSS);*/
			_image = new Image(new BitmapData(78,42,false,0x00FF00));
			
			graphic = _image;
			layer = 300;
			
			heightCeil = y - 15;
			heightFloor = y + 15;
			type = "Boss";
			setHitbox(100, 71);
			
			_health = 200;
			
			healthBar = Image.createRect(200, 4, 0x00FF00, 0.8);
			healthBar.x = -50;
			healthBar.y = -8;
			healthBar.clipRect.width = 200;
			addGraphic(healthBar);
		}
		
		public override function update():void
		{
			spikeFireDelay++;
			if (spikeFireDelay > spikeFireDelayMax)
			{
				spikeFireDelay = 0;
				//var spike:BossSpike = new BossSpike(x + (_fireFromLeft?18:47) , y+30, 1);
				//world.add(spike);
				_fireFromLeft = !_fireFromLeft;
			}
			
			if (_goLeft)
			{
				x++;
			}
			else
			{
				x--;
			}
			
			if (_goUp && Math.random() > 0.5)
			{
				y--;
				if (y < heightCeil) _goUp = !_goUp;
			}
			else if (!_goUp && Math.random() > 0.5)
			{
				y++;
				if (y > heightFloor) _goUp = !_goUp;
			}
			
			if (collide("level", x, y))
			{
				_goLeft = !_goLeft;
			}
		}
		
		public override function takeDamage(num:Number):void
		{
			super.takeDamage(num);
			healthBar.scaleX = _health / 200;
			trace(_health);
			
			if (_health < 0)
			{
				(world as MainMenu).getMessageBox().showMessage("The Beast no longer creeps");
			}
		}
		
	}

}