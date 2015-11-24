package  
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class HallOfFame extends Entity
	{
		[Embed(source = "Assets/Graphics/Menus/halloffame_socket.png")]private const HALL:Class;
		private var _text:Text;
		private var _textArray:Array = [];
		public function HallOfFame(X:int, Y:int) 
		{
			super(X, Y);
			var i:Image = new Image(HALL);
			graphic = i;
			
			_text = createPage();
			
			addGraphic(_text);
			_textArray.push(_text);
			GlobalScore.getHallOfFameUsers(getNames);
		}
		
		private function getNames(arr:Array):void 
		{
			if (arr.length == 0)
			{
				_textArray[0].text = "Collect a Chest from all levels and beat the Secret Level to show your name to all the world! No one has managed to do it yet.";
				return;
			}
			//var arr:Array = ["TheAwsomeOpossum", "Sean_K", "polymerrabbit", "microman362", "cheeseofdoom", "NinjaGamer", "popseatem", "snakeface", "Slappytheclown", "LoonyLizard", "kim108", "locodude0001", "10kkenney", "evilgutarguy2", "Phoenix00017", "Lz_erk", "luong10", "aeonus", "Blank_64", "Warith", "Crispychknwing", "Bishsume", "Rivaledsouls", "davidarcila", "Kreg", "MossyStump", "HybridMind", "Profusion", "sanchez9416", "Sanchex", "Epic428", "BobTheCoolGuy", "luthimir", "skaren", "zero579911", "nutter666", "ST3ALTH15", "RTL_Shadow", "GameBuilder15", "GamerFefan", "Pimgd", "FlashBeast", "Frogmanex", "jonathanasdf", "wolfheat", "panerarocks", "pinoygamegeek", "player_03", "Wordblind", "BrainStormer", "HensHouse", "byrono", "maddiekaddie", "Feltope", "cannons", "Baukwolf", "Siveran", "mage_ruler9", "qwerber", "Syurba", "Plague_Studios", "Cloud_9ine", "Puppier", "saybox", "LtDeathCat", "TheWhiteAngel", "Darkscanner", "DPbrad", "HighUpStudio", "Devlini", "benny3t3", "Bryan127", "lord_midnight", "Mavyrk", "orandze", "Moshdef", "Ducklette", "AldenRogers", "Live2Die", "davidlougheed", "Trickysticks", "KeithG2", "Ultrabash1", "TheKaveman", "jdevelin", "Weres", "13islucky", "zys123", "rofl627", "unknownperson6", "Zshadow", "Modfriend", "IAmTheCandyman", "morgoth1", "12345wery", "therealsirmark4", "Infernon", "DarkTacoZ", "GDRTestMod", "nerdook", "AngryRug", "MadJedi", "trickyrodent", "omazing", "dehm", "LabyrinthMods", "VforVendetta", "FuzzyBacon", "Altiarshadow", "FrozenCereal", "jgrubbs78", "Hunter247", "KaGetsuVampire", "rjr001234", "AlphaGlory1", "DiditzZz", "killuformoney", "uuu2", "Vanstrom", "Evilspawn", "AgentLampshade", "tpbloomfield", "Spacial54", "zaraki", "Angelic77", "TheFacelessOne", "mrwiggs8", "newmuffin2112", "Le2Templar", "vegard20", "Believe", "zombiedestroy", "evryonedarkside", "iammuffin2112", "NewBlimpy", "diabolotry", "Anthill23", "gammaflux", "lockeness", "Colin50505", "Nahtangnouv", "RainaRavenwood", "ELmaestro", "uprightcitizen", "Solsund", "Gengii", "Rafael_MJ", "SubtleMedia", "resterman", "catcatali", "Fatcatsven", "truefire", "ForumsModFriend", "qazzaq123", "XXXXXXXXXXXXXX", "Live2Die", "davidlougheed", "Trickysticks", "KeithG2", "Ultrabash1", "TheKaveman", "jdevelin", "Weres", "13islucky", "zys123", "rofl627", "unknownperson6", "Zshadow", "Modfriend", "IAmTheCandyman", "morgoth1", "12345wery", "therealsirmark4", "Infernon", "DarkTacoZ", "GDRTestMod", "nerdook", "AngryRug", "MadJedi", "trickyrodent", "omazing", "dehm", "LabyrinthMods", "VforVendetta", "FuzzyBacon", "Altiarshadow", "FrozenCereal", "jgrubbs78", "Hunter247", "KaGetsuVampire", "rjr001234", "AlphaGlory1", "DiditzZz", "killuformoney", "uuu2", "Vanstrom", "Evilspawn", "AgentLampshade", "tpbloomfield", "Spacial54", "zaraki", "Angelic77", "TheFacelessOne", "mrwiggs8", "newmuffin2112", "Le2Templar", "vegard20", "Believe", "zombiedestroy", "evryonedarkside", "iammuffin2112", "NewBlimpy", "diabolotry", "Anthill23", "gammaflux", "lockeness", "Colin50505", "Nahtangnouv", "RainaRavenwood", "ELmaestro", "uprightcitizen", "Solsund", "Gengii", "Rafael_MJ", "SubtleMedia", "resterman", "catcatali", "Fatcatsven", "truefire", "ForumsModFriend", "qazzaq123"];
			for (var i2:int = 0; i2 < arr.length; i2++)
			{
				if (arr[i2].length > 10) arr[i2] = arr[i2].substring(0, 10);
				while (arr[i2].length < 10) arr[i2] = arr[i2] + "x";
			}
			var perPage:int = 60;
			var numPages:int = arr.length / perPage + 1;
			for (var i:int = 0; i < numPages; i++)
			{
				if (_textArray[i] == null)
				{
					_textArray[i] = createPage();
					addGraphic(_textArray[i]);
					_textArray[i].alpha = 0;
				}
				_textArray[i].text = arr.slice(i * perPage, i * perPage + perPage).join("   ");
			}
			//_text.text = arr.join("   ");
			_textArray[0].alpha = 1;
			
			startMagicTransition();
		}
		
		private function startMagicTransition():void 
		{
			if (_textArray.length == 1) return;
			TweenMax.allTo(_textArray, 1, { alpha:1 }, 5);
			TweenMax.allTo(_textArray, 1, { alpha:0, overwrite:false, delay:5 }, 5, startMagicTransition);
		}
		
		public function createPage():Text
		{
			return new Text("Loading...",  5, 8, { 	font:"Visitor",
																						size:LoadSettings.d.door.level_lable_font_size,
																						color:LoadSettings.d.door.chest_label_font_color,
																						width: 500,
																						height:240,
																						wordWrap: true,
																						align: "center",
																						resizable:false, 
																						leading:15} );
																						
		}
		
	}

}