package  
{
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TutorialTitle extends Entity
	{
		[Embed(source="Assets/Graphics/HUD/top_bar_tutorial.png")]private const HUD:Class;
		[Embed(source = "Assets/Fonts/OCRASTD.OTF", embedAsCFF = "false", fontFamily = 'Ocra')]private static const OCRA:Class;
		private var startX:int = 640;
		private var endX:int = 640 - 204;
		public var isMovingOff:Boolean = false;
		public function TutorialTitle(sx:int = -204, ex:int = 0) 
		{
			startX = x = sx;
			endX = ex;
			layer = -500;
			graphic = new Image(HUD);
		}
		
		public override function added():void
		{
			TweenMax.to(this, 1, {  x:endX } );
		}
		
		public function moveOffScreen():void 
		{
			isMovingOff = true;
			TweenMax.to(this, 1, {  x:startX } );
		}
	}

}