package
{
	import be.boulevart.as3.security.Base64;
	import com.greensock.TweenLite;
	import flash.utils.getTimer;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import punk.transition.effects.StripeFadeIn;
	import punk.transition.effects.StripeFadeOut;
	import punk.transition.Transition;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class SecretPrompt extends Entity
	{
		[Embed(source="Assets/Graphics/Menus/endgame_name_input.png")]
		private static const PROMPT:Class;
		private var txt:Text;
		private var instructions:Text;
		private var r:RegExp = new RegExp(/[^a-zA-Z 0-9\-]+/g) ;
		private var _canSubmit:Boolean = true;
		public function SecretPrompt(X:int, Y:int)
		{
			super(X, Y);
			var i:Image = new Image(PROMPT);
			graphic = i;
			
			txt = new Text("", 14 + 5, 75 + 2, {font: "Visitor", size: LoadSettings.d.door.level_lable_font_size, color: LoadSettings.d.door.chest_label_font_color, width: 170, wordWrap: true, align: "center"});
			addGraphic(txt);
			
			instructions = new Text("Don't be blank!", 15, 95, {font: "Visitor", size: LoadSettings.d.door.level_lable_font_size, color: LoadSettings.d.door.time_label_font_color, width: 170, wordWrap: true, align: "center"});
			addGraphic(instructions);
			
			
			Input.keyString = txt.text;
		}
		
		override public function update():void
		{
			if (_canSubmit)
			{
				var newInput:String = Input.keyString.substr(0, 10);
				newInput = newInput.replace(r, "");
				Input.keyString = newInput;
				if (txt.text != newInput)
				{
					txt.text = newInput;
					if (txt.text.length < 2)
						instructions.text = "Don't be blank!";
					else if ( txt.text.length < 10)
						instructions.text = "Almost there, need a few more characters!"
					else if ( txt.text.length == 10)
						instructions.text = "Press ENTER to submit!\nThen return in a few moments to see your name!"
				}
				if (Input.check(Key.ENTER) && txt.text.length == 10)
				{
					//submit!!!
					var once:String = encrypt(txt.text, "Good_Job_On_Making_It_This_Far");
					var twice:String = encrypt(once + "|" + int(getTimer()/1000000), "^Check)Out#The@Rest!Of&Our%Games*");
					GlobalScore.postUsername(twice, txt.text);
					GlobalScore.invalidateHallOfFameCache();
					_canSubmit = false;
					Data.writeInt("Secret 3_Time", 2);
					Data.save("miniQuestTrials");
					
					
					
					var dur:int = LoadSettings.d.transition.retry_duration;
					var sDur:int = LoadSettings.d.transition.retry_stripeDuration;
					Transition.to(new SubMenuWorld("Menu_Hall of Fame", Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onInComplete:Player.stopTransitioning } )
					return;
				}
			}
		}
		
		//http://cambiatablog.wordpress.com/2010/08/24/simple-encryptdecrypt-in-as3-and-php-base64-blues/
		static public function encrypt(str:String, key:String = '%key&'):String {
			var result:String = '';
			for (var i:int = 0; i < str.length; i++) {
				var char:String = str.substr(i, 1);
				var keychar:String = key.substr((i % key.length) - 1, 1);
				var ordChar:int = char.charCodeAt(0);
				var ordKeychar:int = keychar.charCodeAt(0);
				var sum:int = ordChar + ordKeychar;
				char = String.fromCharCode(sum);
				result = result + char;
			}
			return Base64.encode(result);
		}

	
	}

}