package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class BigGameLogoStamp extends Entity
	{
		[Embed(source = "Assets/Graphics/Menus/mQLogo_big+shadow.png")]private const LOGO:Class;
		private var _image:Image;
		public function BigGameLogoStamp(X:int = 0, Y:int = 0)
		{
			super(X, Y);
			_image = new Image(LOGO);
			graphic = _image;
		}
		
		public function place(X:int = 0, Y:int = 0):void
		{
			x = X - 242;
			y = Y - 70;
		}
		
	}

}