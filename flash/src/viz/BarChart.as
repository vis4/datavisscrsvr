package viz 
{
	import assets.Lato;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quart;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import data.types.DataTable;
	import data.types.RawData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import net.vis4.text.fonts.embedded.QuicksandBold;
	import net.vis4.text.fonts.embedded.QuicksandBook;
	import net.vis4.text.fonts.embedded.QuicksandLight;
	import net.vis4.text.Label;
	import viz.util.Path;
	import viz.util.PathSprite;
	/**
	 * ...
	 * @author gka
	 */
	public class BarChart extends VizModule 
	{
		protected var _data:DataTable;
		protected var chart:Sprite;
		protected var path:Path;
		
		
		
		public function BarChart(stage:Sprite, config:Object) 
		{
			super(stage, config);
			if (!_config.hasOwnProperty('padding')) _config.padding = _stage.stage.stageWidth * 0.1;
			chart = new Sprite();
			
			
			
		}
		
		override public function setData(data:RawData):void 
		{
			if (data is DataTable) {
				_data = data as DataTable;
				
			} else {
				throw new Error('BarChart requires a table');
			}
		}

		
		public function barChart():void
		{
			var g:Graphics = chart.graphics;
			g.clear();
			
			var minMax:Array = _data.minMax(_config.y);
			var bw:Number = (_stage.stage.stageWidth - _config.padding * 2) / (_data.length - 1) * 0.75, 
			bb:Number = _vizBounds.bottom;
			var path:Path = new Path();
			_bars = [];
			for (var r:uint = 0; r < _data.length; r++) {
				var val:Number = _data.getCell(r, _config.y);
				
				var p:Point = new Point(
					_vizBounds.x + bw*.5 + (_vizBounds.width-bw) * r / (_data.length - 1),
					_vizBounds.bottom - (_vizBounds.height*0.8) * (val) / (minMax[1])
				
				);
				
				var bar:Bar = new Bar(bw, 0, 0x2894FF)
					.place(p.x, bb, _stage);
				_bars.push(bar);
				TweenLite.to(bar, .4, { delay: r * 0.05, h: bb - p.y } );
				
				if (val == minMax[1] && val) {
					var lbl:Label = getLabel(val, 24).place(p.x, p.y - 40, _stage);
					TweenLite.from(lbl, .7, { alpha: 0, x: lbl.x - 30, blurFilter: { blurX: 24, blurY: 12 }, delay: r * 0.05 }); 
				
				} 
			}
			
			
			
		}
		
		// store all minor labels in here
		private var _labels:Array = [];
		protected var _bars:Array;
		
		protected function getLabel(txt:*, size:Number = 20, align:String = 'center'):Label
		{
			var lbl:Label = new Label(txt, new Lato( { color: 0xffffff, size: size }), align);
			_labels.push(lbl);
			return lbl;
		}
		
				
		override public function fadeIn():void 
		{
			super.fadeIn();
			
			addTitle(2);
			
			
			
			
			_stage.addChild(chart);
			barChart();
			
			
		}
		
		override public function fadeOut():void 
		{
			TweenLite.to(chart, 1.5, { alpha: 0, onComplete: clean } );
			for each (var lbl:Label in _labels) {
				TweenLite.to(lbl, .7, { delay: .5, alpha: 0, x: lbl.x + 40, blurFilter: { blurX: 24, blurY: 12 } }); 
			}
			super.fadeOut();
			
			var c:uint = 0;
			for each (var b:Bar in _bars) {
				TweenLite.to(b, .3, { delay: c++ * 0.02, h: 0, ease: Back.easeIn } );
			}
		}
			
		
	}

}
import flash.display.DisplayObjectContainer;
import flash.display.Graphics;
import flash.display.Sprite;

class Bar extends Sprite {
	
	protected var _w:Number;
	protected var _h:Number;
	protected var _color:uint;
	protected var _alpha:Number;
	
	public function Bar(w:Number, h:Number, color:uint, alpha:Number=1)
	{
		_alpha = alpha;
		_color = color;
		_h = h;
		_w = w;
		draw();
	}
	
	public function place(x:Number, y:Number, cont:DisplayObjectContainer):Bar
	{
		this.x = x;
		this.y = y;
		cont.addChild(this);
		return this;
	}
	
	public function draw():void
	{
		var g:Graphics = graphics;
		g.clear();
		g.beginFill(_color, _alpha);
		if (_h > 0) g.drawRect( -_w * 0.5, -_h, _w, _h);
	}
	
	public function get h():Number 
	{
		return _h;
	}
	
	public function set h(value:Number):void 
	{
		_h = value;
		draw()
	}
	
	public function get w():Number 
	{
		return _w;
	}
	
	public function set w(value:Number):void 
	{
		_w = value;
		draw();
	}
}