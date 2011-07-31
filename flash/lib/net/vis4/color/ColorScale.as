package net.vis4.color 
{
	/**
	 * ...
	 * @author gka
	 */
	public class ColorScale
	{
		public static var monochrome:ColorScale = new ColorScale([0xFCF0E2, 0xC66711]);
		
		private var _mode:String;
		private var _colors:Array;
		private var _ratios:Array;
		private var _shortestHue:Boolean = true;
		
		public function ColorScale(colors:Array, ratios:Array = null, mode:String = 'hsl') 
		{
			_mode = mode;
			if (ratios == null) {
				// autofill ratios
				ratios = [0];
				for (var k:uint = 1; k < colors.length-1; k++) { // k == 3 >> 0 .5 1 
					ratios.push(k / (colors.length - 1));
				}
				ratios.push(1);
			}
			_ratios = ratios;
			_colors = [];
			for (k = 0; k < colors.length; k++) {
				if (colors[k] is String) {
					if (colors[k].length == 6) colors[k] = '#' + colors[k];
					_colors.push(Color.fromHex(colors[k], mode));
				} else if (colors[k] is uint) {
					_colors.push(Color.fromInt(colors[k], mode));
				} else {
					throw new Error('unsupported input format for colors');
				}
			}
			
		}
		
		private function getColor(i:Number):Color
		{
			for (var k:uint = 0; k < _colors.length-1; k++) {
				if (i == _ratios[k]) return _colors[k];
				if (i == _ratios[k+1]) return _colors[k+1];
				if (i > _ratios[k] && i < _ratios[k + 1]) {
					var f:Number = (i - _ratios[k]) / (_ratios[k + 1] - _ratios[k]);
					var a:Color = _colors[k], b:Color = _colors[k + 1];
					
					var ah:Number = a._hue, bh:Number = b._hue, dh:Number, inv:Boolean = !false;
					
					if (bh > ah) {
						if ((bh - ah + 360) % 360 > 180) {
							dh = (360 - bh - ah);
						} else {
							dh = bh - ah;
						}
					} else {
						if ((bh - ah + 360) % 360 > 180) {
							dh = bh - ah;
						} else {
							dh = bh - ah;
						}
					}
					//dh = bh - ah;// (bh - ah + 360) % 360;
					/*if ((bh-ah+360)%360 < (ah-bh+360)%360) {
						ah = b._hue;
						bh = a._hue;
						inv = true;
					}*/
					
					if (_mode == 'hsl') {
						return Color.fromHSL(a._hue + f*dh, a._saturation + f*(b._saturation - a._saturation), a._lightness + f*(b._lightness - a._lightness));
					} else if (_mode == 'hsb') {
						return Color.fromHSB(a._hue + f*dh, a._saturation + f*(b._saturation - a._saturation), a._brightness + f*(b._brightness - a._brightness));
					} else if (_mode == 'hsv') {
						return Color.fromHSV(a._hue + f*dh, a._saturation + f*(b._saturation - a._saturation), a._value + f*(b._value - a._value));
					} else if (_mode == 'hsi') {
						return Color.fromHSI(a._hue + f*dh, a._saturation + f*(b._saturation - a._saturation), a._intensity + f*(b._intensity - a._intensity));
					}
				}
			}	
			return null;
		}
		
		public function getIntColor(i:Number):uint
		{
			var col:Color = getColor(i < 0 ? 0 : (i > 1 ? 1 : i));
			if (col != null) {
				return col._int;
			}
			trace('[ColorScale] wrong input ' + i);
			return undefined;
		}
		
		public function getHexColor(i:Number):String
		{
			var col:Color = getColor(i < 0 ? 0 : (i > 1 ? 1 : i));
			if (col != null) {
				return col._hex;
			}
			return '#000000';
		}
		
		public function get mode():String { return _mode; }
		
	}

}