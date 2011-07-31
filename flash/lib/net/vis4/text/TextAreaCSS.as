package net.vis4.text 
{
	import com.actionscript_flash_guru.fireflashlite.Console;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TextAreaCSS extends TextArea
	{
		
		public function TextAreaCSS(txt:String, w:Number, h:Number, css:String, fonts:Array) 
		{
			multiline = true;
			var s:StyleSheet = new StyleSheet();
			s.parseCSS(css);
			
			styleSheet = s;
				
			super(_parseText(txt), w, h, fonts[0]);
			
			if (h <= 0) {
			
				autoSize = TextFieldAutoSize.LEFT;
			
				var h:Number = textHeight;
				autoSize = TextFieldAutoSize.NONE;
				height = h + 10;
			}
			
		}
		
		
		
		override public function set htmlText(value:String):void 
		{
			super.htmlText = _parseText(value);
			var h:Number = textHeight;
			autoSize = TextFieldAutoSize.NONE;
			height = h + 10;
		}
		
	}
	
}