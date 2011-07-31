package net.vis4.utils 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author gka
	 */
	public class DelayedTask 
	{
		private var 
			_obj:Object,
			_func:Function,
			_args:Array;
			private var t:Timer;
		/*
		 * 
		 *  new DelayedTask(100, Math, round, 4.5);
		 * 
		 *  parameters:
		 *  - delay
		 *  - object
		 *  - function
		 *  - parameters
		 */
		public function DelayedTask(... arguments) 
		{
			
			if (arguments.length < 3) {
				trace('DelayedTask-Error: missing arguments');
			} else {
				if (arguments[0] is uint || arguments[0] is Number) {
					if (arguments[1] is Object) {
						if (arguments[2] is Function) {
							_obj = arguments[1];
							_func = arguments[2];
							_args = [];
							if (arguments.length > 3) {
								for (var i:uint = 3; i < arguments.length; i++) {
									_args.push(arguments[i]);
								}
							} 
							t = new Timer(arguments[0] as Number, 1);
							t.addEventListener(TimerEvent.TIMER, exec);
							t.start();
						} else trace('DelayedTask-Error: third argument should be a function');
					} else trace('DelayedTask-Error: seconds argument should be an object (this-context of function)');
				} else trace('DelayedTask-Error: first argument should be a number (milliseconds delay)');
			}
			
		}
		
		private function exec(e:Event = null):void
		{
			_func.apply(_obj, _args);
		}
		
		public function cancel():void
		{
			if (t != null) t.stop();
		}
		
	}
	
}