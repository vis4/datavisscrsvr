package data.types 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * holds data
	 * 
	 * important: some datasets might contain live data that's 
	 * being updated. all updates must be made in-place because some
	 * classes will store references to the instances
	 * 
	 * and, don't forget to call hasChanged(), so the visualizations
	 * will know that they need to updatecd
	 * 
	 * @author gka
	 */
	public class RawData extends EventDispatcher
	{
		
		public function RawData() 
		{
			
		}
		
		protected function hasChanged():void 
		{
			dispatchEvent(new Event(Event.CHANGE));
		}

	}

}