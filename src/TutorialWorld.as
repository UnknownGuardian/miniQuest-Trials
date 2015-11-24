package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TutorialWorld extends World 
	{
		public var backdrop:Background;
		public var level:Level;
		private var _player:Player;
		private var _title:Title;
		private var _tutorial:TutorialTitle;
		private var bubble:Bubble;
		
		public function TutorialWorld() 
		{
			backdrop = StaticCache.background;
			add(backdrop);
			
			level = new Level("Tutorial Level", "Level Select");
			add(level); //load main menu by default.
			
			_title = new Title(/*-204, 0*/);
			add(_title);
			
			_tutorial = new TutorialTitle();
			add(_tutorial);
			
			bubble = StaticCache.bubble;
			add(bubble);
			
			bubble.setBubble("1");
			
			SettingsKey.loopMusic(SettingsKey.M_TUTORIAL, true);
		}
		
		
		override public function begin():void 
		{
			_player = new Player(level.getPlayerLocation());
			add(_player);
		}
		
		override public function update():void
		{
			if (_player.y > 380) //bottom 3
			{
				if ( _player.x < 140)
					bubble.setBubble("1");
				else if (_player.x < 315)
					bubble.setBubble("2");
				else if (_player.x > 440 && _player.x < 556)
					bubble.setBubble("3");
				else
					bubble.clear();
			}
			else if ( _player.y > 270)
			{
				if (_player.x > 430 && _player.x < 558)
					bubble.setBubble("4");
				else if (_player.x > 240 && _player.x < 415 )
					bubble.setBubble("5");
				else
					bubble.clear();
			}
			else if (_player.y  > 100)
			{
				if (_player.x < 270 && _player.x > 105)
					bubble.setBubble("6");
				else
					bubble.clear();
			}
			else if (_player.y < 85)
			{
				bubble.setBubble("7");
				if (!_title.isMovingOff)_title.moveOffScreen();
				if (!_tutorial.isMovingOff) _tutorial.moveOffScreen();
			}
			
			bubble.place(_player.x, _player.y);
			trace(_player.x, _player.y);
			
			super.update();
		}
		
		//this will only be triggered by pressing ESCAPE on the tutorial level
		public function moveHUDOff():void
		{
			_title.moveOffScreen();
			_tutorial.moveOffScreen();
			var arr2:Vector.<Bubble> = new Vector.<Bubble>();
			getType("Bubble", arr2);
			arr2[0].fade();
		}
		
		override public function end():void
		{
			removeAll();
		}
		
		public function preDeathNotification():void
		{
			bubble.fade();
		}
		
	}

}