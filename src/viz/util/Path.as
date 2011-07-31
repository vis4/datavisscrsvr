package viz.util 
{
	import flash.display.Graphics;
	import flash.geom.Point;
	/**
	 * ...
	 * @author gka
	 */
	public class Path 
	{
		private var _points:Array;
		
		public function Path() 
		{
			_points = [];
		}
		
		public function addPoint(p:Point):void
		{
			_points.push(p);
			_dirty = true;
		}
		
		public function add(x:Number, y:Number):void
		{
			_points.push(new Point(x, y));
			_dirty = true;
		}
		
		public function get points():Array 
		{
			return _points;
		}
		
		public function set points(value:Array):void 
		{
			_points = value;
			_dirty = true;
		}
		
		public function get length():Number 
		{
			if (_dirty) calcTotalLength();
			return _length;
		}
		
		public function draw(g:Graphics, begin:Number = 0, end:Number = 1):void 
		{
			var curLen:Number = 0, part:Number;
			if (_dirty) calcTotalLength();
			if (begin > end) {
				var t:Number = end;
				end = begin;
				begin = t;
			}
			begin = Math.max(0, begin);
			end = Math.min(1, end);
			begin *= _length;
			end *= _length;
			var a:Point, b:Point, v:Point;
			for (var i:uint = 1; i < _points.length; i++) {
				a = _points[i - 1];
				b = _points[i];
				v = b.subtract(a);
				part = v.length;
				if (curLen + part <= begin || curLen >= end) {
					// this part is not drawn
				} else {
					if (curLen < begin && curLen + part > begin) {
						// draw just a part of the line 
						v.normalize(begin - curLen);
						g.moveTo(a.x + v.x, a.y + v.y);
					} else {
						g.moveTo(a.x, a.y);
					}
					
					if (curLen < end && curLen + part > end) {
						// draw just a part of the line 
						v.normalize(end - curLen);
						g.lineTo(a.x + v.x, a.y + v.y);
					} else {
						g.lineTo(b.x, b.y);
					}
				}
				curLen += part;
			}
		}
		
		protected function calcTotalLength():void
		{
			_length = 0;
			var a:Point, b:Point;
			for (var i:uint = 1; i < _points.length; i++) {
				a = _points[i - 1];
				b = _points[i];
				_length += b.subtract(a).length;
			}
			_dirty = false;
		}
		
		protected var _length:Number;
		protected var _dirty:Boolean = true;
		
		
		
	}

}