package  
{
	/**
	 * ...
	 * @author UG
	 */
	public class StaticCache 
	{
		
		public function StaticCache() 
		{
			
		}
		
		
		public static var background:Background = new Background();
		public static var bubble:Bubble = new Bubble();
		public static var mute:MuteBtn = new MuteBtn();
		public static var logo:GameLogoStamp = new GameLogoStamp();
		public static var bigLogo:BigGameLogoStamp = new BigGameLogoStamp();
		public static var sponsor:SponsorLogoStamp = new SponsorLogoStamp();
		public static var bigSponsor:CenterLogoSplash = new CenterLogoSplash();
		
		
		private static var fireballs:Vector.<Fireball> = new Vector.<Fireball>();
		public static function getFireball():Fireball
		{
			var r:Fireball;
			for (var i:int = 0; i < fireballs.length; i++)
			{
				if (!fireballs[i].inUse)
				{
					r = fireballs[i];
					break;
				}
			}
			
			if (r == null)
			{
				fireballs.push(new Fireball());
				r = fireballs[fireballs.length - 1];
			}
			return r;
		}
		
	}

}