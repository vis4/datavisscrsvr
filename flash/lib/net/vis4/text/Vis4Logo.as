package net.vis4.text 
{
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.vis4.text.fonts.EmbeddedFont;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Vis4Logo extends Label
	{
		[Embed(
			source = "c:\\windows\\fonts\\HelveticaThn.TTF", 
			fontName = "HelvThin", 
			unicodeRange = "U+0076,U+0069,U+0073,U+002E,U+0034,U+006E,U+0065,U+0074",
			mimeType = "application/x-font-truetype"
		)]
		private var __font:Class;
		public function Vis4Logo(big:Boolean = true, colored:Boolean = false, knockout:Boolean = false) 
		{
			super('vis4.net', new EmbeddedFont('HelvThin', colored ? 0x990000 : 0xB9B9B9, big ? 60 : 15));
			selectable = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			if (knockout) {
				filters = [new GlowFilter(colored ? 0x990000 : 0xB9B9B9, .4, 8, 8, 2, 1, false, knockout)];
			}
		}
		
		private function exit(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, exit);
			stage.removeEventListener(Event.RESIZE, onResize);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, exit);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		private function onResize(e:Event = null):void 
		{
			x = stage.stageWidth - width - 10;
			y = stage.stageHeight - height - 5;
		}
		
	}
	
}