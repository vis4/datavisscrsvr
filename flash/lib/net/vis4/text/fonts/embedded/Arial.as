package net.vis4.text.fonts.embedded 
{
	import net.vis4.text.fonts.EmbeddedFont;
	import net.vis4.text.fonts.SystemFont;

	
	/**
	 * ...
	 * @author gka
	 */
	public class Arial extends EmbeddedFont
	{
		
		[Embed(
			source = "arial.ttf", 
			fontName = "Arial",                       
			unicodeRange = "U+0020-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183",
			mimeType = "application/x-font-truetype"
		)]
		private var _arial:Class;
		

		public function Arial(props:Object) 
		{
			props.name = 'Arial';
			
			super(props);
		}
		
	}
	
}
