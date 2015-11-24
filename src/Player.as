package  
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Screen;
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
	public class Player extends Entity 
	{
		[Embed(source = "Assets/Graphics/Characters/16x16_sharpened.png")]private static const ANIM:Class;
		public var anim:Spritemap = new Spritemap(ANIM, 16, 16);
		
		private var _v:Point;
		private static var GRAVITY:Number = 1.20;
		private static var FRICTION:Number = .80;
		private static var JUMP_POWER:Number = 8;
		private static var MAX_Y_VEL:Number = 16;
		//private static var CAMERA_FOLLOWING:Boolean = true;
		private static var NUM_JUMPS_RESET:int = 1;
		private static var PARALLAX_SPEED:Number = 1;
		private static var MIN_RUN_SPEED:Number = 1.5;
		
		private var maxXSpeed:Number = 7.2;
		private var numJumpsLeft:Number = 0;
		private var xAccel:Number = 1.0;
		
		private var lastSavedLoc:Point = new Point();
		public static var isTransitioning:Boolean = false;
		
		private var lastMove:int = 0;
		
		public function Player(p:Point) 
		{
			anim.setFrame(1);
			x = p.x;
			y = p.y;
			_v = new Point();
			lastSavedLoc = p.clone();
			graphic = anim;
			var frameRate:Number = 20;
			anim.add("down", [11, 10, 9], frameRate, true);
			anim.add("stilldown", [10], frameRate, true);
			anim.add("left", [3, 4, 5], frameRate, true);
			anim.add("stillleft", [4], frameRate, true);
			anim.add("right", [6, 7, 8], frameRate, true);
			anim.add("stillright", [7], frameRate, true);
			anim.add("up", [9, 10, 11], frameRate, true);
			anim.add("stillup", [10], frameRate, true);
			anim.add("still", [1], frameRate/4, true);
			anim.add("stillLadder", [9,10,11], frameRate/4, true);
			anim.add("door", [9,10,11], frameRate/10, true);
			
			loadPlayerSettings();
			anim.x = -2;
			anim.y = -4;
			setHitbox(12,12, 0, 0);
			type = "player";
			layer = 201;
		}

		public function loadPlayerSettings():void
		{
			GRAVITY = LoadSettings.d.player.gravity;
			FRICTION = LoadSettings.d.player.friction;
			JUMP_POWER = LoadSettings.d.player.jump_power;
			MAX_Y_VEL = LoadSettings.d.player.max_y_velocity;
			//CAMERA_FOLLOWING = LoadSettings.d.player.camera_following;
			Dirt.DISTANCE_ABOVE_FOR_COLLISION = LoadSettings.d.dirt.distanceAboveToTriggerDisolve;
			/*if (LoadSettings.d.screen == "none")
				FP.screen = new Screen();
			else
				FP.screen = new ScreenRetro(ScreenRetro[LoadSettings.d.screen], []);
				*/
			NUM_JUMPS_RESET = LoadSettings.d.player.jumps_in_a_row;	
			PARALLAX_SPEED = LoadSettings.d.background.parallax_speed;
			MIN_RUN_SPEED = LoadSettings.d.player.min_run_speed;
		}
		
		override public function update():void
		{
			if (!isTransitioning)
			{
				if (Input.pressed("Any"))
				{
					if (world is LevelWorld && !(world as LevelWorld).getHud().running)
						(world as LevelWorld).getHud().startTime();
				}
				updateMovement();
				updateCollision();
				checkRestart();
				if (world is MainMenu || world is LevelSelectWorld)
				{
					if (lastMove == 150 && Door.DoorHoveringOver == null)
					{
						var arr:Array = [];
						world.getType("Tips", arr);
						arr[0].setTip(Tips.MOVEMENT);
					}
				}
			}
			super.update();
			if (!isTransitioning && Input.check(Key.ESCAPE) && Level.currentLevel != "Menu_Hall of Fame" && Level.currentLevel != "Main Menu")
			{
				isTransitioning = true;
				var dur:int = LoadSettings.d.transition.duration;
				var sDur:int = LoadSettings.d.transition.stripeDuration;
				if (Level.currentLevel == "Level Select" || Level.currentLevel.indexOf("Menu_") == 0)
				{
					Transition.to(new MainMenu(Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onInComplete:Player.stopTransitioning } );
				}
				else
				{
					Transition.to(new LevelSelectWorld(Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onInComplete:Player.stopTransitioning } );
				}
				if (world is LevelWorld)
				{
					(world as LevelWorld).getHud().moveOffScreen();
				}
				if (world is TutorialWorld)
				{
					(world as TutorialWorld).moveHUDOff();
				}
				if (world is LevelSelectWorld)
				{
					(world as LevelSelectWorld).preDeathNotification();
				}
				//FP.console.enable();
			}
			if (Input.check(FP.console.toggleKey))
			{
				FP.console.enable();
			}
			if (Input.check(Key.TAB))
			{
				LoadSettings.load(null);
				loadPlayerSettings();
				var s:Array = [];
				world.getType("Spike", s);
				for (var i:int = 0; i < s.length; i++) { 		s[i].reloadLoadSettings();		}
			}
			if (Input.released(Key.M))
			{
				if (SettingsKey.MUSIC)
				{
					SettingsKey.MUSIC = false;
					SettingsKey.SOUND = false;
				}
				else
				{
					SettingsKey.MUSIC = true;
					SettingsKey.SOUND = true;
				}
				StaticCache.mute.correctDisplay();
			}
		}
		
		public function checkRestart():void 
		{
			if (!isTransitioning && Input.check(Key.R) && world is LevelWorld)
			{
				trace("[Player] checkRestart()");
				respawn();
				GameStats.Restarts++;
			}
		}
		
		private function updateMovement():void
		{
			lastMove++;
			if ((Input.pressed(Key.Z) && numJumpsLeft > 0 && !collide("Ladder", x, y)) || (Input.pressed(Key.W) && numJumpsLeft > 0 && !collide("Ladder", x, y)&& !collide("Door", x, y)))
			{
				_v.y = -JUMP_POWER;
				numJumpsLeft--;
				lastMove = 0;
				SettingsKey.playSound(SettingsKey.S_JUMP, 0.6);
			}
			else if (_v.y > MAX_Y_VEL) _v.y = MAX_Y_VEL;
			if (Input.check(Key.LEFT) || Input.check(Key.A))
			{
				_v.x += -xAccel;
				lastMove = 0;
			}
			else if (Input.check(Key.RIGHT) || Input.check(Key.D))
			{
				_v.x += xAccel;
				lastMove = 0;
			}
		}
		
		private function updateCollision():void
		{
			var xAnim:String = anim.currentAnim;
			var yAnim:String = anim.currentAnim;
			
			
			var i:int = 0;
			var spike:Entity = collide("Spike", x, y);
			if (spike != null)
			{
				GameStats.Deaths++;
				respawn();
				return;
			}
			
			var fireball:Entity = collide("Fireball", x, y);
			if (fireball != null)
			{
				GameStats.Deaths++;
				respawn();
				return;
			}
			var pac:Entity = collide("PacCrawler", x, y);
			if (pac != null)
			{
				GameStats.Deaths++;
				respawn();
				return;
			}
			
			var key:Entity = collide("BlueKey", x, y);
			if (key != null)
			{
				(key as BlueKey).takeKey();
			}
			key = collide("RedKey", x, y);
			if (key != null)
			{
				(key as RedKey).takeKey();
			}
			key = collide("YellowKey", x, y);
			if (key != null)
			{
				(key as YellowKey).takeKey();
			}
			key = collide("SettingsKey", x, y);
			if (key != null)
			{
				(key as SettingsKey).takeKey();
			}
			
			
			var chest:Chest = collide("Chest", x, y) as Chest;
			if (chest != null)
			{
				chest.takeChest();
			}
			
			
			
			if (!isTransitioning) //check if not transitioning
			{
				if (world is LevelWorld)//doors in levels will just require player to be over, no key press
				{
					var levelDoor:Entity = collide("Door", x, y);
					if (levelDoor != null)
					{
						(levelDoor as Door).open();
						isTransitioning = true;
						TweenLite.to(anim, 0.5, { alpha:0 } );
						SettingsKey.playSound(SettingsKey.S_FINISHED_LEVEL);
					}
				}
				else if (Input.check(Key.UP) || Input.check(Key.W) ) //otherwise doors need to have up pressed to activate
				{
					var door:Entity = collide("Door", x, y);
					if (door != null)
					{
						(door as Door).open();
						isTransitioning = true;
						TweenLite.to(anim, 0.5, { alpha:0 } );
						if (world is SubMenuWorld || world is LevelSelectWorld || world is MainMenu)
						{
							(door as Door).close(this);
						}
					}
					
				}
				else
				{
					var aDoor:Entity = collide("Door", x, y);
					if (aDoor != null)
					{
						(aDoor as Door).onPlayerOver();
						if (lastMove == 90 && (world is MainMenu || world is LevelSelectWorld))
						{
							var arr:Array = [];
							world.getType("Tips", arr);
							arr[0].setTip(Tips.DOOR);
						}
						else if (lastMove == 240 && (world is MainMenu || world is LevelSelectWorld))
						{
							var arr2:Array = [];
							world.getType("Tips", arr2);
							arr2[0].setTip(Tips.DOOR_EXTRA);
						}
					}
					else if(Door.DoorHoveringOver != null)
					{
						Door.DoorHoveringOver.onPlayerOut();
					}
				}
			}
			
			
			if (_v.x > maxXSpeed) _v.x = maxXSpeed;
			else if (_v.x < -maxXSpeed) _v.x = -maxXSpeed;
			
			_v.x *= FRICTION;
			x += _v.x;
			GameStats.Pixels += Math.abs(_v.x);
			
			
			var dirtCollided:Array = [];
			collideInto("Dirt", x, y, dirtCollided);
			for (i = 0; i < dirtCollided.length; i++)
			{
				if(y < dirtCollided[i].y - Dirt.DISTANCE_ABOVE_FOR_COLLISION)
					dirtCollided[i].deteriorate();
			}
			
			
			if (x > 640 - 12) { _v.x = 0; x = 640 - 12;}
			if (x < 0)  { _v.x = 0; x = 0;}
			
			
			//dirtCollided = array of dirt that has been collided with. If not empty, there is a collision with this tile
			if (dirtCollided.length != 0 || collide("level", x, y) || collide("FireSpitter", x, y)  || collide("BlueLock", x, y) || collide("RedLock", x, y) || collide("YellowLock",x,y) ) 
			{				
				//Handle Collision here.
				if (FP.sign(_v.x) > 0)
				{
					//moving to the right
					_v.x = 0;
					x = Math.floor(x / 16) * 16 + 16 - width;
				}
				else
				{
					_v.x = 0;
					x = Math.floor(x/16) * 16 + 16
				}
			}
			
			/*if (_v.x > MIN_RUN_SPEED)
				anim.play("right");
			else if (_v.x > 0)
				anim.play("stillright");
			else if (_v.x < -MIN_RUN_SPEED)
				anim.play("left");
			else if (_v.x < 0)
				anim.play("stillleft");*/
			
			
			
			
			

			
			y += _v.y;
			
			
			if (y > 480 - 12) { _v.y = 0;   y = 480-12; }
			if (y < 0) { _v.y = 0;  y = 0;}
			
			
			dirtCollided.length = 0;
			collideInto("Dirt", x, y, dirtCollided);
			for (i = 0; i < dirtCollided.length; i++)
			{
				if (y < dirtCollided[i].y - Dirt.DISTANCE_ABOVE_FOR_COLLISION)
				{
					dirtCollided[i].deteriorate();
				}
			}
			if (dirtCollided.length != 0 || collide("level", x, y) || collide("FireSpitter", x, y)  || collide("BlueLock", x, y) || collide("RedLock", x, y) || collide("YellowLock",x,y) ) 
			{
				//Handle Collision here.
				if (FP.sign(_v.y) > 0)
				{
					//moving to the ground
					y = Math.floor((y) / 16) * 16 + 16 - height;
					_v.y = 0;
					numJumpsLeft = NUM_JUMPS_RESET;
					
					
					/*
					 * Corrected Friction input.
					 */
					if (!Input.check(Key.LEFT) && !Input.check(Key.A) && !Input.check(Key.RIGHT) && !Input.check(Key.D))
					{
						_v.x *= 0.8;
					}
				}
				else
				{
					//moving to the ceiling
					y = Math.floor((y) / 16) * 16 + 16
					_v.y = 0;
				}
				if (_v.x > MIN_RUN_SPEED)
					anim.play("right");
				else if (_v.x > 0 || (anim.currentAnim.indexOf("right") != -1 && _v.x == 0))
					anim.play("stillright");
				else if (_v.x < -MIN_RUN_SPEED)
					anim.play("left");
				else if (_v.x < 0 || (anim.currentAnim.indexOf("left") != -1 && _v.x == 0))
					anim.play("stillleft");
				
					
					
				
				/*if (_v.x > MIN_RUN_SPEED)
					xAnim = "right";
				else if (_v.x > 0)
					xAnim = "stillright";
				else if (_v.x < -MIN_RUN_SPEED)
					xAnim = "left";
				else if (_v.x < 0)
					xAnim = "stillleft";*/
			}
			var ladderz:Ladder = collide("Ladder", x, y) as Ladder;
			if (ladderz)
			{
				if (Input.check(Key.W) || Input.check(Key.UP))
				{
					_v.y = -2.5;
					if (world is LevelWorld || world is TutorialWorld || world is SecretWorld)
					{
						//_v.x += (ladderz.x + 2 - x) / 2;
						x += (ladderz.x + 2 - x) / 2;
						_v.x *= 0.7;
					}
				}
				else if (Input.check(Key.S) || Input.check(Key.DOWN))
				{
					_v.y = 2.5;
				}
				else
				{
					_v.y = 0
				}
				
				if (_v.y > MIN_RUN_SPEED)
					anim.play("down");
				else if (_v.y < -MIN_RUN_SPEED)
					anim.play("up");
				else
					anim.play("stillup");
				
			}
			else //not touching a ladder
			{
				_v.y += GRAVITY;
			}
			
			
			/* OPTIMIZE
			 * if (CAMERA_FOLLOWING)
			{
				FP.camera.x = int(FP.lerp(FP.camera.x, x - 320, 0.2));
				FP.camera.y = int(FP.lerp(FP.camera.y, y - 240, 0.2));
			}
			
			world['backdrop'].x = -int(FP.lerp(-world['backdrop'].x*PARALLAX_SPEED , x - 320, 0.2))*PARALLAX_SPEED;
			world['backdrop'].y = -int(FP.lerp(-world['backdrop'].y*PARALLAX_SPEED, y - 240, 0.2))*PARALLAX_SPEED;
			*/
			
			/*if (x > 640 + 8 || x < -8 || y > 480 + 8)
			{
				respawn();
			}*/
		}

		
		public function respawn():void
		{
			isTransitioning = true;
			
			trace("[Player] respawn();");
			
			var dur:int = LoadSettings.d.transition.retry_duration;
			var sDur:int = LoadSettings.d.transition.retry_stripeDuration;
			if (world is SecretWorld)
			{
				Transition.to(new SubMenuWorld("Menu_Hall of Fame", Level.currentLevel), new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onInComplete:Player.stopTransitioning } )
				return;
			}
			if (world is LevelWorld || world is TutorialWorld)
			{
				//reloadWorld();
				//stopTransitioning();
				Transition.reloadWorld(new StripeFadeOut( { duration:dur, stripeDuration:sDur } ), new StripeFadeIn( { duration:dur, stripeDuration:sDur } ), { onOutComplete:reloadWorld, onInComplete:Player.stopTransitioning } );
			}
			
			if (world is LevelWorld)
			{
				(world as LevelWorld).getHud().stopTime();
				(world as LevelWorld).getHud().resetTime();
			}
			
		}
		
		private function reloadWorld():void
		{
			x = lastSavedLoc.x;
			y = lastSavedLoc.y;
			_v.x = 0;
			_v.x = 0;
			_v.y = 0;
			
			anim.play("still");
			
			
			var i:int = 0;
			
			
			
			if (world == null) {
				//world = FP.world;
				
				trace("WORLD IS NULL> ERROR", FP.world, isTransitioning, Player.isTransitioning);
				anim.alpha = 0;
				TweenLite.to(anim, 0.5, { alpha:1 } );
				//return;
			}
			var s:Array = [];
			FP.world.getType("Dirt", s);
			FP.world.getType("Chest", s);
			FP.world.getType("RedKey", s); //keys will take care of their own locks
			FP.world.getType("YellowKey", s);
			FP.world.getType("BlueKey", s);
			FP.world.getType("PacCrawler", s);
			FP.world.getType("FireSpitter", s);
			FP.world.getType("Fireball", s);
			for (i = 0; i < s.length; i++) { s[i].reset();		}
			
		}
		
		static public function stopTransitioning():void 
		{
			Input.clear();
			trace("[Player] stopTransitioning();");
			isTransitioning = false;
		}
		
	}

}