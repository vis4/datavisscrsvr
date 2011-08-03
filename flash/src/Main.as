package 
{
	import assets.Lato;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import math.Random;
	import net.vis4.text.Label;
	import test.PathTest;
	import test.PiwikTest;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			try {
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			} catch (e:Error) {
				
			}
			
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			TweenPlugin.activate([BlurFilterPlugin]);
			
			Random.randomSeed();
			
			stage.scaleMode = 'noScale';
			stage.align = 'TL';
			
			new PiwikTest(this).run();
			//new PathTest(this).run();
		}
		
	}
	
}