package  
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Skull extends Enemy 
	{
		/*[Embed(source = "Assets/Graphics/Enemies/skull.png")]private const SKULL:Class;*/
		private var _image:Image;
		
		private var _isPounding:Boolean = false;
		private var _goLeft:Boolean = true;
		private var _goUp:Boolean = true;
		private var heightCeil:Number = 0;
		private var heightFloor:Number = 0;
		
		private var _player:Player;
		
		public function Skull(X:int, Y:int ) 
		{
			super(X, Y);
			/*_image = new Image(SKULL);*/
			_image = new Image(new BitmapData(32,32,false,0x00FF00));
			graphic = _image;
			layer = 300;
			
			type = "Skull";
			setHitbox(32, 32);
			
			heightCeil = y - 5;
			heightFloor = y + 5;
			_health = 120;
		}
		
		public override function update():void
		{
			if (_player == null) _player = (world as MainMenu).getPlayer();
			
			
			if (_isPounding)
			{
				if (_goUp && Math.random() > 0.2)
				{
					y--;
					if (y < heightCeil)
					{
						_goUp = !_goUp;
						_isPounding = false;
					}
				}
				else if (!_goUp)
				{
					y+=2;
				}
				if (collide("level", x, y))
				{
					if (collide("player", x, y))
					{
						_player.respawn();
					}
					_goUp = true;
				}
			}
			else
			{
				if (_goLeft)
				{
					x--;
				}
				else
				{
					x++;
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
				
				var dist:Number = distanceFrom(_player);
				if (dist < 80)
				{
					_goLeft = _player.x < x;
					if (Math.abs(_player.x - x) < 6)
					{
						_isPounding = true;
						_goUp = false;
						return;
					}
				}
				if (collide("level", x, y))
				{
					_goLeft = !_goLeft;
				}
			}
		}
		
	}

}