package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Data;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LevelSelectWorld extends World
	{
		public var level:Level;
		//public static var ladder:LadderGrid;
		private var _player:Player;
		public var backdrop:Background;
		private var _messageBox:MessageBox;
		private var _overlay:Overlay;
		private var _title:Title;
		private var _belowText:Text;
		private var _belowTextWrapper:Entity;
		private var _tips:Tips;
		private var _logo:GameLogoStamp;
		private var _sponsor:SponsorLogoStamp;
		
		public static var firstRun:Boolean = true;
		
		public function LevelSelectWorld(from:String)  
		{
			backdrop = StaticCache.background;
			add(backdrop);
			
			//ladder = new LadderGrid();
			//add(ladder);
			
			level = new Level("Level Select",from);
			
			add(level); //load main menu by default.
			
			
			SettingsKey.loopMusic(SettingsKey.M_MENU, true);
			if (firstRun)
			{
				var lvls:Array = [1];
				for (var i:int = 1; i < 31; i++)
				{
					if (Data.readInt("Level " + i + "_Time", -1) != -1)
					{
						lvls.push(i);
					}
				}
				GlobalScore.getLotsOfAverages(lvls, loadSavedTimes);
				firstRun = false;
			}
		}
		
		private function loadSavedTimes():void 
		{
			var s:Vector.<Door> = new Vector.<Door>();
			getType("Door", s);
			for (var i:int = 0; i < s.length; i++)
			{
				//trace("loadSavedTimes()->", i, "door. AKA->",s[i].getSavedName());
				s[i].displaySavedData(Data.readInt(s[i].getSavedName() + "_Time", -1), Data.readInt(s[i].getSavedName() + "_TimeChest", -1));
			}
		}
		
		override public function begin():void 
		{
			trace("[MainMenu] begin();");
			_player = new Player(level.getPlayerLocation());
			add(_player);
			
			/*_messageBox = new MessageBox();
			add(_messageBox);
			*/
			_overlay = new Overlay();
			add(_overlay);
			
			_title = new Title();
			add(_title);
			
			_tips = new Tips();
			add(_tips);
			
			_logo = StaticCache.logo;
			_logo.place(140, 50);
			add(_logo);
			
			_sponsor = StaticCache.sponsor;
			add(_sponsor);
			
			loadSavedTimes();
			
			_belowText = new Text("",  0, 0, { 	font:"Visitor",
																			size:LoadSettings.d.door.level_lable_font_size,
																			color:0xFFFFFF,
																			width: (640-10*2),
																			wordWrap: true,
																			align: "left" } );
			_belowTextWrapper = new Entity(10, 425, _belowText);
			add(_belowTextWrapper);
			
			getSavedStats();
		}
		
		override public function end():void
		{
			trace("Removing all. Does this cause world is null error");
			removeAll();
		}
		
		private function getSavedStats():void 
		{
			_belowText.text = "Deaths: " + GameStats.Deaths + "\nTime: " + Hud.formatTime(GameStats.Time) + "\nPixels: " + int(GameStats.Pixels) + "\nRestarts: " + GameStats.Restarts + "\nChests: " + GameStats.Chests + "/30";
		}
		
		public function getMessageBox():MessageBox
		{
			return _messageBox;
		}
		public function getPlayer():Player
		{
			return _player;
		}
		public function getLevel():Level
		{
			return level;
		}
		
		
		public function preDeathNotification():void
		{
			_title.moveOffScreen();
			_sponsor.moveOffScreen();
		}
		
	}

}