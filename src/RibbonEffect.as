package 
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * @author Chris Thodesen 2010
	 */
	public class RibbonEffect extends Entity
	{		
		public var img:Image;
		/**
		 * Constructor
		 */
		public function RibbonEffect(width:int,height:int,xPos:Number,yPos:Number,angle:int,colour:uint)
		{
			img = Image.createRect(width, height, colour);
			img.centerOrigin();
			graphic = img;
			x = xPos;
			y = yPos;
			img.angle = angle;
			img.blend = 'screen';
			
			layer = 271;
		}
		
		public function setAlpha(value:Number):void
		{
			img.alpha = value;
		}
		
		public function updateImage(xPos:Number, yPos:Number/*, angle:int*/):void
		{
			x = xPos;
			y = yPos;
			/*img.angle = angle;*/
		}
	}
	
}