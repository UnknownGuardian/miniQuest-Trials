package  
{
	import flash.display.BitmapData;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Data;
	import skyboy.serialization.JSON;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Level extends Entity
	{
		[Embed(source = "Assets/Level/mini_v48.json", mimeType = "application/octet-stream")]private static const TEST_MAP:Class;
		//[Embed(source = "ogmo/Master.oel", mimeType = "application/octet-stream")]private static const DEFAULT_MAP:Class;
		[Embed(source="Assets/Graphics/SpriteSheets/tiles_fixed.png")]private static const TILESHEET:Class;
		private var _levelData:Object;
		
		private var _mapWidth:int;
		private var _mapHeight:int;
		private var _tileWidth:int;
		private var _tileHeight:int;
		private var _levelObjectsArr:Array = [];
		
		
		
		
		
		private static const SOLIDS:Array = [3,4,5,6,9,10,12,13,14,15,16,17,20,21,22,23,24,26,31,32,33,34,35,36,37,38,39,43,44,45,46,47,48,49,50,51,52,53,54];
		private static const LADDERS:Array = [19, 20];// , 42, 43];
		private static const SPIKES:Array = [26, 28, 29, 30];
		private static const FIRESPIITER:Array = [36, 37, 38, 39];
		private var playerStartLoc:Point;
		public var _tiles:Tilemap;
		public var _grid:Grid;
		
		public static var currentLevel:String = "";
		private var _lastLevel:String = "";
		public function Level(current:String, last:String = "") 
		{
			_tiles = new Tilemap(TILESHEET, 40*16, 30*16, 16, 16);
			graphic = _tiles;
			layer = 400;
			
			_grid = new Grid(40*16, 30*16, 16, 16, 0, 0);
			mask = _grid;
			
			type = 'level';
			
			Level.currentLevel = current;
			_lastLevel = last;
		}
		
		public override function added():void
		{
			super.added();
			
			loadLevel();
			
			var bmd:BitmapData = new BitmapData(640, 480, true,0x00FFFFFF);
			_tiles.render(bmd, new Point(0, 0), new Point(FP.camera.x, FP.camera.y));
			bmd.applyFilter(bmd, new Rectangle(0, 0, 640, 480), new Point(0, 0), new DropShadowFilter(9,135,0,.35,0,0)); //multiply if possible
			graphic = new Image(bmd);
		}
		
		/*public static function reverseLookup(num:int):String // returns name of level
		{
			for (var s:String in LoadSettings.d.targetLocations) {
				if (LoadSettings.d.targetLocations[s] == num)
					return s;
			}
			trace("[Level] reverseLookup(", num, "); -> No Such Level");
			return "NO SUCH LEVEL";
		}*/
		
		public function levelDataLookup(name:String):Object
		{
			trace("[Level] levelDataLookup(", name, ");");
			for (var i:int = 0; i < _levelObjectsArr.length; i++)
			{
				if (_levelObjectsArr[i].name == name)
				{
					return _levelObjectsArr[i];
				}
			}
			
			
			
			var backupLookup:String = LoadSettings.d.door[name.substr("SubMenu_".length)].action;
			if (backupLookup != null)
			{
				trace("[Level] levelDataLookup(", name, "); -> Backup Caught:", backupLookup);
				return levelDataLookup(backupLookup); //recursion
			}
			
			trace("[Level] levelDataLookup(", name, "); -> No Such Level");
			return { };
		}
		
		public function levelNameLookup(index:int):String
		{
			return _levelObjectsArr[index].name;
		}
		public function menuBottomNameLookup(index:int):String
		{
			trace("[Level] menuBottomNameLookup(", index, ");");
			
			
			
			if (index == 1) return "Menu_New Game";
			else if (index == 2) return "Menu_Hall of Fame";
			else if (index == 3) return "Menu_Settings";
			else if (index == 4) return "Menu_More Games";
			else if (index == 5) return "Menu_Credits";
			
			
			
			trace("[Level] menuBottomNameLookup(", index, "); -> No Such Level");
			return "";
			
			
			
			
			var count:int = 0;
			for (var i:int = 0; i < _levelObjectsArr.length; i++)
			{
				if (_levelObjectsArr[i].name.indexOf("Menu_") == 0)
				{
					count++;
					if (count == index)
						return _levelObjectsArr[i].name;
				}
			}
			trace("[Level] menuBottomNameLookup(", index, "); -> No Such Level");
			return "";
		}
		
		public function loadLevel():void
		{
			loadJSON(TEST_MAP);
			trace("[Level] loadLevel( Level.currentlevel:" , Level.currentLevel, "_lastLevel:",_lastLevel,");");
			
			/* Temporary variables */
			var doorCount:int = 1;
			var keyCount:int = 1;
			playerStartLoc = null;
			
			
			if (Level.currentLevel == "Level Select")
			{
				//Log.Play();Log.ForceSend();
			}
			
			
			var layerData:Array = levelDataLookup(Level.currentLevel).data;
			for (var i:int = 0; i < layerData.length; i++)
			{
				if (layerData[i] == 0) { continue; } // do nothing
				
				
				if (LADDERS.indexOf(layerData[i]) != -1) //if is ladder
				{ 
					var lad:Ladder = new Ladder((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight, layerData[i]-1);
					world.add(lad);
					//MainMenu.ladder._tiles.setTile(i % _mapWidth, int(i / _mapWidth), layerData[i]-1);
					//MainMenu.ladder._grid.setTile(i % _mapWidth, int(i / _mapWidth), true);
					_tiles.setTile(i % _mapWidth, int(i / _mapWidth), layerData[i]-1);
					continue;
				}
				
				if (SPIKES.indexOf(layerData[i]) != -1)
				{
					var spi:Spike = new Spike((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight, layerData[i]-1);
					world.add(spi);
					_tiles.setTile(i % _mapWidth, int(i / _mapWidth), layerData[i]-1);
					continue;
				}
				
				if (layerData[i] == 2)//blue key
				{
					var blueKey:BlueKey = new BlueKey((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					world.add(blueKey);
					continue;
				}
				if (layerData[i] == 3)//yellow key
				{
					if(Level.currentLevel.indexOf("Menu_Settings") == 0)
					{
						var sKey:SettingsKey = new SettingsKey((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight, LoadSettings.d.key["settings " + keyCount].saved_name, keyCount % 2 == 1, LoadSettings.d.key["settings " + keyCount].display_name);
						world.add(sKey);
						keyCount++;
						continue;
					}
					
					var yellowKey:YellowKey = new YellowKey((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					world.add(yellowKey);
					continue;
				}
				
				if (layerData[i] == 8) //dirt
				{
					var dir:Dirt = new Dirt((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					world.add(dir);
					continue;
				}
				
				if (layerData[i] == 9) //red key
				{
					if(Level.currentLevel.indexOf("Menu_Settings") == 0)
					{
						var sKey2:SettingsKey = new SettingsKey((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight, LoadSettings.d.key["settings " + keyCount].saved_name, keyCount % 2 == 1, LoadSettings.d.key["settings " + keyCount].display_name);
						world.add(sKey2);
						keyCount++;
						continue;
					}
					
					var redKey:RedKey = new RedKey((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					world.add(redKey);
					continue;
				}
				
				if (layerData[i] == 10) //yellow lock
				{
					var yellowLock:YellowLock = new YellowLock((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					world.add(yellowLock);
					continue;
				}
				
				if (layerData[i] == 12) //door
				{
					var n:String = "Level Select";
					if (Level.currentLevel == "Main Menu")
					{
						n = menuBottomNameLookup(doorCount);
						/*if (doorCount < 5)
						{
							n = menuBottomNameLookup(doorCount);
						}
						else
						{
							n = "Level " + (doorCount-4);
						}*/
					}
					else if (Level.currentLevel == "Level Select")
					{
						if (doorCount == 2)
						{
							n = "Menu_Back";
						}
						else if (doorCount == 1)
						{
							n = "Menu_Tutorial";
						}
						else
						{
							n = "Level " + (doorCount-2);
						}
					}
					else if (Level.currentLevel == "Tutorial Level")
					{
						n = "Menu_New Game";
					}
					else if (Level.currentLevel.indexOf("Menu_") == 0)
					{
						n = "SubMenu_" + Level.currentLevel + " " + doorCount;
					}
					else if (Level.currentLevel == "SubMenu_Menu_Hall of Fame 2")
					{
						n = "Secret 2";
					}
					else if (Level.currentLevel == "Secret 2")
					{
						n = "Secret 3";
					}
					else if (Level.currentLevel == "Secret 3")
					{
						n = "Menu_Hall of Fame";
					}
					var door:Door = new Door((i % _mapWidth)*_tileWidth, int(i / _mapWidth)*_tileHeight, n); //set to door count if main menu or -1 if not
					world.add(door);
					
					if (Level.currentLevel == "Main Menu" || Level.currentLevel == "Level Select") //if on main menu
					{
						if (_lastLevel == n)
						{
							playerStartLoc = new Point((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
						}
					}
					
					doorCount++;
					_tiles.setTile(i % _mapWidth, int(i / _mapWidth), layerData[i]-1);
					continue;
				}
				
				if (layerData[i] == 13) //blue lock
				{
					var blueLock:BlueLock = new BlueLock((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					world.add(blueLock);
					continue;
				}
				if (layerData[i] == 14) //red lock
				{
					var redLock:RedLock = new RedLock((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					world.add(redLock);
					continue;
				}
				if (layerData[i] == 31)//chest
				{
					var che:Chest = new Chest((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					world.add(che);
					continue;
				}
				
				if (FIRESPIITER.indexOf(layerData[i]) != -1)
				{
					var fir:FireSpitter = new FireSpitter((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight, layerData[i] - 1);
					world.add(fir);
					_tiles.setTile(i % _mapWidth, int(i / _mapWidth), layerData[i]-1);
					continue;
				}
				
				if (layerData[i] == 40) //pacman
				{
					var pac:PacCrawler = new PacCrawler((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight, _tiles);
					world.add(pac);
					continue;
				}
				
				if (layerData[i] == 41) //player
				{
					if (Level.currentLevel == "Level Select" && _lastLevel != "Main Menu") continue;
					
					
					playerStartLoc = new Point((i % _mapWidth) * _tileWidth, int(i / _mapWidth) * _tileHeight);
					continue;
				}
				
				
				_tiles.setTile(i % _mapWidth, int(i / _mapWidth), layerData[i]-1);
				_grid.setTile(i % _mapWidth, int(i / _mapWidth), SOLIDS.indexOf(layerData[i]-1) != -1);
			}
			//trace(_tiles.saveToString(",", "|\n"), "\n\n\n", layerData.length);
			
			if (playerStartLoc == null)
			{
				trace("[Level] loadLevel(", Level.currentLevel, "); -> No player starting location defined");
				playerStartLoc = new Point(640 / 2, 10);
			}
		}
		
		
		
		
		private function loadJSON(json:Class):void 
		{
			var rawData:ByteArray = new json();
			var dataString:String = rawData.readUTFBytes(rawData.length);
			_levelData = JSON.decode(dataString);
			
			
			_mapWidth = _levelData.width;
			_mapHeight = _levelData.height;
			_tileWidth = _levelData.tilewidth;
			_tileHeight = _levelData.tileheight;
			_levelObjectsArr = _levelData.layers;
		}
		
		public function getPlayerLocation():Point
		{
			return playerStartLoc.clone();
		}
	}

}