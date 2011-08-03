package data.modules.piwik 
{
	/**
	 * ...
	 * @author gka
	 */
	import data.types.DataTable;
	import data.types.RawData;
	import data.modules.DataSet;
	import data.util.AsyncDataLoader;
	import flash.events.Event;
	import viz.BarChart;
	import viz.SparkLine;


	public class Piwik_VisitorsLast30Days extends DataSet {
		
		protected var _apiUrl:String;
		
		protected var _data:DataTable;
		
		public function Piwik_VisitorsLast30Days(module:Piwik) {
			super('piwik-day-stats', module, 86400, BarChart, {
				title: module.siteInfo,
				subtitle: 'visits in the last 30 days',
				x: 'date',
				y: 'visitors'
			});
			_apiUrl = module.getAPIUrl( {
				method: 'VisitsSummary.getVisits',
				period: 'day',
				date: 'last30'
			});
		}
		
		protected function processWeeklyStats(raw:String):DataTable
		{
			var xml:XML = new XML(raw);
			var table:DataTable = new DataTable(['date', 'visitors']);
			for each (var r:XML in xml.result) {
				table.insertRow([String(r.@date), String(r)]);
			}
			return table;
		}
		
		override public function load():void 
		{
			var ldr:AsyncDataLoader = new AsyncDataLoader([
				['day-stats', _apiUrl, processWeeklyStats]
			]);
			ldr.addEventListener(Event.COMPLETE, dataLoaded);
			ldr.run();
		}
		
		protected function dataLoaded(e:Event):void 
		{
			var ldr:AsyncDataLoader = e.target as AsyncDataLoader;
			_data = ldr.getResult('day-stats');
			dispatchEvent(new Event(Event.COMPLETE));
		}

		override public function getData():RawData 
		{
			return _data;
		}
	}
}