package data.modules.piwik 
{
	/**
	 * ...
	 * @author gka
	 */
	import data.types.DataTable;
	import data.types.RawData;
	import data.modules.DataSet;
	import data.modules.Piwik;
	import data.util.AsyncDataLoader;
	import flash.events.Event;
	import viz.SparkLine;


	public class Piwik_VisitorsLast52Weeks extends DataSet {
		
		protected var _apiUrl:String;
		
		protected var _data:DataTable;
		
		public function Piwik_VisitorsLast52Weeks(module:Piwik) {
			super('piwik-week-stats', module, 86400, SparkLine, {
				title: module.siteInfo,
				subtitle: 'Visitors per Week',
				x: 'date',
				y: 'visitors'
			});
			_apiUrl = module.getAPIUrl( {
				method: 'VisitsSummary.getVisits',
				period: 'week',
				date: 'last52'
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
				['week-stats', _apiUrl, processWeeklyStats]
			]);
			ldr.addEventListener(Event.COMPLETE, dataLoaded);
			ldr.run();
		}
		
		protected function dataLoaded(e:Event):void 
		{
			var ldr:AsyncDataLoader = e.target as AsyncDataLoader;
			_data = ldr.getResult('week-stats');
			dispatchEvent(new Event(Event.COMPLETE));
		}

		override public function getData():RawData 
		{
			return _data;
		}
	}
}