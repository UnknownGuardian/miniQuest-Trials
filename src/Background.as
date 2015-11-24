package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Background extends Entity//Backdrop 
	{
		//[Embed(source = "Assets/Graphics/Backgrounds/bg_noise_0.png")]private const BG_1:Class;
		//[Embed(source = "Assets/Graphics/Backgrounds/bg_noise_1.png")]private const BG_2:Class;
		//[Embed(source = "Assets/Graphics/Backgrounds/dark_brick_wall.png")]private const BG_3:Class;
		[Embed(source = "Assets/Graphics/Backgrounds/tiled.png")]private const TILED:Class;
		public function Background() 
		{
			super();
			var i:Image = new Image(TILED);
			i.color = LoadSettings.d.background.tint_color;
			graphic = i;
			layer = 999999;
			//super(LoadSettings.d.background.tile == "bg_noise_0.png"?BG_1 : LoadSettings.d.background.tile == "bg_noise_1.png"?BG_2 :LoadSettings.d.background.tile == "dark_brick_wall.png"?BG_3 : null , true, true);
		}
		
		
		
	}

}