package org.kaisergames.engine.framework {
	import org.kaisergames.assets.ILogo;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flashx.textLayout.utils.CharacterUtil;

	/**
	 * @author Phimo
	 */
	public class Framework {
		public static var stage : Stage;
		public static var deltaTime : int;
		protected static var initTime : Date;
		
		public static function addEventListener(type : String, func : Function) : void {
			if (Framework[type] == null) 
				Framework[type] = [];
			(Framework[type] as Array).push(func);
		}
		
		public static function removeEventListener(type : String, func : Function) : Boolean {
			if (Framework[type] == null) 
				Framework[type] = [];
			var index : int = (Framework[type] as Array).indexOf(func);
			if (index >= 0) {
				(Framework[type] as Array).splice(index, 1);
				return true;
			}
			return false;
		}
		
		public static function dispatchEvent(e : Event) : void {
			if (Framework[e.type] == null) 
				Framework[e.type] = [];
			var arr : Array = Framework[e.type] as Array;
			for (var i : int = 0; i < arr.length; i++) {
				(arr[i] as Function)(e);
			}
		}
		
		public static function initializeGame(stage : Stage) : void {
			Framework.stage = stage;
			Framework.stage.addEventListener(MouseEvent.CLICK, function(e : MouseEvent) : void {
				Framework.dispatchEvent(e);
			});
			Framework.stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e : KeyboardEvent) : void {
				Framework.dispatchEvent(e);
			});
			Framework.stage.addEventListener(KeyboardEvent.KEY_UP, function(e : KeyboardEvent) : void {
				Framework.dispatchEvent(e);
			});
			Framework.stage.addEventListener(MouseEvent.MOUSE_UP, function(e : MouseEvent) : void {
				Framework.dispatchEvent(e);
			});
			Framework.stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e : MouseEvent) : void {
				Framework.dispatchEvent(e);
			});
			Framework.stage.addEventListener(Event.RESIZE, function(e : Event) : void {
				Framework.dispatchEvent(e);
			});
			Framework.initTime = new Date();
			Framework.stage.addEventListener(Event.ENTER_FRAME, function(e : Event) : void {
				Framework.dispatchEvent(e);
			});
		}
		
		
	}
}
