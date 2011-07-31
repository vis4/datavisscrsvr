package net.vis4.text 
{
	import flash.filters.DropShadowFilter;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import net.vis4.text.fonts.Font;
	import net.vis4.text.Label;
	
	/** <script
	 * ...
	 * @author gka
	 */
	public class TextArea extends Label
	{
		
		public function TextArea(txt:String, w:Number, h:Number, font:Font, align:String = 'left') 
		{
			super(txt, font, align);
			autoSize = TextFieldAutoSize.NONE;
			width = w;
			height = h;
			
			multiline = true;
			embedFonts = false;
			//border = true;
			//borderColor = 0xcccccc;
			//background = true;
			//backgroundColor = 0xf7f7f7;
			//filters = [new DropShadowFilter(0, 45, 0, .3, 4, 4, 1, 3)];
			//type = TextFieldType.INPUT;
			
		}
		
	}
	
}