package net.vis4.text.fonts 
{
	
	/**
	 * @author gka
	 * 
	 * base class for all fonts
	 */
	public class Font 
	{
		
		protected var _name:String;
		protected var _embedded:Boolean;
		protected var _antiAliasType:String;
		protected var _sharpness:Number;
		protected var _thickness:Number;
		protected var _letterSpacing:Number;
		protected var _size:Number;
		protected var _bold:Boolean;
		protected var _italic:Boolean;
		protected var _underline:Boolean;
		protected var _color:uint;
		protected var _alpha:Number;
		protected var _kerning:Boolean;
		protected var _leading:Number;
		
		public function Font(props:Object)
		//name:String, color:uint, size:Number, alpha:Number, bold:Boolean, italic:Boolean, underline:Boolean, embedded:Boolean, antiAliasType:String = '', sharpness:Number = 100, kerning:Boolean = true) 
		{
			_name = props.name;
			_embedded = props.embedded;
			_antiAliasType = props.antiAliasType;
			_bold = props.bold;
			_size = props.size;
			_italic = props.italic;
			_color = props.color;
			_underline = props.underline;
			_alpha = props.alpha;
			_sharpness = props.sharpness;
			_thickness = props.thickness;
			_kerning = props.kerning;
			_leading = props.leading;
			_letterSpacing = props.letterSpacing;
		}
		
		public function get name():String { return _name; }
		
		public function get embedded():Boolean { return _embedded; }
		
		public function get antiAliasType():String { return _antiAliasType; }
		
		public function get size():Number { return _size; }
		
		public function get color():uint { return _color; }
		
		public function set color(value:uint):void { _color = value; }
		
		public function get alpha():Number { return _alpha; }
		
		public function set alpha(value:Number):void { _alpha = value; }	
		
		public function get bold():Boolean { return _bold; }
		
		public function get italic():Boolean { return _italic; }
		
		public function get sharpness():Number { return _sharpness; }
		
		public function get underline():Boolean { return _underline; }
		
		public function get kerning():Boolean { return _kerning; }
		
		public function get thickness():Number { return _thickness; }
		
		public function get letterSpacing():Number { return _letterSpacing; }
		
		public function get leading():Number { return _leading; }

		public function get fontCSS():String
		{
			return 'font-family: ' + name + '; font-size: ' + size + 'px; color: ' + int2hex(color) + '; font-weight: ' + (bold ? 'bold' : 'normal') + '; '
				+ 'leading: ' + leading + 'px; letter-spacing: ' + letterSpacing + 'px; font-decoration: ' + (underline ? 'underline' : 'none') + '; '
				+ 'font-style: ' + (italic ? 'italic' : 'normal') + '; ';
		}
		
		public function set size(value:Number):void 
		{
			_size = value;
		}
		
		// added: this function converts 0xff0000 to "#FF0000"
		private function int2hex(intcol:uint):String
		{
			var s:String = "000000" + intcol.toString(16).toUpperCase()
			return "#" + s.substr(s.length - 6);
		}
	}
	
}