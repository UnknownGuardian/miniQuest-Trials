package  
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import skyboy.serialization.JSON;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class LoadSettings 
	{
		[Embed(source = "../bin/LoadSettings.json", mimeType = "application/octet-stream")]private static const LOAD:Class;
		public static var d:Object;
		
		public static var loadExternally:Boolean = false;
		private static var _callback:Function;
		public function LoadSettings() 
		{
			
		}
		public static function load(callback:Function):void
		{
			_callback = callback;
			if (loadExternally)
			{
				var myRequest:URLRequest = new URLRequest("LoadSettings.json");
				var myLoader:URLLoader = new URLLoader();
				myLoader.addEventListener(Event.COMPLETE, onLoad);
				myLoader.load(myRequest);
				trace("[LoadSettings] Loading external JSON file.");
			}
			else
			{
				var rawData:ByteArray = new LOAD();
				var dataString:String = rawData.readUTFBytes(rawData.length);
				d = JSON.decode(dataString);
				if(_callback != null) _callback();
				trace("[LoadSettings] Loading internal JSON file.");
			}
		}
		private static function onLoad(e:Event):void
		{
			trace("[LoadSettings] Loaded external JSON file.");
			d = JSON.decode(e.currentTarget.data);
			if(_callback != null)_callback();
		}
		
	}

}