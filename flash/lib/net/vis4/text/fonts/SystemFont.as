package net.vis4.text.fonts 
{
	
	/**
	 * class for build in system fonts
	 * @author gka
	 */
	public class SystemFont extends Font
	{
		
		public function SystemFont(props:Object = null) 
		{
			if (props == null) props = { };
			props.embedded = false;
			if (!props.hasOwnProperty('size')) props.size = 12;
			if (!props.hasOwnProperty('color')) props.color = 0x000000;
			if (!props.hasOwnProperty('alpha')) props.alpha = 1;
			if (!props.hasOwnProperty('letterSpacing')) props.letterSpacing = 0;
			super(props);
		}
		
		override public function set size(value:Number):void 
		{
			_size = value;
		}
		
		public function set bold(value:Boolean):void 
		{
			_bold = value;
		}
		
		public function set italic(value:Boolean):void 
		{
			_italic = value;
		}		
	}
	
}