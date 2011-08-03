package viz 
{
	import assets.Lato;
	import com.greensock.TweenLite;
	import data.modules.DataModule;
	import data.types.RawData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
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
		
		protected var _vizBounds:Rectangle;
		protected var _baseFontSize:Number;
		
		public function VizModule(stage:Sprite, config:Object) 
		{
			_config = config;
			_stage = stage;
			var p:Number = Math.min(stage.stage.stageWidth * 0.1, stage.stage.stageHeight * 0.1);
			_vizBounds = new Rectangle(p, p, stage.stage.stageWidth - p * 2, stage.stage.stageHeight - p * 2);
			
			_baseFontSize = Math.min(_vizBounds.height, _vizBounds.width) * 0.03; 
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
		
		protected function addTitle(layout:uint = 0):void
		{
			var title_size:Number = _baseFontSize*3, 
				 title_weight:Number = 700, 
				 title_color:uint = 0xffffff, 
				 title_bottom:Boolean = false,
				 title_x:Number = _vizBounds.left,
				 title_y:Number = _vizBounds.top,
				 title_align:String = 'left',
				 subtitle_size:Number = title_size * 0.6, 
				 subtitle_weight:Number = 300, 
				 subtitle_color:uint = 0xffffff, 
				 subtitle_bottom:Boolean = false,
				 subtitle_x:Number = 0,
				 subtitle_y:Number = 0,
				 subtitle_align:String = 'left';	
				 
			if (layout == 0) {
				// top center
				title_x = subtitle_x = _stage.stage.stageWidth * .5;
				title_align = subtitle_align = 'center';
				title_y = _stage.stage.stageHeight * 0.1;
				subtitle_y = title_y + title_size*1.1;
				
			} else if (layout == 1) {
				// bottom
				//title_size = subtitle_size = title_size * 0.8;
				title_x = _vizBounds.left;
				subtitle_x = _vizBounds.right;
				subtitle_align = 'right';
				title_y = subtitle_y = _vizBounds.bottom;
				subtitle_y -= subtitle_size * 0.2;
				title_bottom = subtitle_bottom = true;
			} else if (layout == 2) {
				// top left
				title_x = subtitle_x = _vizBounds.left;
				title_y = _vizBounds.top;
				subtitle_y = title_y + title_size*1.1;
				subtitle_align = 'left';
				
			}
			
			title = new Label(_config.title, new Lato( { weight: title_weight, color: title_color, size: title_size } ), title_align)
				.place(
					title_x, title_y, _stage
				);
			
			subtitle = new Label(_config.subtitle, new Lato( { weight: subtitle_weight, color: subtitle_color, size: subtitle_size } ), subtitle_align)
				.place(
					subtitle_x, subtitle_y, _stage
				);
				
			if (title_bottom) title.y -= title.height;
			if (subtitle_bottom) subtitle.y -= subtitle.height;
			
			_stage.graphics.clear();
			_stage.graphics.lineStyle(0xffffff, .1);
			_stage.graphics.drawRect(_vizBounds.x, _vizBounds.y, _vizBounds.width, _vizBounds.height);
			
		}
		
		protected function addSubtitle(halign:String = 'center', valign:String = 'top'):void
		{
			
		}
		
		protected function clean():void
		{
			while(_stage.numChildren != 0) _stage.removeChildAt(0);
		}
	}

}