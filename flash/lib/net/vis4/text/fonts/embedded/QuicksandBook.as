package net.vis4.text.fonts.embedded 
{
	import net.vis4.text.fonts.EmbeddedFont;
	import net.vis4.text.fonts.SystemFont;

	
	/**
	 * ...
	 * @author gka
	 */
	public class QuicksandBook extends EmbeddedFont
	{
		
		[Embed(
			source = "Quicksand Book.otf", 
			fontName = "QuicksandBook",                       
			unicodeRange = "U+0020-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183",
			mimeType = "application/x-font-truetype"
		)]
		private var _font:Class;
		

		public function QuicksandBook(props:Object) 
		{
			props.name = 'QuicksandBook';
			props.antiAliasType = 'advanced';
			super(props);
		}
		
	}
	
}
