package data.types 
{
	/**
	 * ...
	 * @author gka
	 */
	public class DataTable extends RawData 
	{
		
		protected var _rows:Array;
		private var _keys:Array;
		private var keyIndex:Object;
		
		public function DataTable(keys:Array) 
		{
			this.keys = keys;
			_rows = [];
		}
		
		public function clear():void
		{
			_keys = null;
			_rows = [];
		}
		
		
		public function insertRow(row:Array):void {
			if (_keys == null) throw new Error('keys must be defined first');
			if (row.length != _keys.length) throw new Error('wrong number of columns. expected ' + _keys.length);
			_rows.push(row);
		}
		
		override public function toString():String {
			var r:String = _keys.join('\t') + '\n' + _keys.join('\t').replace(/[^\t]/g, '-') + '\n';
			for each (var row:Array in _rows) {
				r += row.join('\t') + '\n';
			}
			return r;
		}
		
		public function get rows():Array 
		{
			return _rows;
		}
		
		public function get keys():Array 
		{
			return _keys;
		}
		
		public function set keys(value:Array):void 
		{
			_keys = value;
			keyIndex = { };
			var i:uint = 0;
			for each (var k:String in _keys) {
				keyIndex[k] = i++;
			}
		}
		
		public function minMax(column:String):Array
		{
			var min:Number = Number.MAX_VALUE, max:Number = Number.MIN_VALUE;
			for each (var row:Array in _rows) {
				min = Math.min(min, row[keyIndex[column]]);
				max = Math.max(max, row[keyIndex[column]]);
			}
			return [min, max];
		}
		
		public function get length():uint
		{
			return _rows.length;
		}
		
		public function getCell(row:uint, col:String):*
		{
			return get(row, col);
		}
		
		public function get(row:uint, col:String):*
		{
			return _rows[row][keyIndex[col]];
		}
	}

}