package data.types 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author gka
	 */
	public class SNumber extends RawData 
	{
		protected var _value:Number;
		
		public function SNumber(val:Number) 
		{
			_value = val;
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(value:Number):void 
		{
			_value = value;
			hasChanged();
		}
		
		
	}

}
