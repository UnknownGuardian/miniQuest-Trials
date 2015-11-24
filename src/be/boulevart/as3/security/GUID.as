package be.boulevart.as3.security { 
	/**
	* Creates a new genuine unique identifier string.
	* @authors Sven Dens - http://www.svendens.be
	* @version 0.1
	*/
	import flash.system.System;
	
	public class GUID {
		/**
		* Variables
		* @exclude
		*/
		protected static var counter:Number = 0;
	
		/**
		* Creates a new Genuine Unique IDentifier. :)
		*/
		public static function create():String {
			var d:Date = new Date();
			var id1:Number = d.getTime();
			var id2:Number = Math.random()*Number.MAX_VALUE;
			var id3:String = "";
			if(System.capabilities != undefined) {
				if(System.capabilities.serverString != undefined) {
					id3 = System.capabilities.serverString;
				}
			}
			return SHA1.calculate(id1+id3+id2+counter++);
		}
	}
}