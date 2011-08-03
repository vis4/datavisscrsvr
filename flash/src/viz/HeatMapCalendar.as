package viz 
{
	import assets.Lato;
	import data.types.DataTable;
	import data.types.RawData;
	import flash.display.Sprite;
	import flash.ui.ContextMenuItem;
	import math.Random;
	import net.vis4.color.Color;
	import net.vis4.color.ColorScale;
	import net.vis4.text.fonts.embedded.QuicksandBold;
	import net.vis4.text.fonts.embedded.QuicksandBook;
	import net.vis4.text.fonts.embedded.QuicksandLight;
	import net.vis4.text.Label;
	import net.vis4.utils.DelayedTask;
	/**
	 * ...
	 * @author gka
	 */
	public class HeatMapCalendar extends VizModule
	{
		
		public function HeatMapCalendar(stage:Sprite, config:Object) 
		{
			super(stage, config);
			
		}
		
		protected var _data:DataTable;
		protected var _from:Date;
		protected var _to:Date;
		protected var _months:uint;
		protected var dateObj:Object;
		protected var mm:Array;
		protected var _cscale:ColorScale;
		public static var _zeroCol:uint;
		protected var _calMonths:Array;
		
		override public function setData(data:RawData):void 
		{
			_data = data as DataTable;
			dateObj = { };
			mm = _data.minMax('visits'); 
			for (var i:int = 0; i < _data.length; i++) {
				dateObj[_data.get(i, 'date')] = _data.get(i, 'visits');
			}
			
			_from = str2date(_data.get(0, 'date'));
			
			_to = str2date(_data.get(_data.length - 1, 'date'));
			// spli
			
			_months = _to.fullYear * 12 + _to.month - _from.fullYear * 12 - _from.month+1;
			
			var hue:Number = Random.integer(0, 360);
			_zeroCol = Color.fromHSL(hue, .02, .06)._int;
		var linscale:ColorScale = new ColorScale([_zeroCol, Color.fromHSL(hue, .9, .95)._int], [0, 1]);
			
			/* compute percentile color scale */
			var values:Array = _data.getColAsNumbers('visits');
			values.sort(Array.NUMERIC);
			var psRatios:Array = [], psColors:Array = [];
			
			var steps:uint = 10, perc:Array = [];
			for (i = 0; i < values.length; i += values.length / steps) perc.push(i);
			var s:uint = 0;
			for each (i in perc) {
				psRatios.push(values[i]/mm[1]);
				psColors.push(linscale.getIntColor(s++ / steps));
			}
			
			psRatios.push(1);
			psColors.push(linscale.getIntColor(1));
			var percScale:ColorScale = new ColorScale(psColors, psRatios);
			trace(values.length, perc, psColors, psRatios);
			_cscale = percScale;
		}
		
		override public function fadeIn():void 
		{
			addTitle(1);
			
			super.fadeIn();
		
			var monthPerRow:uint;
			// find number of months per row
			if (_months < 4) monthPerRow = _months;
			else if (_months == 12) monthPerRow = 6;
			else monthPerRow = Math.ceil(_months * 0.33);
			
			var monthPerCol:uint = Math.ceil(_months / monthPerRow);
			
			trace('month per row', monthPerRow, _months);
			
			var _tw:Number = _vizBounds.width;
			var bw:uint = Math.min(_tw / (monthPerRow * 8), _vizBounds.height / (monthPerCol * 10));
			var bh:uint = bw + 1;
			
			var _cm:uint = _from.getMonth(), _cy:uint = _from.getFullYear();
			var c:uint = 0, r:uint = 0, cnt:uint =0;
			
			var monthNames:Array = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			_calMonths = [];
			
			while (_cy < _to.getFullYear() || _cm < _from.getMonth()) {
				trace(_cy, _cm);
				var monthSprite:Sprite = new Sprite();
				_calMonths.push(new HeatMapCalendar_Month(_cy, _cm, dateObj, mm[1], _cscale)
					.render(monthSprite, bw, bh, Math.pow(cnt++*0.3,0.8)));
				monthSprite.x = (_stage.stage.stageWidth - monthPerRow*bw*8)*.5 + c * (bw * 8);
				monthSprite.y = _stage.stage.stageHeight * 0.14 + r * (bh * 10)+bh*2;
				_stage.addChild(monthSprite);
			
				new Label(_cm == 0 ? _cy : monthNames[_cm], new Lato( { size: _baseFontSize, color: 0xdddddd } ))
				.place(0, -bh*2, monthSprite);
				c++;
				if (c >= monthPerRow) {
					c = 0;
					r += 1;
				}
				_cm++;
				if (_cm == 12) {
					_cm = 0;
					_cy ++;
				}
			}
		}
		
		override public function fadeOut():void 
		{
			super.fadeOut();
			for each (var m:HeatMapCalendar_Month in _calMonths) {
				m.fadeOut();
			}
			new DelayedTask(1500, this, clean);
		}
		
		public static function str2date(date:String):Date
		{
			var p:Array = date.split('-');
			return new Date(p[0], p[1] - 1, p[2]);;
		}		
		public static function date2str(date:Date):String
		{
			return date.fullYear + '-' + (date.month < 9?'0':'') + (date.month + 1) + '-' + (date.date < 10 ? '0' : '') + date.date;
		}
		
	}

}
import com.greensock.easing.Expo;
import com.greensock.TweenLite;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import math.Random;
import net.vis4.color.ColorScale;
import viz.HeatMapCalendar;

class HeatMapCalendar_Month {
	
	protected var _year:int;
	protected var _month:int;
	protected var _data:Object;
	protected var _cscale:ColorScale;
	protected var _max:Number;
	
	public function HeatMapCalendar_Month(year:int, month:int, data:Object, max:Number, cscale:ColorScale) {
		_max = max;
		_cscale = cscale;
		_data = data;
		_month = month;
		_year = year;
	}
	
	public static var WEEK_START_DAY:uint = 1; // monday
	protected var _boxes:Array = [];
	
	public function render(spr:Sprite, boxWidth:Number, boxHeight:Number, delay:Number = 0):HeatMapCalendar_Month
	{
		var date:Date = new Date(_year, _month, 1);
		var r:uint = 0, c:uint, i:uint = 0, col:uint, v:Number;
		
		while (date.month == _month) {
			c = (date.getDay()-WEEK_START_DAY+7)%7;
			if (_data.hasOwnProperty(HeatMapCalendar.date2str(date))) {
				v = _data[HeatMapCalendar.date2str(date)];
				col = _cscale.getIntColor(v / _max);
			} else {
				col = HeatMapCalendar._zeroCol;
			}
			
			var s:Shape = new Shape();
			s.graphics.beginFill(col);
			s.graphics.drawRect(c * boxWidth, (r) * boxHeight, boxWidth-1, boxHeight-1);
			_boxes.push(s);
			if (c == 6) r++;
			date.setDate(date.date + 1);
			i++;
			spr.addChild(s);
			TweenLite.from(s, .36, { delay: delay+ i * .01, alpha: 0, blurFilter:{blurX:16, blurY:16}, ease:Expo.easeOut, y: -70 } );
		}
		return this;
	}
	
	public function fadeOut():void
	{
		for each (var b:Shape in _boxes) {
			TweenLite.to(b, .4, { delay: Random.next()*0.6, alpha: 0, ease:Expo.easeIn } );
		}
	}
	
}