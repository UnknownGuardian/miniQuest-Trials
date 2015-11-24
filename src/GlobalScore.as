package  
{
	import com.profusiongames.net.Kong;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.Security;
	import flash.utils.getTimer;
	import org.flashdevelop.utils.FlashConnect;
	import skyboy.serialization.JSON;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class GlobalScore 
	{
		private static var _callback:Function;
		private static var _hallCallback:Function;
		private static var _cache:Array = [];
		private static var _hallCache:Array = [0,""];
		public function GlobalScore() 
		{
			
		}
		
		
		public static function init():void
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			Security.loadPolicyFile("http://www.profusiongames.com/games/miniQuestTrials/crossdomain.xml");
		}
		
		
		public static function postScore(level:int, score:Number):void
		{
			if(Kong.stats) Kong.stats.submit("Level_"+level, score);
			trace("Posting score: level", level, "      score", score);
			//FlashConnect.trace("Posting score: level"+ level+ "      score"+ score);
			var url:String = "http://www.profusiongames.com/games/miniQuestTrials/scores.php";
			//var url:String = "http://localhost/scores.php";
			var request:URLRequest = new URLRequest(url);
			var requestVars:URLVariables = new URLVariables();
				requestVars.level = level;
				requestVars.time = score;
				request.data = requestVars;
				request.method = URLRequestMethod.POST;
		 
			var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			try {
				urlLoader.load(request);
			} catch (e:Error) {
				//FlashConnect.trace("Error:"+ e);
				trace(e);
			}
		}
		public static function getAverage(num:int, callback:Function):void
		{
			//hit up the cache first
			if (_cache.length == 0)
			{
				for (var i:int = 0; i <= 30; i++)
				{
					_cache[i] = -1;
				}
			}
			else if (_cache[num] != -1)//the level average was loaded at least once
			{
				if (getTimer() - _cache[0] < 240000) //the cache isn't too old, use cache and exit
				{
					callback(_cache[num]);
					return;
				}
			}
			
			
			
			
			_callback = callback;
			var request:URLRequest = new URLRequest();
			request.url = "http://www.profusiongames.com/games/miniQuestTrials/scores.php?level=" + num;
			//request.url = "http://localhost/scores.php?level=" + num;
			request.method = URLRequestMethod.GET;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		 
			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				trace("Unable to load URL");
			}
		}
		
		public static function getLotsOfAverages(nums:Array, callback:Function):void
		{
			//hit up the cache first
			if (_cache.length == 0)
			{
				for (var i:int = 0; i <= 30; i++)
				{
					_cache[i] = -1;
				}
			}			
			
			trace("Loading Data for ", nums);
			
			_callback = callback;
			var request:URLRequest = new URLRequest();
			request.url = "http://www.profusiongames.com/games/miniQuestTrials/scores.php?s=1&levels=" + nums.join(",");
			//request.url = "http://localhost/scores.php?level=" + num;
			request.method = URLRequestMethod.GET;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, averagesloaderCompleteHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		 
			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				trace("Unable to load URL");
			}
		}
		
		public static function invalidateHallOfFameCache():void
		{
			_hallCache[0] = -99999999;
		}
		
		public static function getHallOfFameUsers(callback:Function):void
		{
			if (_hallCache[1] != "" && getTimer() - _hallCache[0] < 240000)
			{
				callback(_hallCache[1]);
				return;
			}
			
			
			_hallCallback = callback;
			var request:URLRequest = new URLRequest();
			request.url = "http://www.profusiongames.com/games/miniQuestTrials/scores.php?users=1";
			//request.url = "http://localhost/scores.php?level=" + num;
			request.method = URLRequestMethod.GET;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, hallOfFameCompleteHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		 
			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				trace("Unable to load URL");
			}
		}
		
		public static function postUsername(_name:String, extras:String):void
		{
			var url:String = "http://www.profusiongames.com/games/miniQuestTrials/scores.php";
			//var url:String = "http://localhost/scores.php";
			var request:URLRequest = new URLRequest(url);
			var requestVars:URLVariables = new URLVariables();
				requestVars.user = _name;
				requestVars.extra = extras;
				request.data = requestVars;
				request.method = URLRequestMethod.POST;
		 
			var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				urlLoader.addEventListener(Event.COMPLETE, postLoaderCompleteHandler);
				urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			try {
				urlLoader.load(request);
			} catch (e:Error) {
				trace(e);
			}
		}
			
		static public function hallOfFameCompleteHandler(e:Event):void 
		{
			trace("Got Hall Of Fame Data", e.target.data);
			//FlashConnect.trace("Got Hall Of Fame Data", e.target.data);
			if (e.target.data == "")
			{
				_hallCallback([]);
				_hallCache[1] = [];
			}
			else
			{
				var data:* = JSON.decode(e.target.data)
				_hallCallback(data);
				_hallCache[1] = data;
			}
			_hallCache[0] = getTimer();
		}
		
		static private function averagesloaderCompleteHandler(e:Event):void 
		{
			trace("Got Averages Level Data", e.target.data);
			if (e.target.data == "") return;
			var obj:Object = JSON.decode(e.target.data);
			_cache[0] = getTimer();
			for (var s:String in obj) {
				_cache[int(s)] = obj[s];
			}
			try {
				_callback();
			}
			catch (e:Error) {
				_cache[0] = 0;
			}
		}
		
		
		private static function loaderCompleteHandler(e:Event):void
		{
			trace("Got Level Data", e.target.data);
			if (e.target.data == "") return;
			var obj:Object = JSON.decode(e.target.data);
			_cache[0] = getTimer();
			_cache[obj.level] = obj.average;
			_callback(obj.average);
		}
		private static function postLoaderCompleteHandler(e:Event):void
		{
			//FlashConnect.trace("Got POST data", e.target.data);
		}
		private static function httpStatusHandler (e:Event):void
		{
			//FlashConnect.trace("httpStatusHandler:" + e);
		}
		private static function securityErrorHandler (e:Event):void
		{
			//FlashConnect.trace("securityErrorHandler:" + e);
		}
		private static function ioErrorHandler(e:Event):void
		{
			//FlashConnect.trace("ioErrorHandler: " + e);
		}
		
		public static function pullAverageFromCache(num:int):Number
		{
			if (_cache.length == 0)
			{
				for (var i:int = 0; i <= 30; i++)
				{
					_cache[i] = -1;
				}
			}
			return _cache[num];
		}
		
	}

}