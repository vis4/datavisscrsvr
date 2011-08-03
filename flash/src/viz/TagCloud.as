package viz 
{
	import com.greensock.TweenLite;
	import data.types.DataTable;
	import data.types.RawData;
	import flash.display.Sprite;
	import math.Random;
	import net.vis4.text.fonts.embedded.QuicksandBook;
	import net.vis4.text.Label;
	/**
	 * ...
	 * @author gka
	 */
	public class TagCloud extends VizModule 
	{
		protected var _list:DataTable;
		
		override public function setData(data:RawData):void 
		{
			_list = data as DataTable;
		}
		
		override public function fadeIn():void 
		{
			addTitle();
			addSubtitle();
			super.fadeIn();
			
			var minMax:Array = _list.minMax('visitors');
			
			var y:Number = _stage.stage.stageHeight * .25;
			for (var r:uint = 0; r < _list.length; r++) {
				var l:Label = new Label(
					_list.get(r, 'website'),
					new QuicksandBook( { 
						color: 0xffffff, 
						size: Math.sqrt(_list.get(r, 'visitors')/minMax[1])*90
					}), 'center'
				).place(_stage.stage.stageWidth * .5, y, _stage);
				
				TweenLite.from(l, .6, { delay: 1.5 + r*0.11, x: l.x - Random.integer( -100, 100), blurFilter: { blurX: 30, blurY: 14 }, alpha: 0  } );
				y += l.height*1.05;
			}
		}
		
		override public function fadeOut():void 
		{
			super.fadeOut();
			clean();
		} 
		
	}

}