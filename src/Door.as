package 
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Data;
	import punk.transition.effects.StripeFadeIn;
	import punk.transition.effects.StripeFadeOut;
	import punk.transition.Transition;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Door extends Entity
	{
		
		[Embed(source = "Assets/Graphics/SpriteSheets/treasure_SS.png")]private static const TILES:Class;
		[Embed(source = "Assets/Graphics/SpriteSheets/door_SS.png")]private static const DOOR_ANIM:Class;
		[Embed(source = "Assets/Graphics/Items & Objects/door.png")]private static const DOOR:Class;
		[Embed(source = "Assets/Fonts/Visitor-TT1--BRK-.ttf", embedAsCFF="false", fontFamily = 'Visitor')]private static const VISITOR:Class;
		public var anim:Spritemap = new Spritemap(DOOR_ANIM, 16, 16);
		public var chestAnim:Spritemap;
		private var levelLabel:Text;
		private var _targetLocation:String = "";
		
		
		private var timeLabel:Text;
		private var timeLabelGlobalPar:Text;
		private var timeLabelWithChest:Text;
		public static var DoorHoveringOver:Door;
		private var _subMenuHoverString:String = "";
		public function Door(X:int,Y:int, targetLocation:String = "") 
		{
			super(X, Y);
			
			anim.add("open", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], LoadSettings.d.door.open_speed, false);
			anim.add("close", [29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0], LoadSettings.d.door.open_speed, false);
			
			if (targetLocation.indexOf("Level ") == 0 && targetLocation != "Level Select") //This door leads to a level.
			{
				var t:String = targetLocation.split(" ")[1]; //just level number, skip text "Level"
				levelLabel = new Text(t,  8-LoadSettings.d.door.level_lable_font_width/2, LoadSettings.d.door.level_lable_y_pos, { 	font:"Visitor",
																						size:LoadSettings.d.door.level_lable_font_size,
																						color:LoadSettings.d.door.level_lable_font_color,
																						width: LoadSettings.d.door.level_lable_font_width,
																						wordWrap: true,
																						align: "center" } );
				graphic = new Graphiclist(anim, levelLabel);
				setHitbox(16, 16, 0, 0);
				
				var num:int = int(t);
				if (num >= 3)
				{
					trace("DOOR->", num, getNumLevelsCompletedFrom(1, num));
					if (getNumLevelsCompletedFrom(1, num) < num - 3)
					{
						//lock door up
						anim.color = 0x000000;
						anim.tinting = 0.5;
					}
				}
				
				
				/*if ([3, 5, 9, 11, 13, 18, 23, 26, 28].indexOf(int(t)) == -1)
				{
					collidable = false;
					anim.color = 0x000000;
					anim.tinting = 0.8;
				}*/
			}
			else if (targetLocation.indexOf("Menu_") == 0)
			{
				var t2:String = targetLocation.split("_")[1]; //just regular text , skip text "Menu"
				levelLabel = new Text(t2,  8-LoadSettings.d.door.level_lable_font_width/2, LoadSettings.d.door.level_lable_y_pos, { 	font:"Visitor",
																						size:LoadSettings.d.door.level_lable_font_size,
																						color:LoadSettings.d.door.level_lable_font_color,
																						width: LoadSettings.d.door.level_lable_font_width,
																						wordWrap: true,
																						align: "center" } );
				graphic = new Graphiclist(anim, levelLabel);
				setHitbox(26, 26, 5, 5);
			}
			else if (targetLocation.indexOf("SubMenu_") == 0)
			{
				var t3:String = LoadSettings.d.door[targetLocation.substr("SubMenu_".length)].name; //just regular text , skip text "Menu"
				levelLabel = new Text(t3,  8-LoadSettings.d.door.level_lable_font_width/2, LoadSettings.d.door.level_lable_y_pos, { 	font:"Visitor",
																						size:LoadSettings.d.door.level_lable_font_size,
																						color:LoadSettings.d.door.level_lable_font_color,
																						width: LoadSettings.d.door.level_lable_font_width,
																						wordWrap: true,
																						align: "center" } );
				graphic = new Graphiclist(anim, levelLabel);
				
				if (LoadSettings.d.door[targetLocation.substr("SubMenu_".length)].hover != undefined)
				{
					_subMenuHoverString = LoadSettings.d.door[targetLocation.substr("SubMenu_".length)].hover;
					
					if (targetLocation == "SubMenu_Menu_Hall of Fame 2")
					{
						//check if all chests exist, deny entry.
						var isGood:Boolean = true;
						for (var i:int = 1; i < 31; i++)
						{
							if (Data.readInt("Level " + i + "_TimeChest", -1) == -1)
							{
								isGood = false;
								break;
							}
						}
						if (!isGood)
						{
							_subMenuHoverString = LoadSettings.d.door[targetLocation.substr("SubMenu_".length)].hoverUnlock;
							//anim.blend = "multiply"; 
							anim.color = 0x000000;
							anim.tinting = 0.5;
						}
					}
					
					subMenuShowHover();
				}
				
				
				
				setHitbox(26, 26, 5, 5);
				if (t3 == LoadSettings.d.door.door_exit_syn)
				{
					targetLocation = LoadSettings.d.door.door_exit_target;
				}
			}
			else
			{
				graphic = anim;
				setHitbox(16, 16, 0, 0);
			}
			_targetLocation = targetLocation;
			type = "Door";
			layer = 269
			trace("[Door] constructor(", X, ",", Y, ",", targetLocation, ");");
		}
		
		public function getSavedName():String
		{
			return _targetLocation;
		}
		
		public function open():void
		{
			SettingsKey.playSound(SettingsKey.S_DOOR);
			
			if (world is TutorialWorld)
			{
				var arr2:Vector.<Bubble> = new Vector.<Bubble>();
				world.getType("Bubble", arr2);
				arr2[0].fade();
				
			}
			
			
			//save the ending
			trace("DATA FOR YOU FOOLS", Level.currentLevel, _targetLocation);
			if (Level.currentLevel == "Secret 3" && _targetLocation == "Menu_Hall of Fame")
			{
				trace("SHOULD SAVE SECRET LEVEL HERE", Data.readInt("Secret 3_Time", -1));
				//never beat the secret levels before
				if (Data.readInt("Secret 3_Time", -1) == -1)
				{
					Data.writeInt("Secret 3_Time", 1);
					Data.save("miniQuestTrials");
				}
			}
			
			
			
			anim.play("open");
			var dur:int = LoadSettings.d.transition.duration;
			var sDur:int = LoadSettings.d.transition.stripeDuration;
			trace("[Door] open();", Level.currentLevel, " -> " + _targetLocation);
			
			if(_targetLocation.indexOf("Level ") == 0 && _targetLocation != "Level Select" && anim.color == 0xFFFFFF) //if is level
				Transition.to(new LevelWorld(_targetLocation,Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ),{onInComplete:Player.stopTransitioning} );
			else if (_targetLocation == "Main Menu" || _targetLocation == "Menu_Back" )
				Transition.to(new MainMenu(Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onInComplete:Player.stopTransitioning } );
			else if (_targetLocation == "Menu_New Game" || _targetLocation == "Level Select")
			{
				Transition.to(new LevelSelectWorld(Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onInComplete:Player.stopTransitioning } );
			}
			else if (_targetLocation == "Menu_More Games")
			{
				var action2:String = LoadSettings.d.door["menu_bottom_4"].action;
				{
					if (action2 == null) { } //undefined is coerced to null
					else if (action2.indexOf("http") == 0)
					{
						navigateToURL(new URLRequest(action2));
					}
				}
			}
			else if (_targetLocation == "Menu_Tutorial")
			{
				Transition.to(new TutorialWorld(), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onInComplete:Player.stopTransitioning } );
			}
			else if(_targetLocation.indexOf("Menu_") == 0) //if is level
				Transition.to(new SubMenuWorld(_targetLocation, Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onInComplete:Player.stopTransitioning } )
			else if (_targetLocation == "SubMenu_Menu_Hall of Fame 2")
			{
				
			}
			
			if (_targetLocation.indexOf("SubMenu_") == 0)//sub menu, but not exit door
			{
				var action:String = LoadSettings.d.door[_targetLocation.substr("SubMenu_".length)].action;
				{
					if (action == null) { } //undefined is coerced to null
					else if (action.indexOf("http") == 0)
					{
						navigateToURL(new URLRequest(action));
					}
					else if (action == "Secret 1" && anim.color == 0xFFFFFF)
					{
						Transition.to(new SecretWorld(_targetLocation,Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ),{onInComplete:Player.stopTransitioning} );
					}
				}
			}
			else if (_targetLocation.indexOf("Secret") == 0)
			{
				Transition.to(new SecretWorld(_targetLocation,Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ),{onInComplete:Player.stopTransitioning} );
			}
				
			
			
			
			//stop level select doors from triggering HUD from moving off.
			if (_targetLocation.indexOf("Level ") == 0 && _targetLocation != "Level Select" && anim.color == 0x000000) //if is level
				return;
				
			//stop menu doors from triggering HUD from moving off
			if (_targetLocation.indexOf("Menu_More Games") == 0)
				return;
				
			world['preDeathNotification']();
		}
		
		public function close(p:Player):void
		{
			trace("tried to close", anim.color);
			
			if ((_targetLocation.indexOf("SubMenu_") == 0 && _targetLocation != "SubMenu_Menu_Hall of Fame 2") || (_targetLocation == "SubMenu_Menu_Hall of Fame 2" && anim.color == 0x000000))//sub menu, but not exit door
			{
				TweenLite.to(p.anim, 0.5, { alpha:1, delay:0.5, overwrite:false, onComplete:function():void { Player.stopTransitioning(); anim.play("close"); } } );
			}
			else if (_targetLocation.indexOf("Level ") == 0 && _targetLocation != "Level Select" && anim.color == 0x000000)
			{
				TweenLite.to(p.anim, 0.5, { alpha:1, delay:0.5, overwrite:false, onComplete:function():void { Player.stopTransitioning(); anim.play("close"); } } );
			}
			if (_targetLocation.indexOf("Menu_More Games") == 0)
			{
				TweenLite.to(p.anim, 0.5, { alpha:1, delay:0.5, overwrite:false, onComplete:function():void { Player.stopTransitioning(); anim.play("close"); } } );
			}
			
		}
		
		public function subMenuShowHover():void
		{
			
			timeLabelGlobalPar = new Text(_subMenuHoverString,  8-LoadSettings.d.door.level_lable_font_width/2, LoadSettings.d.door.level_lable_y_pos - 20, { 	font:"Visitor",
																						size:LoadSettings.d.door.level_lable_font_size,
																						color:LoadSettings.d.door.chest_label_font_color,
																						width: LoadSettings.d.door.level_lable_font_width,
																						wordWrap: true,
																						align: "center" } );
			addGraphic(timeLabelGlobalPar);
			timeLabelGlobalPar.visible = false;
		}
		
		public function displaySavedData(time:int, chestTime:int = -1):void
		{
			var smartX:int = 0;
			var levelNumber:int =  int(_targetLocation.split(" ")[1]); //just level number, skip text "Level"
			
			if (levelNumber % 10 == 1) smartX = 10;
			if (levelNumber % 10 == 0) smartX = -10;
			
			
			//trace("displaySavedData(", time,",", hasChest, ");");
			if (time != -1)
			{
				if (timeLabel == null)
				{
					timeLabel = new Text(formatTime(time),  smartX + 8-LoadSettings.d.door.level_lable_font_width/2, LoadSettings.d.door.level_lable_y_pos - 10, { 	font:"Visitor",
																							size:LoadSettings.d.door.level_lable_font_size,
																							color:LoadSettings.d.door.time_label_font_color,
																							width: LoadSettings.d.door.level_lable_font_width,
																							wordWrap: true,
																							align: "center" } );
					addGraphic(timeLabel);
				}
				
				var parTime:Number = GlobalScore.pullAverageFromCache(_targetLocation.split(" ")[1]);
				if (timeLabelGlobalPar == null)
				{
					timeLabelGlobalPar = new Text("Par: " + formatTime(parTime * 1000),  smartX + 8-LoadSettings.d.door.level_lable_font_width/2, LoadSettings.d.door.level_lable_y_pos - 20, { 	font:"Visitor",
																							size:LoadSettings.d.door.level_lable_font_size,
																							color:LoadSettings.d.door.time_label_font_color,
																							width: LoadSettings.d.door.level_lable_font_width,
																							wordWrap: true,
																							align: "center" } );
					timeLabelGlobalPar.visible = false;
				
					if(parTime != -1)
					addGraphic(timeLabelGlobalPar);
				}
				else
				{	
					addGraphic((graphic as Graphiclist).remove(timeLabelGlobalPar))
					timeLabelGlobalPar.text = "Par: " + formatTime(parTime * 1000);
				}
			}
			if (chestTime != -1)
			{
				if (chestAnim == null)
				{
					chestAnim = new Spritemap(TILES, 16, 16);
					var frameRate:int = LoadSettings.d.chest.flashSpeed;
					chestAnim.add("sparkle",[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], 0.5, true);
					chestAnim.play("sparkle");
					chestAnim.x = smartX;
					chestAnim.y = -73;
					addGraphic(chestAnim);
					chestAnim.visible = false;
				}
				if (timeLabelWithChest == null)
				{
					
					timeLabelWithChest = new Text(formatTime(chestTime),  smartX + 8-LoadSettings.d.door.level_lable_font_width/2, LoadSettings.d.door.level_lable_y_pos - 20, { 	font:"Visitor",
																							size:LoadSettings.d.door.level_lable_font_size,
																							color:LoadSettings.d.door.chest_label_font_color,
																							width: LoadSettings.d.door.level_lable_font_width,
																							wordWrap: true,
																							align: "center" } );
					addGraphic(timeLabelWithChest);
				}
			}
		}
		
		
		public function formatTime(num:int):String
		{
			var temp:int = (num - (int(num / 1000) * 1000));
			if (temp >= 100)
				return int(num / 1000) + "." + temp;
			else if (temp >= 10)
				return int(num / 1000) + ".0" + temp;
			else
				return int(num / 1000) + ".00" + temp;
			
		}
		
		public function onPlayerOver():void
		{
			if (DoorHoveringOver == this)
				return;
			if (_targetLocation.indexOf("Level ") == 0 || _targetLocation.indexOf("SubMenu_") == 0) //if is level
			{
				if (chestAnim)
				{
					chestAnim.visible = true;
					chestAnim.alpha = 0;
					TweenLite.to(chestAnim, 0.5, { alpha:1 } );
				}
				if (timeLabelGlobalPar)
				{
					timeLabelGlobalPar.alpha = 0;
					timeLabelGlobalPar.visible = true;
					TweenLite.to(timeLabelGlobalPar, 0.5, { alpha: 1 } );
				}
				if (timeLabelWithChest)
				{
					TweenLite.to(timeLabelWithChest, 0.5, { y: -55 } );
				}
				DoorHoveringOver = this;
			}
		}
		
		public function onPlayerOut():void
		{
			if (DoorHoveringOver != this)
				return;
			if (_targetLocation.indexOf("Level ") == 0 || _targetLocation.indexOf("SubMenu_") == 0) //if is level
			{
				if (chestAnim)
				{
					TweenLite.to(chestAnim, 0.5, { alpha:0, onComplete:function():void { chestAnim.visible = false} } );
				}
				if (timeLabelGlobalPar)
				{
					TweenLite.to(timeLabelGlobalPar, 0.5, { alpha: 0, onComplete:function():void { timeLabelGlobalPar.visible = false} } );
				}
				if (timeLabelWithChest)
				{
					TweenLite.to(timeLabelWithChest, 0.5, { y:LoadSettings.d.door.level_lable_y_pos - 20 } );
				}
				DoorHoveringOver = null;
			}
		}
		
		public function getNumLevelsCompletedFrom(start:int, end:int):int
		{
			if (end > 31) end = 31;
			if (start < 1) start = 1;
			
			var count:int = 0;
			for (var i:int = start; i < end; i++)
			{
				if (Data.readInt("Level " + i + "_TimeChest", -1) != -1 || Data.readInt("Level " + i + "_Time", -1) != -1)
				{
					count++;
				}
			}
			
			return count;
		}
	}

}