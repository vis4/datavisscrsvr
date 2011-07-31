package net.vis4.text.fonts.system 
{
	import net.vis4.text.fonts.SystemFont;

	
	/**
	 * ...
	 * @author gka
	 */
	public class Verdana extends SystemFont
	{
		
		
		public function Verdana(props:Object = null) 
		{
			if (props == null) props = { };
			
			props.name = 'Verdana, Helvetica, "_sans"';
			super(props);
		}
		
	}
	
}
