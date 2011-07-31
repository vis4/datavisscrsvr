package net.vis4.text.fonts 
{
	import flash.text.AntiAliasType;
	
	/**
	 * ...
	 * @author gka
	 */
	public class EmbeddedFont extends Font
	{
		
		public function EmbeddedFont(props:Object)
		{
			if (props.name == null) props.name = 'Arial';
			if (props.color == null) props.color = 0;
			if (props.size == null) props.size = 12;
			if (props.alpha == null) props.alpha = 1;
			if (props.bold == null) props.bold = false;
			if (props.italic == null) props.italic = false;
			if (props.underline == null) props.underline = false;
			if (props.antiAliasType == null) props.antiAliasType = 'advanced';
			if (props.sharpness == null) props.sharpness = 100;
			if (props.thickness == null) props.thickness = 50;
			if (props.kerning == null) props.kerning = true;
			if (props.letterSpacing == null) props.letterSpacing = 0;
			if (props.leading == null) props.leading = 0;
			
			props.embedded = true;
			
			super(props);
		}
		
	}
	
}