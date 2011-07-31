package viz 
{
	import data.types.DataTable;
	import data.types.RawData;
	import flash.display.Sprite;
	import flash.ui.ContextMenuItem;
	import net.vis4.color.ColorScale;
	import net.vis4.text.fonts.embedded.QuicksandBold;
	import net.vis4.text.fonts.embedded.QuicksandBook;
	import net.vis4.text.fonts.embedded.QuicksandLight;
	import net.vis4.text.Label;
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
			
		var linscale:ColorScale = new ColorScale([0x570B0B, 0xFFF793], [0, 1]);
			
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
			addTitle('right', 'bottom');
			addSubtitle('left', 'bottom');
			
			var monthPerRow:uint;
			// find number of months per row
			if (_months < 4) monthPerRow = _months;
			else if (_months == 12) monthPerRow = 5;
			else monthPerRow = Math.ceil(_months * 0.33);
			
			trace('month per row', monthPerRow, _months);
			
			var _tw:Number = _stage.stage.stageWidth * 0.8;
			var _bw:uint = _tw / (monthPerRow * 8);
			
			var _cm:uint = _from.getMonth(), _cy:uint = _from.getFullYear();
			var c:uint = 0, r:uint = 0, cnt:uint =0;
			
			var monthNames:Array = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			
			while (_cy < _to.getFullYear() || _cm <= _from.getMonth()) {
				trace(_cy, _cm);
				var monthSprite:Sprite = new Sprite();
				new HeatMapCalendar_Month(_cy, _cm, dateObj, mm[1], _cscale)
					.render(monthSprite, _bw, Math.pow(cnt++*0.3,0.8));
				monthSprite.x = (_stage.stage.stageWidth - monthPerRow*_bw*8)*.5 + c * (_bw * 8);
				monthSprite.y = _stage.stage.stageHeight * 0.14 + r * (_bw * 8);
				_stage.addChild(monthSprite);
				var Font:Class = _cm == 0 ? QuicksandBold : QuicksandBook;
				new Label(_cm == 0 ? _cy : monthNames[_cm], new Font( { size: 16, color: 0xbbbbbb } ))
				.place(0, -_bw*1, monthSprite);
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
			clean();
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
	
	public function render(spr:Sprite, boxSize:Number, delay:Number = 0):void
	{
		var date:Date = new Date(_year, _month, 1);
		var r:uint = 0, c:uint, i:uint = 0, col:uint, v:Number;
		
		while (date.month == _month) {
			c = (date.getDay()-WEEK_START_DAY+7)%7;
			if (_data.hasOwnProperty(HeatMapCalendar.date2str(date))) {
				v = _data[HeatMapCalendar.date2str(date)];
				col = _cscale.getIntColor(v / _max);
			} else {
				col = 0x222222;
			}
			var s:Shape = new Shape();
			s.graphics.beginFill(col);
			s.graphics.drawRect(c * boxSize, (r) * boxSize, boxSize-1, boxSize-1);
			if (c == 6) r++;
			date.setDate(date.date + 1);
			i++;
			spr.addChild(s);
			TweenLite.from(s, .2, { delay: delay+ i * .015, alpha: 0, blurFilter:{blurX:8, blurY:8}, ease:Expo.easeOut, y: -70 } );
		}
	}
	
}