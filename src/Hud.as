package  
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.utils.getTimer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Hud extends Entity 
	{
		[Embed(source = "Assets/Graphics/HUD/top_bar_HUD.png")]private const HUD:Class;
		[Embed(source = "Assets/Fonts/OCRASTD.OTF", embedAsCFF="false", fontFamily = 'Ocra')]private static const OCRA:Class;
		private var timeLabel:Text;
		private var levelNameLabel:Text;
		private var levelNameLabelPar:Text;
		private var start:int = 0;
		public var running:Boolean = false;
		public var timeToShow:String = "";
		public function Hud(levelName:String = "") 
		{
			x = 640;
			y = 0;
			
			
			
			layer = -500;
			
			timeLabel = new Text("0:00",LoadSettings.d.hud.x_pos,LoadSettings.d.hud.y_pos, { 	font:"Ocra",
													size:LoadSettings.d.hud.font_size,
													color:LoadSettings.d.hud.font_color,
													width: LoadSettings.d.hud.font_width,
													wordWrap: true,
													align: "right" } );
			levelNameLabel = new Text(/*"PAR 999.999"*/levelName,110,10, { 	font:"Ocra",
													size:LoadSettings.d.hud.font_size,
													color:LoadSettings.d.hud.font_color,
													width: 84,
													wordWrap: true,
													align: "center" } );
			levelNameLabelPar = new Text("",110,10, { 	font:"Ocra",
													size:LoadSettings.d.hud.font_size,
													color:LoadSettings.d.hud.font_color,
													width: 84,
													wordWrap: true,
													align: "center" } );
			graphic = new Graphiclist(new Image(HUD), timeLabel, levelNameLabel, levelNameLabelPar);
			graphic.scrollX = graphic.scrollY = LoadSettings.d.hud.scrollXY;
			
			GlobalScore.getAverage((int) (levelName.split(" ")[1]), replaceNameWithPar);
		}
		
		private function replaceNameWithPar(num:Number):void 
		{
			timeToShow = "PAR " + formatTime(num * 1000);
		}
		
		public function startTime():void
		{
			if (running) return;
			start = getTimer();
			running = true;
		}
		
		public override function update():void
		{
			if(running)
				timeLabel.text = formatTime(getTimer() - start);
			if (timeToShow != "" && running && getTimer() - start > 1500)
			{
				levelNameLabelPar.text = timeToShow;
				TweenLite.to(levelNameLabel, 0.5, { alpha:0 } );
				timeToShow = "";
			}
		}
		
		public function stopTime():int
		{
			var tmp:int = getTimer() - start;
			timeLabel.text = "" + tmp;
			running = false
			return tmp;
		}
		
		public static function formatTime(num:int):String
		{
			var temp:int = (num - (int(num / 1000) * 1000));
			if (temp >= 100)
				return int(num / 1000) + "." + temp;
			else if (temp >= 10)
				return int(num / 1000) + ".0" + temp;
			else
				return int(num / 1000) + ".00" + temp;
			
		}
		
		public function resetTime():void
		{
			running = false;
			timeLabel.text = "0:00";
			TweenLite.killTweensOf(levelNameLabel, false);
			levelNameLabel.alpha = 1;
			timeToShow = levelNameLabelPar.text;
			levelNameLabelPar.text = "";
		}
		
		public override function added():void
		{
			TweenMax.to(this, 1, {  x:640 - 204 } );
			FP.stage.addChild(StaticCache.mute);
		}
		
		public function moveOffScreen():void 
		{
			TweenMax.to(this, 1, {  x:640 } );
			StaticCache.mute.moveOffScreen();
		}
	}

}