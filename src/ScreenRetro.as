package  
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import net.flashpunk.FP;
	import net.flashpunk.Screen;
	
	/**
	 * ...
	 * @author YopSolo
	 */
	public class ScreenRetro extends Screen
	{
		// SCANLINES TYPES
		public static const HORIZONTAL:Array = [[1], [0]];
			
		public const VERTICAL:Array = [[1, 0]];
			
		public const DIAGONAL:Array = [[0, 0, 1],
									[0, 1, 0],									
									[1, 0, 0]];
									
		public const INV_DIAGONAL:Array = [[1, 0, 0],
										[0, 1, 0],									
										[0, 0, 1]];
										
		public const GRID:Array 	= 	[[1, 0],
									[0, 1]];
									
		public const DOUBLE_GRID:Array = [[1, 0, 0, 1],
										[0, 1, 1, 0],			 
										[0, 1, 1, 0],
										[1, 0, 0, 1]];
										
		public const RGB_FLAG:Array 	= 	[[0,1, 2],
										[0,1, 2],
										[0,1, 2]];
			// COLORS
		public const BLACK:Array		= [0x40000000, 0x00FFFFFF];
		public const RGB:Array			= [0x40CC0000, 0x4000CC00, 0x400000CC];
			
		public function ScreenRetro(pattern:Array, colors:Array) 
		{
			
			pattern.length == 0? pattern = HORIZONTAL:null;
			colors.length == 0? colors = BLACK:null;
			var scanlines:Sprite = new Sprite;
			var dat:BitmapData = build( pattern, colors);	 // classic black horizontal scanlines		
			
			scanlines.graphics.beginBitmapFill( dat );
			scanlines.graphics.drawRect(0, 0, FP.width, FP.height);			
			scanlines.graphics.endFill();			
			
			//scanlines.blendMode = BlendMode.OVERLAY;			
			
			FP.engine.addChild( scanlines );
			
		}
		
		public function build(pattern:Array, colors:Array):BitmapData 
		{
			var bitmapW:int = pattern[0].length;			
			var bitmapH:int = pattern.length;			
			var bmd:BitmapData = new BitmapData(bitmapW, bitmapH, true, 0x0);			
			for (var yy:int = 0; yy < bitmapH; yy++) {				
				for (var xx:int = 0; xx < bitmapW; xx++) {
					var color:int = colors[pattern[yy][xx]];
					bmd.setPixel32(xx, yy, color);
				}
			}
			return bmd;
		}
		
	}
	
}