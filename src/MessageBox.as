package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class MessageBox extends Entity 
	{
		private var _text:Text;
		private var _lastMessage:int = 0;
		public function MessageBox() 
		{
			_text = new Text("", 0, 450,{align:"center", width:640});
			graphic = _text;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
		}
		
		
		public function showMessage(t:String):void
		{
			if (_text.text != t)
			{
				_text.text = t;
			}
			_lastMessage = 0;
		}
		
		override public function update():void
		{
			_lastMessage++;
			if (_lastMessage == 180)
			{
				_text.text = "";
			}
		}
		
	}

}