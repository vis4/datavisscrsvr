package data.modules.piwik 
{
	/**
	 * ...
	 * @author gka
	 */
	import data.types.DataTable;
	import data.types.RawData;
	import data.modules.DataSet;
	import data.types.SNumber;
	import data.util.AsyncDataLoader;
	import flash.events.Event;
	import viz.SingleNumber;
	import viz.SparkLine;


	public class Piwik_UniqueVisitorsThisMonth extends DataSet {
		
		protected var _apiUrl:String;
		
		protected var _data:RawData;
		
		public function Piwik_UniqueVisitorsThisMonth(module:Piwik) {
			super('piwik-month', module, 86400, SingleNumber, {
				title: module.siteInfo,
				subtitle: 'Unique Visitors This Month'
			});
			_apiUrl = module.getAPIUrl( {
				method: 'VisitsSummary.getUniqueVisitors',
				period: 'month',
				date: 'today'
			});
		}
		
		override public function load():void 
		{
			var ldr:AsyncDataLoader = new AsyncDataLoader([
				['unique-visitors-month', _apiUrl, process]
			]);
			ldr.addEventListener(Event.COMPLETE, dataLoaded);
			ldr.run();
		}
		
		protected function process(raw:String):SNumber
		{
			var xml:XML = new XML(raw);
			trace('out: ' + xml, String(xml));
			return new SNumber(Number(xml));
		}
		
		protected function dataLoaded(e:Event):void 
		{
			var ldr:AsyncDataLoader = e.target as AsyncDataLoader;
			_data = ldr.getResult('unique-visitors-month');
			dispatchEvent(new Event(Event.COMPLETE));
		}

		override public function getData():RawData 
		{
			return _data;
		}
	}
}