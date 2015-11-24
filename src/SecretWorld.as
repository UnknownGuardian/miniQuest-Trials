package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Data;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class SecretWorld extends World
	{
		public var backdrop:Background;
		public var level:Level;
		private var _player:Player;
		//private var _hud:Hud;
		private var _to:String;
		private var _overlay:Overlay;
		public function SecretWorld(to:String, from:String) 
		{
			backdrop = StaticCache.background;
			add(backdrop);
			
			level = new Level(to, from);
			add(level); //load main menu by default.
			
			//_hud = new Hud(to);
			//add(_hud);
			
			_to = to;
			SettingsKey.loopMusic(SettingsKey.M_SECRET, true);
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
			
			//_overlay = new Overlay();
			//add(_overlay);
		}
		
		override public function end():void
		{
			removeAll();
		}
		
		public function preDeathNotification():void
		{
			
		}
	}

}