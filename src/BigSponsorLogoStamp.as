package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class BigSponsorLogoStamp extends Entity
	{
		[Embed(source = "Assets/Graphics/Menus/sponsor_logo_big.png")]private const LOGO:Class;
		private var _image:Image;
		public function BigSponsorLogoStamp(X:int = 0, Y:int = 0)
		{
			super(X, Y);
			_image = new Image(LOGO);
			graphic = _image;
		}
		
		public function place(X:int = 0, Y:int = 0):void
		{
			x = X - 130;
			y = Y - 36;
		}
		
	}

}