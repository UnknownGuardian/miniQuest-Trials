package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Data;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelWorld extends World
	{
		public var backdrop:Background;
		public var level:Level;
		private var _player:Player;
		private var _hud:Hud;
		private var _to:String;
		
		private var bubble:Bubble;
		private var levelNum:int;
		
		public function LevelWorld(to:String, from:String) 
		{
			backdrop = StaticCache.background;
			add(backdrop);
			
			level = new Level(to, from);
			add(level); //load main menu by default.
			
			_hud = new Hud(to);
			add(_hud);
			
			_to = to;
			
			levelNum = int(_to.split(" ")[1]);
			if (levelNum % 3 == 0)
			{
				SettingsKey.loopMusic(SettingsKey.M_BLUE, true);
			}
			else if (levelNum % 3 == 1)
			{
				SettingsKey.loopMusic(SettingsKey.M_YELLOW, true);
			}
			else
			{
				SettingsKey.loopMusic(SettingsKey.M_RED, true);
			}
			
			if (levelNum == 3)
			{
				bubble = StaticCache.bubble;
				add(bubble);
			}
			if (levelNum == 4)
			{
				bubble = StaticCache.bubble;
				add(bubble);
			}
			if (levelNum == 7)
			{
				bubble = StaticCache.bubble;
				add(bubble);
			}
			
			
		}
		
		
		override public function begin():void 
		{
			_player = new Player(level.getPlayerLocation());
			add(_player);
			
			
			/*_messageBox = new MessageBox();
			add(_messageBox);
			
			_overlay = new Overlay();
			add(_overlay);
			
			_itemBar = new ItemBar();
			add(_itemBar);*/
		}
		
		override public function update():void
		{
			if (levelNum == 3)
			{
				if (_player.y > 250 && _player.x < 385)
				{
					bubble.setBubble("PAR");
					bubble.visible = true;
				}
				else
					bubble.clear();
				bubble.place(_player.x, _player.y);
			}
			if (levelNum == 4)
			{
				if (_player.y < 160 && _player.x < 460)
				{
					bubble.setBubble("ESC");
					bubble.visible = true;
				}
				else
					bubble.clear();
				bubble.place(_player.x, _player.y);
			}
			if (levelNum == 7)
			{
				if ((_player.y < 140 && _player.x < 420) || (_player.y > 280 && _player.x < 90))
				{
					bubble.setBubble("R");
					bubble.visible = true;
				}
				else
					bubble.clear();
				bubble.place(_player.x, _player.y);
			}
			super.update();
		}
		
		override public function end():void
		{
			removeAll();
		}
		
		public function getHud():Hud
		{
			return _hud;
		}
		
		public function preDeathNotification():void
		{
			_hud.moveOffScreen();
			var newTime:int = _hud.stopTime();
			var oldTime:int = Data.readInt(_to + "_Time", -1);
			var oldTimeChest:int = Data.readInt(_to + "_TimeChest", -1);
			
			var chests:Vector.<Chest> = new Vector.<Chest>();
			getType("Chest", chests);
			
			if (chests.length > 0 && !chests[0].collidable) //collected a chest
			{
				if (newTime < oldTimeChest || oldTimeChest == -1)
				{
					Data.writeInt(_to + "_TimeChest", newTime);
					//Data.save("miniQuestTrials");
				}
				if (oldTimeChest == -1)
				{
					GameStats.Chests++;
					//GameStats.save();
				}
			}
			else //didn't collect a chest
			{
				if (newTime < oldTime || oldTime == -1)
				{
					Data.writeInt(_to + "_Time", newTime);
					//Data.save("miniQuestTrials");
				}
				GlobalScore.postScore((int) (_to.split(" ")[1]), newTime/1000);
			}
			
			GameStats.Time += newTime;
			GameStats.save(); //auto calls save
			
		}
	}

}