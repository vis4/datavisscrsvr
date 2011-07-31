package net.vis4.color 
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author gka
	 */
	public class ColorBinder 
	{
		private var _target:Object;
		private var _color:PerceptualColor;
		private var _property:String;
		
		
		public function ColorBinder(color:PerceptualColor = null, object:Object = null, property:String = null) 
		{
			if (color && object) bind(color, object, property);
		}
		
		private function bind(color:PerceptualColor, object:Object, property:String = null):void
		{
			if (apply(color, object, property)) {
				_target = object
				_color = color;
				_property = property;
				color.addEventListener(Event.CHANGE, onChange);
			} else {
				trace('bind failed :(', object, property, object[property]);
			}
		}
		
		public function unbind(object:Object):void
		{

		}
		
		private function onChange(evt:Event):void
		{
			var color:PerceptualColor = evt.target as PerceptualColor;
			apply(color, _target, _property);
		}
		
		private function apply(color:PerceptualColor, object:Object, property:String):Boolean
		{
			try {
				if (object is TextField) {
					var fmt:TextFormat = (object as TextField).getTextFormat();
					fmt.color = color.intColor;
					(object as TextField).setTextFormat(fmt);
				} else if (property is String) {
					object[property] = color.intColor;
				} else if (object.color) {
					object.color = color.intColor;
				} else {
					return false;
				}
				return true;
			} catch (e:Error) {
				
			}
			return false;
		}
	}
	
}