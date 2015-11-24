package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Water extends Entity 
	{
		private var _image:Image;
		public function Water(X:int,Y:int) 
		{
			super(X, Y);
			_image = new Image(new BitmapData(16, 16, true, 0x55000099));
			graphic = _image;
			setHitbox(16, 16, 0, 0);
			type = "Water";
			layer = 100;
		}
		
	}

}