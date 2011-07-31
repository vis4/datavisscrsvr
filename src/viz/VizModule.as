package viz 
{
	import com.greensock.TweenLite;
	import data.modules.DataModule;
	import data.types.RawData;
	import flash.display.Sprite;
	import net.vis4.text.fonts.embedded.QuicksandBook;
	import net.vis4.text.fonts.embedded.QuicksandLight;
	import net.vis4.text.Label;
	/**
	 * ...
	 * @author gka
	 */
	public class VizModule 
	{
		protected var _stage:Sprite;
		protected var _config:Object;
		
		protected var title:Label;
		protected var subtitle:Label;
		
		
		public function VizModule(stage:Sprite, config:Object) 
		{
			_config = config;
			_stage = stage;
			
		}
		
		public function foo():void
		{
			trace('bar'); 
		}
		
		/*
		 * binds this visualization to a specific dataset
		 */
		public function setData(data:RawData):void
		{
			
		}
		
		/*
		 * fadeIn
		 * 
		 * 
		 * 
		 * fadeOut
		 * 
		 */
		
		public function fadeIn():void
		{
			if (title) TweenLite.from(title, 1, { alpha: 0 } );
			if (subtitle) TweenLite.from(subtitle, 1, { alpha: 0, delay: .8 } );
		}
		
		public function fadeOut():void
		{
			if (title) TweenLite.to(title, 1, { alpha: 0 } );
			if (subtitle) TweenLite.to(subtitle, 1, { alpha: 0 } );
			
		}
		
		protected function addTitle(halign:String = 'center', valign:String = 'top'):void
		{
			title = new Label(_config.title, new QuicksandBook( { color: 0xffffff, size: 60 } ), halign)
				.place(
					_stage.stage.stageWidth * (halign == 'center' ? 0.5 : halign == 'left' ? 0.1 : 0.9), 
					_stage.stage.stageHeight * (valign == 'top' ? 0.1 : 0.8), 
					_stage
				);
		}
		
		protected function addSubtitle(halign:String = 'center', valign:String = 'top'):void
		{
			subtitle = new Label(_config.subtitle, new QuicksandLight( { color: 0xffffff, size: 40 } ), halign)
				.place(
					_stage.stage.stageWidth * (halign == 'center' ? 0.5 : halign == 'left' ? 0.1 : 0.9), 
					_stage.stage.stageHeight * (valign == 'top' ? 0.1 : 0.8) + title.height, 
					_stage
				);
		}
		
		protected function clean():void
		{
			while(_stage.numChildren != 0) _stage.removeChildAt(0);
		}
	}

}