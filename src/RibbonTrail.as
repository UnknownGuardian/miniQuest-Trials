package  
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.World;
	/**
	 * extension of graphics class that 
	 * simulates a trailing ribbon effect.
	 * @author Chris Thodesen
	 */
	public class RibbonTrail
	{
		private var ribbonColours:Array = [0xCCCCCC, 0xBBBBBB, 0xAAAAAA, 0x999999, 0x888888, 0x777777, 0x666666, 0x555555, 0x444444, 0x333333];
		private var alphaShading:Boolean = false;
		private var ribbonArray:Vector.<RibbonEffect> = new Vector.<RibbonEffect>();
		private var segmentWidth:int = 6;
		private var segmentHeight:int = 6;
		private var ribbonLength:int;
		
		private var lastX:int;
		private var lastY:int;
		
		private var player:Entity;
		private var level:World;
		
		private const OFFSET:Number = 0.5;
		
		/**
		* Constructor
		* @param	_entityRef: reference to the parent entity this is derived from.
		* @param	_levelReference: reference to the current world object, in this example it is a Wolrd1 object.
		* @param	colours: The array of colours to use, if alpha shading is going to be used
		* @param	_alphaShading: Boolean specifying whether or not to shade with alpha as opposed to assigning specific colours
		* @param 	length: if _alphaShading, how long the trail should be.
		*/
		public function RibbonTrail(entity:Entity, colours:Array = null, _alphaShading:Boolean = false, length:int = 10) 
		{
			player = entity;
			
			alphaShading = _alphaShading;
			
			if (colours) ribbonColours = colours;
			
			if (alphaShading)ribbonLength = length;
			else ribbonLength = ribbonColours.length;
			
			addRibbons();
			
		}
		
		public function setLevel(world:World):void
		{
			level = world;
			level.addList(ribbonArray);
		}
		public function update():void 
		{
			for (var i:int = 0; i < ribbonLength - 1; i++)
			{
				var nextImg:RibbonEffect = ribbonArray[i + 1];
				ribbonArray[i].updateImage(nextImg.x, nextImg.y/*, nextImg.img.angle*/);
			}
			
			//second RibbonEffect in the trail.
			//var lastImg:RibbonEffect = RibbonEffect(ribbonArray[ribbonLength - 2]);
			//lastX = lastImg.x+OFFSET; lastY = lastImg.y+OFFSET;
			
			//first RibbonEffect in the trail.
			var newImg:RibbonEffect = ribbonArray[ribbonLength - 1];
			
			//var _xVal = player.x - lastX; var _yVal = -1*(player.y - lastY);
			//var _angle = Math.atan2(_yVal, _xVal);
			//var deg = Math.round(_angle / Math.PI * 180)
			
			newImg.updateImage(player.x+8 + Math.random()*4-2, player.y+8 + Math.random()*4-2/*, deg*/);
		}
		
		public function allKill():void 
		{
			level.removeList(ribbonArray);
			for (var i:int = 0; i < ribbonLength; i++)
			{
				ribbonArray[i].x = -500;
				ribbonArray[i].y = -500;;
			}
		}
		
		private function addRibbons():void
		{
			for (var i:int = ribbonLength - 1; i >= 0; i--)
			{
				if (alphaShading)
				{
					var size:int = int(segmentWidth * (1 - i / ribbonLength))+1;
					var ribbonEffecta:RibbonEffect = new RibbonEffect(size,size, -500, -500, 0, ribbonColours[0]);//shade by alpha, just use first colour.
					ribbonEffecta.setAlpha((1 / ribbonLength) * (ribbonLength -i));
					ribbonArray.push(ribbonEffecta);
				}
				else
				{
					var ribbonEffectb:RibbonEffect = new RibbonEffect(segmentWidth-i, segmentHeight - i, player.x, player.y, 0, ribbonColours[i]);
					ribbonArray.push(ribbonEffectb);
				}
			}
		}
	}

}