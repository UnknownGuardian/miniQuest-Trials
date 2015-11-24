package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class PacCrawler extends Entity
	{
		[Embed(source = "Assets/Graphics/Enemies/pac_man_2.png")]private const PAC:Class;
		[Embed(source = "Assets/Graphics/Enemies/pac_man_1.png")]private const PAC2:Class;
		private var _originalX:int = 0;
		private var _originalY:int = 0;
		private var facingRight:Boolean = false;
		private var floatingUp:Boolean = false;
		private var upCounter:int = 0;
		
		private var changeCounter:int = 0;
		
		private var speed:Number = 2;
		private var _grid:Tilemap;
		private var _image:Image;
		private var _image2:Image;
		public function PacCrawler(X:int,Y:int, grid:Tilemap) 
		{
			_image = new Image(PAC);
			_image2 = new Image(PAC2);
			graphic = _image;
			super(X, Y);
			
			_originalX = X;
			_originalY = Y;
			
			type = "PacCrawler";
			
			setHitbox(10, 10, -3, -1)
			
			_image.y = -2;
			_image2.y = -2;
			
			_grid = grid;
		}
		
		public function reset():void
		{
			x = _originalX;
			y = _originalY;
			facingRight = false;
			upCounter = 0;
			floatingUp = false;
			_image.flipped = false;
			_image2.flipped = false;
		}
		
		override public function update():void
		{
			if (facingRight)
			{
				x += speed;
				if (_grid.getTile((x) / 16+1, y / 16) != 0 || _grid.getTile((x) / 16+1, y / 16+1) == 0)
				{
					facingRight = false;
					_image.flipped = false;
					_image2.flipped = false;
					x -= speed;
				}
			}
			else
			{
				x -= speed;
				if (_grid.getTile((x) / 16, y / 16) != 0 || _grid.getTile((x) / 16, y / 16+1) == 0)
				{
					facingRight = true;
					_image.flipped = true;
					_image2.flipped = true;
					x += speed;
				}
			}
			
			
			upCounter++;
			if (upCounter % 3 == 0)
			{
				if (floatingUp)
					y--;
				else
					y++;
				if (upCounter > 6)
				{
					upCounter = 0;
					floatingUp = !floatingUp;
				}
			}
			
			changeCounter++;
			if (changeCounter > 5)
			{
				changeCounter = 0;
				if (graphic == _image) graphic = _image2;
				else graphic = _image;
			}
		}
	}

}