package data.modules 
{
	import data.types.RawData;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author gka
	 */
	public class DataSet extends EventDispatcher
	{
		
		protected var _name:String;
		protected var _viz:Class;
		protected var _config:Object;
		protected var _module:DataModule;
		protected var _updateEvery:Number;
		protected var _lastUpdated:Number = 0;
		
		/**
		 * 
		 * @param	name 		unique identifier for this dataset
		 * @param	module 	reference to the module
		 * @param	updateEvery Number of seconds the data should be refreshed
		 * @param	viz		class reference of the preferred viz module
		 * @param	config	configuration that will be passed to the viz module
		 */
		public function DataSet(name:String, module:DataModule, updateEvery:Number, viz:Class, config:Object) {
			_updateEvery = updateEvery;
			
			_module = module;
			_config = config;
			_viz = viz;
			_name = name;
		}
		
		/*
		 * 
		 */
		public function load():void
		{
			
		}
		
		/*
		 * this will be called right before this dataset is going
		 * to be displayed 
		 */
		public function update():void
		{
			
		}
		
		public function getData():RawData
		{
			return null;
		}
		
		public function get config():Object 
		{
			return _config;
		}
		
		public function get viz():Class 
		{
			return _viz;
		}
		
		public function get name():String 
		{
			return _name;
		}
			
		}

}

