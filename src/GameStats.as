package  
{
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class GameStats 
	{
		public static var Deaths:int = 0;
		public static var Time:Number = 0;
		public static var Pixels:Number = 0;
		public static var Chests:int = 0;
		public static var Restarts:int = 0;
		public function GameStats() 
		{
			
		}
		
		
		static public function loadStats():void
		{
			Deaths = Data.readInt("Deaths", 0);
			Time = Data.readInt("Time", 0);
			Pixels = Data.readInt("Pixels", 0);
			Chests = Data.readInt("Chests", 0); //do format 10/30, so be worried about duplicate chest collections
			Restarts = Data.readInt("Restarts", 0);
		}
		
		static public function save():void
		{
			Data.writeInt("Deaths", Deaths);
			Data.writeInt("Time", Time);
			Data.writeInt("Pixels", Pixels);
			Data.writeInt("Chests", Chests); //do format 10/30, so be worried about duplicate chest collections
			Data.writeInt("Restarts", Restarts);
			Data.save("miniQuestTrials");
		}
	}

}