package data.modules 
{
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import math.Random;
	import viz.VizModule;
	/**
	 * ...
	 * @author gka
	 */
	public class DataModule extends EventDispatcher
	{
		protected var _config:Object;
		
		protected var _datasets:Array;
		
		protected var _initialized:Boolean = false;
		
		public function DataModule(config:Object) 
		{
			if (checkConfig(config)) {
				_config = config;
			} else trace('config check failed');
			
			_datasets = [];
		}
		
		/*
		 * checks a given config object against the 
		 * config descriptor of this moduls
		 */
		protected function checkConfig(config:Object):Boolean 
		{
			var key:String, val:String, tmpl:Object = getConfigDesc();
			for (key in tmpl) {
				if (!config.hasOwnProperty(key)) throw new Error('config key missing: '+ key);
			}
			return true;
		}
		
		/*
		 * returns a dictionary with all needed configuration for
		 * this data module. coulb be something like
		 * 
		 * piwik-url: http://stats.site.com
		 * piwik-auth: js39wjsdj83jmcö04934
		 * 
		 * this method will be used by auto-generated screensaver config
		 * user interface, maybe sometimes
		 */
		public function getConfigDesc():Object
		{
			return { };
		}
		
		/*
		 * the data module may need to initialize itself, eg request some
		 * "static" information from data source
		 */
		public function initialize():void
		{
			
		}
		
		/*
		 * tells the module to load the data 
		 * will dispatch the Event.COMPLETE once the data is loadad and valid
		 * will dispatch IOErrorEvent.NETWORK_ERROR
		 */
		public function loadData():void
		{
			
		}
		
		/**
		 * this function should be used to register a new dataset
		 * 
		 */
		protected function registerDataset(dataset:DataSet):void
		{
			_datasets.push(dataset);
		}
		
		public function get initialized():Boolean 
		{
			return _initialized;
		}
		
		public function get randomDataSet():DataSet
		{
			
			return _datasets[Random.integer(0,_datasets.length-1)];
		}
		
	}
}

