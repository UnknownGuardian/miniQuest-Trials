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
	public class SubMenuWorld extends World
	{
		
		public var backdrop:Background;
		public var level:Level;
		private var _player:Player;
		private var _hallOfFame:HallOfFame;
		private var _secretPrompt:SecretPrompt;
		private var _to:String = "";
		private var _belowText:Text;
		private var _belowTextWrapper:Entity;
		private var _sponsor:SponsorLogoStamp;
		public function SubMenuWorld(to:String, from:String) 
		{
			backdrop = StaticCache.background;
			add(backdrop);
			
			level = new Level(to, from);
			add(level); //load main menu by default.
			
			if (to == "Menu_Hall of Fame")
			{
				_hallOfFame = new HallOfFame(640 / 2 - 513 / 2, 100);
				add(_hallOfFame);
				
				var num:int = Data.readInt("Secret 3_Time", -1);
				if (num == 1)
				{
					_secretPrompt = new SecretPrompt(640 / 2 - 208 / 2, 480 / 2 - 130 / 2);
					add(_secretPrompt);
				}
			}
			_to = to;
		}
		override public function begin():void 
		{
			if (_secretPrompt == null)
			{
				_player = new Player(level.getPlayerLocation());
				add(_player);
			}
			
			_belowText = new Text(LoadSettings.d.menu[_to],  0, 0, { 	font:"Visitor",
																			size:LoadSettings.d.door.level_lable_font_size,
																			color:0xFFFFFF,
																			width: (640-10*2),
																			wordWrap: true,
																			align: "left" } );
			_belowTextWrapper = new Entity(10, 425, _belowText);
			add(_belowTextWrapper);
			
			_sponsor = StaticCache.sponsor;
			_sponsor.place(620, 455);
			add(_sponsor);
			
			/*_messageBox = new MessageBox();
			add(_messageBox);
			
			_overlay = new Overlay();
			add(_overlay);
			
			_itemBar = new ItemBar();
			add(_itemBar);*/
			
		}
		
		override public function end():void
		{
			removeAll();
		}
		
		public function preDeathNotification():void
		{
			if (_to == "Menu_Settings")
			{
				Data.save("miniQuestTrials");
			}
			_sponsor.moveOffScreen();
		}
	}

}