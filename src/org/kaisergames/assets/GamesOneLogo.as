package org.kaisergames.assets {
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.utils.setTimeout;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.events.Event;
	import org.kaisergames.engine.animation.Transition;
	import org.kaisergames.engine.animation.BaseSequence;
	import org.kaisergames.engine.animation.FunctionSequence;
	import org.kaisergames.engine.animation.Animator;
	import org.kaisergames.engine.framework.Framework;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * @author Phimo
	 */
	public class GamesOneLogo extends Sprite implements ILogo {
		[Embed(source="/internal/gamesonelogo/gamesone_logo_one.png")]
		protected var one : Class;
		[Embed(source="/internal/gamesonelogo/gamesone_logo_left.png")]
		protected var left : Class;
		[Embed(source="/internal/gamesonelogo/gamesone_logo_right.png")]
		protected var right : Class;
		[Embed(source="/internal/gamesonelogo/soundlogo.mp3")]
		protected var sound : Class;
		
		protected var onFinish : Function;
		
		protected var oneSprite : Sprite;
		protected var leftSprite : Sprite;
		protected var rightSprite : Sprite;
		protected var leftMask : Sprite;
		protected var animator : Animator;
		protected var animationPhase : int = 0;
		protected var _sound : Sound;
		
		public function GamesOneLogo() {
			this._sound = new sound();
			this.oneSprite = new Sprite();
			this.leftSprite = new Sprite();
			this.rightSprite = new Sprite();
			this.leftMask = new Sprite();
			this.animator = new Animator(1000,new Transition(Transition.QUAD,Transition.EASE_OUT));
			this.animator.addSequence(new FunctionSequence(0, 1, this, this.animation, [BaseSequence.VALUE]));
			this.animator.setRepeats(1);
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.CLICK, function(e : MouseEvent) : void {
				navigateToURL(new URLRequest("http://www.games1.com"), "_new");
			});
			Framework.addEventListener(Event.RESIZE, resize);
			Framework.addEventListener(Event.ENTER_FRAME, function(e : Event) : void {update();});
		}
		
		protected function animation(phase : Number) : void {
			if (this.animationPhase == 0) {
				if (phase < 1) {
					var fromX : int = this.oneSprite.width * -1;
					var toX : int = Framework.stage.stageWidth / 2 + 160;
					this.oneSprite.x = fromX + (toX - fromX) * phase;
					var maskWidth : int = (this.oneSprite.x + 50) - this.leftSprite.x;
					if (maskWidth > 0) {
						this.leftMask.graphics.clear();
						this.leftMask.graphics.beginFill(0x000000);
						this.leftMask.graphics.drawRect(0, 0, maskWidth, this.leftSprite.height);
						this.leftMask.graphics.endFill();
					}
				}
				else {
					var toX : int = Framework.stage.stageWidth / 2 + 160;
					this.animationPhase = 1;
					this.animator.setDuration(500);
					this.animator.replay();
					this.leftMask.graphics.clear();
					this.leftMask.graphics.beginFill(0x000000);
					this.leftMask.graphics.drawRect(0, 0, this.leftSprite.width, this.leftSprite.height);
					this.leftMask.graphics.endFill();
					this.oneSprite.x = toX;
				}
			}
			else if (this.animationPhase == 1) {
				if (phase < 1) {
					this.rightSprite.alpha = phase;	
				} else {
					this.rightSprite.alpha = 1;
					this.animator.setDuration(300);
					this.animator.setTransition(new Transition(Transition.QUAD, Transition.EASE_OUT));
					setTimeout(function() : void {animationPhase = 2;animator.replay();}, 2000);
				}
			} else if (this.animationPhase == 2) {
				if (phase < 1) {
					var fromX : int = Framework.stage.stageWidth / 2 + 160;
					var toX : int = Framework.stage.stageWidth / 2 + 230;
					this.oneSprite.x = fromX + (toX - fromX) * phase;
				} else {
					var toX : int = Framework.stage.stageWidth / 2 + 230;
					this.oneSprite.x = toX;
					this.animationPhase = 3;
					this.animator.setDuration(600);
					this.animator.setTransition(new Transition(Transition.CUBIC, Transition.EASE_IN));
					this.animator.replay();
					this.rightSprite.alpha = 0;
				}
			}  else if (this.animationPhase == 3) {
				if (phase < 1) {
					var fromX : int = Framework.stage.stageWidth / 2 + 230;
					var toX : int = this.oneSprite.width * -1;
					this.oneSprite.x = fromX + (toX - fromX) * phase;
					var maskWidth : int = (this.oneSprite.x + 50) - this.leftSprite.x;
					if (maskWidth > 0) {
						this.leftMask.graphics.clear();
						this.leftMask.graphics.beginFill(0x000000);
						this.leftMask.graphics.drawRect(0, 0, maskWidth, this.leftSprite.height);
						this.leftMask.graphics.endFill();
					} else {
						this.leftMask.graphics.clear();
					}
				} else {
					this.leftMask.graphics.clear();
					var toX : int = this.oneSprite.width * -1;
					this.oneSprite.x = toX;
					Framework.stage.removeChild(this);
					this.onFinish();
				}	
			}
		}
		
		public function update() : void {
			this.animator.update();
		}
		
		public function start(onFinish : Function) : void {
			this.onFinish = onFinish;
			this.createContent();
			this.blendIn();
			this._sound.play();
		}
		
		protected function createContent() : void {
			var bData : BitmapData = (new one() as Bitmap).bitmapData;
			this.oneSprite.graphics.clear();
			this.oneSprite.graphics.beginBitmapFill(bData, null, false);
			this.oneSprite.graphics.drawRect(0,0,bData.width, bData.height);
			this.oneSprite.graphics.endFill();
			
			bData = (new left() as Bitmap).bitmapData;
			this.leftSprite.graphics.clear();
			this.leftSprite.graphics.beginBitmapFill(bData, null, false);
			this.leftSprite.graphics.drawRect(0,0,bData.width, bData.height);
			this.leftSprite.graphics.endFill();
			
			bData = (new right() as Bitmap).bitmapData;
			this.rightSprite.graphics.clear();
			this.rightSprite.graphics.beginBitmapFill(bData, null, false);
			this.rightSprite.graphics.drawRect(0,0,bData.width, bData.height);
			this.rightSprite.graphics.endFill();
			
			this.leftSprite.addChild(this.leftMask);
			this.leftSprite.mask = this.leftMask;
			
			this.rightSprite.alpha = 0;
			this.oneSprite.x = this.oneSprite.width * -1;
			
			this.addChild(this.leftSprite);
			this.addChild(this.rightSprite);
			this.addChild(this.oneSprite);
			Framework.stage.addChild(this);
			
			this.resize(null);
		}
		
		protected function resize(e : Event) : void {
			this.graphics.clear();
			var m : Matrix = new Matrix();
			m.createGradientBox(Framework.stage.stageWidth, Framework.stage.stageHeight, Math.PI / 2);
			
			this.graphics.beginGradientFill(GradientType.LINEAR, [0xc8c8c8, 0xffffff], [1,1], [0,50], m);
			this.graphics.drawRect(0,0,Framework.stage.stageWidth,Framework.stage.stageHeight);
			this.graphics.endFill();
			
			this.oneSprite.y   = Framework.stage.stageHeight / 2 - this.oneSprite.height / 2;
			this.leftSprite.y  = Framework.stage.stageHeight / 2 - this.leftSprite.height / 2;
			this.rightSprite.y = Framework.stage.stageHeight / 2 - this.rightSprite.height / 2;
			this.leftSprite.x  = Framework.stage.stageWidth / 2 - 300;
			this.rightSprite.x  = Framework.stage.stageWidth / 2 + 260;
			
			if (this.animationPhase == 1) {
				var toX : int = Framework.stage.stageWidth / 2 + 160;
				this.oneSprite.x = toX;
			}
		}
		
		protected function blendIn() : void {
		}
	}
}
