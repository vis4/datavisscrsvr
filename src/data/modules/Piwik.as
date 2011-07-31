package data.modules 
{
	import data.modules.piwik.Piwik_LinksThisMonth;
	import data.modules.piwik.Piwik_UniqueVisitorsThisMonth;
	import data.modules.piwik.Piwik_VisitorsLast30Days;
	import data.util.AsyncDataLoader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import viz.SparkLine;
	import data.types.DataTable;
	import data.modules.piwik.Piwik_VisitorsLast52Weeks;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Piwik extends DataModule 
	{
		protected var _siteInfo:String;
				
		public function Piwik(config:Object) 
		{
			super(config);
		}
		
		override public function getConfigDesc():Object 
		{
			return {
				'piwik-url': ['http://', 'URL of your Piwik installation'],
				'piwik-token-auth': ['', 'token_auth for Piwik'],
				'piwik-site-id': [1, 'site id']
			};
		}
		
		override public function initialize():void 
		{
			// get information for site, name
			
			var ldr:AsyncDataLoader = new AsyncDataLoader([
				['site-info', urlSiteInfo(), processSiteInfo]
			]);
			ldr.addEventListener(Event.COMPLETE, initializeReady);
			ldr.run();
		}
		
		protected function initializeReady(e:Event):void
		{
			var ldr:AsyncDataLoader = e.target as AsyncDataLoader;
			if (ldr) {
				_siteInfo = ldr.getResult('site-info');
				
				
				/*registerDataset('week-stats', _weekStats, SparkLine, {
					'title': _siteInfo,
					'subtitle': 'Visitors per Week'
					'x': 'date',
					'y': 'visitors'
				});
				
				registerDataset('day-stats', _dayStats, SparkLine, {
					'title': _siteInfo,
					'subtitle': 'Visitors per Week'
					'x': 'date',
					'y': 'visitors'
				});*/
				
				registerDataset(new Piwik_UniqueVisitorsThisMonth(this));
				registerDataset(new Piwik_VisitorsLast52Weeks(this));
				registerDataset(new Piwik_VisitorsLast30Days(this));
				registerDataset(new Piwik_LinksThisMonth(this));
				
				dispatchEvent(new Event(Event.INIT));
			}
		}
		
		override public function loadData():void 
		{
			
		}
		

		
		protected function urlSiteInfo():String
		{
			return getAPIUrl( {
				'method': 'SitesManager.getSiteFromId'
			});
		}
		
		protected function processSiteInfo(raw:String):String
		{
			var xml:XML = new XML(raw);
			return String(xml.row.name);
		}
		
		public function getAPIUrl(params:Object):String
		{
			trace(_config, params);
			var url:String = _config['piwik-url'] + 'index.php?module=API&token_auth=' + _config['piwik-token-auth'] + '&idSite=' + _config['piwik-site-id'] + '&format=xml';
			
			for (var k:String in params) {
				url += '&' + k + '=' + params[k];
			}
			return url;
		}
		
		
		
		protected function dataLoaded(e:Event):void
		{
			
		}
		
		public function get siteInfo():String 
		{
			return _siteInfo;
		}
		
		
	}
}
