package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LadderGrid extends Entity 
	{
		[Embed(source = "Assets/Graphics/Items & Objects/ladder_metal.png")]private static const TILESHEET:Class;
		public var _tiles:Tilemap;
		public var _grid:Grid;
		public function LadderGrid() 
		{
			_tiles = new Tilemap(TILESHEET, 5120, 960, 16, 16);
			graphic = _tiles;
			layer = 270;
			
			_grid = new Grid(5120, 960, 16, 16, 0, 0);
			mask = _grid;
			
			type = 'Ladder';
			x = 1;
		}
		
	}

}