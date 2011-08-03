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
	import viz.SparkLine;
	import viz.TagCloud;


	public class Piwik_LinksThisMonth extends DataSet {
		
		protected var _apiUrl:String;
		
		protected var _data:DataTable;
		
		public function Piwik_LinksThisMonth(module:Piwik) {
			super('piwik-links', module, 86400, TagCloud, {
				title: module.siteInfo,
				subtitle: 'Incoming Links',
				x: 'website',
				y: 'visitors'
			});
			_apiUrl = module.getAPIUrl( {
				method: 'Referers.getWebsites',
				period: 'month',
				date: 'today'
			});
		}
		
		protected function process(raw:String):DataTable
		{
			var xml:XML = new XML(raw);
			var table:DataTable = new DataTable(['website', 'visitors']);
			for each (var r:XML in xml.row) {
				table.insertRow([String(r.label).replace('www.', ''), String(r.sum_daily_nb_uniq_visitors)]);
			}
			return table;
		}
		
		override public function load():void 
		{
			var ldr:AsyncDataLoader = new AsyncDataLoader([
				['link-stats', _apiUrl, process]
			]);
			ldr.addEventListener(Event.COMPLETE, dataLoaded);
			ldr.run();
		}
		
		protected function dataLoaded(e:Event):void 
		{
			var ldr:AsyncDataLoader = e.target as AsyncDataLoader;
			_data = ldr.getResult('link-stats');
			dispatchEvent(new Event(Event.COMPLETE));
		}

		override public function getData():RawData 
		{
			return _data;
		}
	}
}