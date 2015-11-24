package  
{
	import adobe.utils.CustomActions;
	import com.greensock.TweenLite;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class SettingsKey extends Entity
	{
		private var _settingType:String
		private var _left:Boolean = false;
		[Embed(source = "Assets/Graphics/Items & Objects/c_red_key.png")]private static const RED_KEY:Class;
		[Embed(source = "Assets/Graphics/Items & Objects/a_yellow_key.png")]private static const YELLOW_KEY:Class;
		private var red:Image;
		private var yellow:Image;
		private var label:Text;
		
		private static var _GRAPHICS:Boolean = true;
		private static var _SOUND:Boolean = true;
		private static var _MUSIC:Boolean = true;
		
		//[Embed(source = "Assets/Audio/Music/Compressed/DST-TimeToDream.mp3")]private static const MUSIC_MENU:Class;
		[Embed(source = "Assets/Audio/Music/Compressed/DST-TimeToDream_Cropped.mp3")]private static const MUSIC_MENU:Class;
		[Embed(source = "Assets/Audio/Music/Compressed/DST-DasElectron_Cropped.mp3")]private static const MUSIC_BLUE:Class;
		[Embed(source = "Assets/Audio/Music/Compressed/DST-Skargo_Cropped.mp3")]private static const MUSIC_YELLOW:Class;
		[Embed(source = "Assets/Audio/Music/Compressed/DST-ElectroRock_Cropped.mp3")]private static const MUSIC_RED:Class;
		[Embed(source = "Assets/Audio/Music/Compressed/DST-Dangeroz_Cropped2.mp3")]private static const MUSIC_SECRET:Class;
		[Embed(source = "Assets/Audio/Music/Compressed/TutorialLoop.mp3")]private static const MUSIC_TUTORIAL:Class;
		public static var M_MENU:Sfx = new Sfx(MUSIC_MENU);
		public static var M_BLUE:Sfx = new Sfx(MUSIC_BLUE);
		public static var M_YELLOW:Sfx = new Sfx(MUSIC_YELLOW);
		public static var M_RED:Sfx = new Sfx(MUSIC_RED);
		public static var M_SECRET:Sfx = new Sfx(MUSIC_SECRET);
		public static var M_TUTORIAL:Sfx = new Sfx(MUSIC_TUTORIAL);
		
		public static var currentlyPlaying:Sfx;
		
		
		
		[Embed(source = "Assets/Audio/sfx/final/FinishedLevel.mp3")]private static const SFX_FINISHED_LEVEL:Class;
		[Embed(source = "Assets/Audio/sfx/final/chest_taken.mp3")]private static const SFX_CHEST_TAKEN:Class;
		[Embed(source = "Assets/Audio/sfx/final/key_taken.mp3")]private static const SFX_KEY_TAKEN:Class;
		[Embed(source = "Assets/Audio/sfx/splash_compressed.mp3")]private static const SFX_SPLASH:Class;
		[Embed(source = "Assets/Audio/sfx/final/door.mp3")]private static const SFX_DOOR:Class;
		[Embed(source = "Assets/Audio/sfx/final/jump.mp3")]private static const SFX_JUMP:Class;
		
		public static var S_FINISHED_LEVEL:Sfx = new Sfx(SFX_FINISHED_LEVEL);
		public static var S_CHEST_TAKEN:Sfx = new Sfx(SFX_CHEST_TAKEN);
		public static var S_KEY_TAKEN:Sfx = new Sfx(SFX_KEY_TAKEN);
		public static var S_SPLASH:Sfx = new Sfx(SFX_SPLASH);
		public static var S_DOOR:Sfx = new Sfx(SFX_DOOR);
		public static var S_JUMP:Sfx = new Sfx(SFX_JUMP);
		
		
		
		
		
		
		public function SettingsKey(X:int, Y:int, settingType:String, left:Boolean, displayName:String) 
		{
			super(X, Y);
			_settingType = settingType;
			_left = left;
			setHitbox(16, 16);
			
			
			var isOn:Boolean = Data.readBool(settingType, true);
			
			//Data.writeBool(settingType, isOn); //first time, save. Defaults to false
			//Data.save("miniQuestTrials");
			
			
			red = new Image(RED_KEY);
			yellow = new Image(YELLOW_KEY);
			
			if (isOn && !left || !isOn && left)
			{
				graphic = yellow;
			}
			else
			{
				graphic = red;
			}
			
			label = new Text(displayName,  8-200/2, LoadSettings.d.door.level_lable_y_pos - 5, { 	font:"Visitor",
																							size:LoadSettings.d.door.level_lable_font_size,
																							color:LoadSettings.d.door.time_label_font_color,
																							width: 200,
																							wordWrap: true,
																							align: "center" } );
			addGraphic(label);
			
			type = "SettingsKey";
		}
		
		public function takeKey():void
		{
			
			if ((graphic as Graphiclist).children[0] == yellow)
			{
				/*graphic = red;
				Data.writeBool(_settingType, false);
				broadcast(true);*/
			}
			else
			{
				(graphic as Graphiclist).remove(label);
				graphic = yellow;
				Data.writeBool(_settingType, !_left);
				
				
				if (_settingType == "Graphics") GRAPHICS = !_left;
				if (_settingType == "Sound") SOUND = !_left;
				if (_settingType == "Music") MUSIC = !_left;
				
				TweenLite.from(yellow, 0.5, { y:"-20" } );
				
				broadcast(false);
				addGraphic(label);
				if(SOUND)
					SettingsKey.playSound(SettingsKey.S_KEY_TAKEN);
			}
		}
		
		public function broadcast(turnOn:Boolean):void
		{
			var arr:Array = [];
			world.getType("SettingsKey", arr);
			for (var i:int = 0; i < arr.length; i++)
			{
				if (arr[i] != this)
				{
					arr[i].recieve(_settingType, turnOn);
				}
			}
		}
		
		public function recieve(_type:String, turnOn:Boolean):void
		{
			if (_type != _settingType) return;
			(graphic as Graphiclist).remove(label);
			if (turnOn)
				graphic = yellow;
			else
				graphic = red;
			addGraphic(label);
		}
		
		
		
		
		
		static public function init():void
		{
			GRAPHICS = Data.readBool("Graphics", true);
			SOUND = Data.readBool("Sound", true);
			MUSIC = Data.readBool("Music", true);
		}
		
		static public function get GRAPHICS():Boolean 
		{
			return _GRAPHICS;
		}
		
		static public function set GRAPHICS(value:Boolean):void 
		{
			_GRAPHICS = value;
		}
		
		static public function get SOUND():Boolean 
		{
			return _SOUND;
		}
		
		static public function set SOUND(value:Boolean):void 
		{
			_SOUND = value;
		}
		
		static public function get MUSIC():Boolean 
		{
			return _MUSIC;
		}
		
		static public function set MUSIC(value:Boolean):void 
		{
			_MUSIC = value;
			if (value == false)
			{
				var q:Sfx = currentlyPlaying;
				if (q == null) return;
				TweenLite.to(q, 1, { volume:0, onComplete:function():void {
					q.volume = 1;
					q.stop();
				}});
			}
			else
			{
				var q2:Sfx = currentlyPlaying;
				if (q2 == null) return;
				q2.loop(0);
				TweenLite.to(q2, 1, { volume:1});
			}
		}
		
		static public function loopMusic(s:Sfx, crossFade:Boolean = false ):void
		{
			//trace("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ", crossFade, currentlyPlaying);
			if (s == currentlyPlaying)
				return;
			
			if (MUSIC == false)
			{
				currentlyPlaying = s;
				s.loop(0);
				return;
			}
			//trace("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", crossFade, currentlyPlaying);
			if (crossFade && currentlyPlaying != null)
			{
				var q:Sfx;
				if (currentlyPlaying == M_MENU) 	q = M_MENU;
				if (currentlyPlaying == M_BLUE) 	q = M_BLUE;
				if (currentlyPlaying == M_YELLOW) 	q = M_YELLOW;
				if (currentlyPlaying == M_RED) 		q = M_RED;
				if (currentlyPlaying == M_SECRET) 	q = M_SECRET;
				if (currentlyPlaying == M_TUTORIAL) q = M_TUTORIAL;
				TweenLite.to(q, 1, { volume:0, onComplete:function():void {
					q.volume = 1;
					q.stop();
					//trace(q, currentlyPlaying, q == currentlyPlaying, q == s);
				}});
				//trace(q, currentlyPlaying, q == currentlyPlaying, q == s);
			}
			currentlyPlaying = s;
			s.loop(0);
			TweenLite.to(s, 1,  { volume:1 } );
		}
		
		
		static public function playSound(s:Sfx, volume:Number = 1):void
		{
			if (SOUND == false) return;
			
			s.play(volume);
		}
		
		
		
	}

}