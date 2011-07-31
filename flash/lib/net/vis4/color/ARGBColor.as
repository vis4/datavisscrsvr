package net.vis4.color 
{
	
	/**
	 * ...
	 * @author gka
	 */
	public class ARGBColor 
	{
		private var _a:Number, _r:uint, _g:uint, _b:uint, _u:uint;
		
		public function ARGBColor(alpha:Number, red:uint, green:uint, blue:uint) 
		{
			_a = alpha;
			_r = red;
			_g = green;
			_b = blue;
			argb2int();
		}
		
		public function get intValue():uint 
		{
			return _u;
		}
		
		private function argb2int():void
		{
			_u = _r << 16 | _g << 8 | _b;
			_u = ((_a * 0xff) << 24) + _u;
		}
		
		private function int2rgb():void
		{
			_a = _u >> 24;
			_r = _u >> 16;
			_g = _u >> 8 & 0xFF;
			_b = _u & 0xFF;				
		}
		
		public static function fromRGB(rgb:uint, alpha:Number):uint
		{
			var argb:uint = 0;
			argb += (Math.floor(alpha*255)<<24);
			argb += (rgb);
			return argb;
		}
		
	}
	
}