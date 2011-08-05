package data.modules.piwik 
{
	/**
	 * ...
	 * @author gka
	 */
	import com.adobe.serialization.json.JSON;
	import data.types.DataTable;
	import data.types.RawData;
	import data.modules.DataSet;
	import data.util.AsyncDataLoader;
	import flash.events.Event;
	import viz.HeatMapCalendar;
	import viz.SparkLine;


	public class Piwik_VisitorsLast365Days extends DataSet {
		
		protected var _apiUrl:String;
		
		protected var _data:DataTable;
		
		public function Piwik_VisitorsLast365Days(module:Piwik) {
			super('piwik-day-stats', module, 86400, HeatMapCalendar, {
				title: module.siteInfo,
				subtitle: 'visits per day during the last year',
				x: 'date',
				y: 'visits'
			});
			var today:Date = new Date(), yearago:Date = new Date(today.fullYear - 1, today.month+1, 1);
			_apiUrl = module.getAPIUrl( {
				method: 'VisitsSummary.getVisits',
				period: 'day',
				date: 'last' + Math.round((today.valueOf() - yearago.valueOf()) / 86400000)
			}, 'json');
		}
		
		override public function load():void 
		{
			var ldr:AsyncDataLoader = new AsyncDataLoader([
				['day-stats', _apiUrl, process]
			]);
			ldr.addEventListener(Event.COMPLETE, dataLoaded);
			ldr.run();
		}	
		
		protected function process(raw:String, format:String = 'json'):DataTable
		{
			var table:DataTable = new DataTable(['date', 'visits']);
			
			switch (format) {
				case 'xml':
					var xml:XML = new XML(raw);
					for each (var r:XML in xml.result) {
						table.insertRow([String(r.@date), String(r)]);
					}
					return table;
				case 'json':
					var json:Object = JSON.decode(raw);
					// sort dates 
					var dates:Array = [];
					for (var date:String in json) dates.push(date);
					dates.sort();
					for each (date in dates) {
						table.insertRow([date, json[date]]);
					}
					return table;
				default:
					throw new Error('unknown data format "' + format + '"');
			}
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