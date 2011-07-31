package net.vis4.text.fonts 
{
	import flash.text.AntiAliasType;
	
	/**
	 * ...
	 * @author gka
	 */
	public class VectorFont extends EmbeddedFont
	{
		
		public function VectorFont(props:Object = null)
		{
			if (props == null) props = { };
			if (props.antiAliasType == null) props.antiAliasType = 'advanced';
			super(props);
		}
		
		public override function set size(value:Number):void 
		{
			_size = value;
		}
		
		public function set antiAliasType(value:String):void 
		{
			_antiAliasType = value;
		}
		
		public function set sharpness(value:Number):void 
		{
			_sharpness = value;
		}		
		
	}
	
}