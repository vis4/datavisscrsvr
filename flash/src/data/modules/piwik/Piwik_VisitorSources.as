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
	import viz.SparkLine;
	import viz.TagCloud;
	import viz.TreemapModule;


	public class Piwik_VisitorSources extends DataSet 
	{
		

		
		public function Piwik_VisitorSources(module:Piwik) {
			super('piwik-links', module, 86400, TreemapModule, {
				title: module.siteInfo,
				subtitle: 'types of incoming vistors'		
			});
			
			
		}
		
		protected function process(raw:String, format:String = 'xml'):DataTable
		{
			var table:DataTable = new DataTable(['website', 'visitors']);
			
			switch (format) {
				case 'xml':
					var xml:XML = new XML(raw);
					for each (var r:XML in xml.row) {
						table.insertRow([String(r.label).replace('www.', ''), String(r.sum_daily_nb_uniq_visitors)]);
					}
					return table;
				case 'json':
					var json:Object = JSON.decode(raw);
					for (var date:String in json) {
						table.insertRow(date.replace('www.', ''), json[date]);
					}
					return table;
				default:
					throw new Error('unknown data format "' + format + '"');
			}
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