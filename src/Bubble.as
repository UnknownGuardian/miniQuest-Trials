package  
{
	import com.greensock.TweenLite;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Bubble extends Entity
	{
		[Embed(source="Assets/Graphics/Bubbles/1.png")]private const B1:Class;
		[Embed(source="Assets/Graphics/Bubbles/2.png")]private const B2:Class;
		[Embed(source="Assets/Graphics/Bubbles/3.png")]private const B3:Class;
		[Embed(source="Assets/Graphics/Bubbles/4.png")]private const B4:Class;
		[Embed(source="Assets/Graphics/Bubbles/5.png")]private const B5:Class;
		[Embed(source="Assets/Graphics/Bubbles/6.png")]private const B6:Class;
		[Embed(source="Assets/Graphics/Bubbles/7.png")]private const B7:Class;
		[Embed(source="Assets/Graphics/Bubbles/ESC.png")]private const BESC:Class;
		[Embed(source="Assets/Graphics/Bubbles/M.png")]private const BM:Class;
		[Embed(source="Assets/Graphics/Bubbles/R.png")]private const BR:Class;
		[Embed(source = "Assets/Graphics/Bubbles/sissy.png")]private const Bsissy:Class;
		[Embed(source = "Assets/Graphics/Bubbles/PAR.png")]private const BPAR:Class;
		private var Bub1:Image = new Image(B1);
		private var Bub2:Image = new Image(B2);
		private var Bub3:Image = new Image(B3);
		private var Bub4:Image = new Image(B4);
		private var Bub5:Image = new Image(B5);
		private var Bub6:Image = new Image(B6);
		private var Bub7:Image = new Image(B7);
		private var BubESC:Image = new Image(BESC);
		private var BubM:Image = new Image(BM);
		private var BubR:Image = new Image(BR);
		private var Bubsissy:Image = new Image(Bsissy);
		private var BubPAR:Image = new Image(BPAR);
		
		public var enabled:Boolean = true;
		public function Bubble() 
		{
			layer = -800;
			type = "Bubble";
		}
		
		public function clear():void
		{
			graphic = null;
		}
		
		public function setBubble(s:String):void
		{
			if (!enabled) return;
			if (this["Bub" + s] == graphic)
			{
				return;
			}
			graphic = this["Bub" + s];
		}
		public function place(sx:int, sy:int):void
		{
			if (graphic == null) return;
			x = sx - 30;
			y = sy - (graphic as Image).height;
			if (y > 0) y -= 5;
		}
		
		public function fade():void 
		{
			if (graphic == null) return;
			
			enabled = false;
			TweenLite.to(graphic, 0.5, { alpha:0, onComplete:function():void { visible = false; (graphic as Image).alpha = 1; enabled = true; }} );
		}
		public function fadeIn():void 
		{
			if (graphic == null) return;
			
			
			
			visible = true;
			enabled = false;
			TweenLite.to(graphic, 0.5, { alpha:1, onComplete:function():void { enabled = true} } );
		}
		
	}

}