package net.vis4.color 
{
	
	/**
	 * ...
	 * @author gka
	 */
	public class HueCorrection 
	{
		
		private static var _tf:Array = [
			[10,5], [30,45], [50,70],
			[70,94], [110,100], [125,115],
			[145,148],[161,174], [182,179],
			[188,185],
			[210,225], [250,255]	
		];
		
		public static function correctHue(hue:Number):Number {
			var h:uint = hue / 360 * 255;
			
			var new_hue:Number;
			
			var lx:Number = 0;
			var ly:Number = 0;
			
			for (var i:uint=0; i<_tf.length; i++) {
				if (h == _tf[i][1]) {
					new_hue = _tf[i][0];
					break;
				} else if (h < _tf[i][1]) {
					new_hue = lx + ((_tf[i][0] - lx) / (_tf[i][1] - ly)) * (h - ly);
					break;
				} 
				lx = _tf[i][0];
				ly = _tf[i][1];
			}
			return new_hue / 255 * 360;
		}
			
	}
	
}