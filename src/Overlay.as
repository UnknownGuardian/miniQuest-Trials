package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Overlay extends Entity 
	{
		//[Embed(source = "Assets/Graphics/vignette_2X_DARK_NOFAIL.png")]private const OVER:Class;
		[Embed(source = "Assets/Graphics/vignette_darker_100.png")]private const OVER:Class;
		//[Embed(source = "Assets/Graphics/vignette_overlay.png")]private const OVER:Class;
		private var _image:Image;
		public function Overlay() 
		{
			_image = new Image(OVER);
			graphic = _image;
			layer = 8;
			
			//_image.scrollX = 0;
			//_image.scrollY = 0;
		}
		
		override public function added():void
		{
			if (SettingsKey.GRAPHICS)	visible = true;
			else visible = false;
		}
		
	}

}