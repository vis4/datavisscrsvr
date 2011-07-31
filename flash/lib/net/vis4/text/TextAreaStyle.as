package net.vis4.text 
{
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import net.vis4.text.fonts.Font;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author gka
	 */
	public class TextAreaStyle
	{
		protected var _styles:Dictionary;
		
		public function TextAreaStyle() 
		{
			_styles = new Dictionary();
		}
		
		public function addStyle(tagName:String, font:Font, align:String):void
		{
			var cn:String = '';
			for each (var f:Font in _styles) {
				if (cn == '') cn = getQualifiedClassName(f);
				else if (cn != getQualifiedClassName(f)) throw new Error('TextAreaStyle-Error: Fonts must be of the same class.');
			}
			_styles[tagName] = font;
		}
		
		public function formatTextField(tf:TextField):void
		{
			
		}
		
	}
	
}