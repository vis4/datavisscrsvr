package ajax 
{
	import flash.external.ExternalInterface;
	import math.Random;
	/**
	 * 
	 * wrapper for js ajax request using jquery and jsonp
	 * needed to get around those crossdomain limitations
	 * 
	 * @author gka
	 */
	public class JSONP 
	{

		public static var initialized:Boolean = false;
		
		public static var calls:Array = [];
		
		public static function receive(callId:String, response:Object):void
		{
			// look for the right call instance
			
		}
		
		public static function initialize():void
		{
			if (ExternalInterface.available) {
				ExternalInterface.addCallback('jsonp_send', receive);
			} else {
				trace('this would not work');
			}
			initialized = true;
		}
		
		protected var _callId:String;
		protected var _url:String;
		
		public function JSONP(url:String) 
		{
			_url = url;
			_callId = 'call' + Random.integer(1000000, 9999999);
			
			if (ExternalInterface.available) {
				ExternalInterface.call
			}
		}
		
	}

}