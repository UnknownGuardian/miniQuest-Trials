package  
{
	import com.greensock.TweenLite;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Tips extends Entity
	{
		private var _belowText:Text;
		public static const INTRO:String = "Welcome to miniQuest: Trials.    Prepare yourself.";
		public static const MOVEMENT:String = "Arrow Keys/WASD to move!        Z or W to Jump\n\nPress Up to Enter a Door.";
		public static const DOOR:String = "Press UP or W to open the door and enter the level.";
		public static const DOOR_EXTRA:String = "Your fastest run with a chest is in gold and without is in blue. \n\nPAR time is the average of all players\n who have played this level ever.";
		public function Tips() 
		{
			_belowText = new Text(INTRO,  120, 425, { 	font:"Visitor",
													size:LoadSettings.d.door.level_lable_font_size,
													color:0xFFFFFF,
													width: 400,
													wordWrap: true,
													align: "center" } );
			graphic = _belowText;
			
			type = "Tips";
		}
		
		public function setTip(s:String):void
		{
			if (s == MOVEMENT)_belowText.color = 0xDFDF00;
			else _belowText.color  = 0xFFFFFF;
			_belowText.alpha = 0;
			_belowText.text = s;
			TweenLite.to(_belowText, 1, { alpha:1 } );
		}
		
		public function getTip():String
		{
			return _belowText.text;
		}
		
	}

}