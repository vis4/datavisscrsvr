package data.util 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * AsyncDataLoader will call a set of requests, process the respons
	 * 
	 * will dispatch Event.COMPLETE once all requests are ready and processed
	 * 
	 * @author gka
	 */
	public class AsyncDataLoader extends EventDispatcher
	{
		protected var _calls:Array;
		
		protected var _results:Object;
		
		/*
		 * calls format:
		 * 
		 * [{
		 * 	'name': 'just a name for this call',
		 * 	'url': 'http://...',
		 * 	'process': [Function to process the data response, returns *],
		 * }]
		 */
		public function AsyncDataLoader(calls:Array) 
		{
			_calls = calls;
			_results = { };
		}
		
		public function run():void 
		{
			var newCalls:Array = [], raw:Array, call:AsyncDataLoader_Call;
			for each (raw in _calls) {
				call = new AsyncDataLoader_Call(raw[0], raw[1], raw[2]);
				call.addEventListener(Event.COMPLETE, callCompleted);
				call.load();
				newCalls.push(call);
			}
			_calls = newCalls;
		}
		
		protected function callCompleted(e:Event):void 
		{
			var call:AsyncDataLoader_Call;
			for each (call in _calls) {
				if (!call.ready) return;
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getResult(id:String):*
		{
			var call:AsyncDataLoader_Call;
			for each (call in _calls) {
				if (call._name == id) {
					return call.result;
				}
			}
			throw new Error('no call found with that id: ' + id);
		}
		
	}

}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;

class AsyncDataLoader_Call extends EventDispatcher {
	
	public var _name:String;
	public var _url:String;
	public var _process:Function;
	public var result: * ;
	public var ready:Boolean = false;
	
	public function AsyncDataLoader_Call(name:String, url:String, process:Function) {
		_process = process;
		_url = url;
		_name = name;
	}
	
	public function load():void 
	{
		trace('calling ' + _url);
		var ldr:URLLoader = new URLLoader();
		ldr.dataFormat = URLLoaderDataFormat.TEXT;
		ldr.addEventListener(Event.COMPLETE, loadComplete);
		/* todo: check for network errors */
		ldr.load(new URLRequest(_url));
	}
	
	protected function loadComplete(e:Event):void 
	{
		var res:String = (e.target as URLLoader).data;
		try {
			result = _process(res);
			ready = true;
			dispatchEvent(new Event(Event.COMPLETE));
		} catch (err:Error) {
			throw(err);
			/* todo: catch process errors */
		}
		
	}
	
}