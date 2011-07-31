package net.vis4.text 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import net.vis4.text.fonts.Font;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Label extends UsableTextField
	{
		protected var _font:Font;
		protected var _letterSpacing:Number;
		protected var _htmlMode:Boolean;
		private var _fmt:TextFormat;
		
		private var _txt:String, _halign:String, _ml:Boolean;
		
		public function Label(txt:*, font:Font, halign:String = 'left', multiline:Boolean = false, html:Boolean = false) 
		{
			super();
			
			_txt = txt;
			_halign = halign;
			_ml = multiline;
			
			_font = font;
			
			updateFont();
			
			text = String(_txt);
			
			
		}
		
		public function attr(attributes:Object):Label
		{
			for (var prop:String in attributes) {
				if (this[prop] != null) {
					this[prop] = attributes[prop];
				}
			}
			return this;
		}
		
		public function place(x:Number, y:Number, container:DisplayObjectContainer):Label
		{
			this.x = x;
			if (_halign == 'center') this.x -= width * .5;
			if (_halign == 'right') this.x -= width;
			this.y = y;
			container.addChild(this);
			return this;
		}
	
		public function placePolar(cx:Number, cy:Number, alpha:Number, radius:Number, container:DisplayObjectContainer):Label
		{
			var dx:Number = 0;
			if (_halign == 'center') dx = width * -.5;
			if (_halign == 'right') dx = -width;
			var m:Matrix = new Matrix();
			if (alpha >= Math.PI*-.5 && alpha < Math.PI*.5) {
				m.translate( + radius+dx,  -height*.5);
				m.rotate(alpha);
			} else {
				m.translate( -radius - width-dx, -height * .5);
				m.rotate(alpha - Math.PI);
			}
			m.translate(cx, cy);
			this.transform.matrix = m;
			container.addChild(this);
			return this;
		}
		
		public function set color(col:uint):void
		{
			var fmt:TextFormat = defaultTextFormat;
			fmt.color = col;
			setTextFormat(fmt);
		}
		
		public function get font():Font { return _font; }
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			wordWrap = true;
				
			_autoHeight();
			
		}
		
		protected function _autoHeight():void
		{
			if (defaultTextFormat.align != 'justify') {
			
			autoSize = TextFieldAutoSize.LEFT;
			
				var h:Number = textHeight;
				autoSize = TextFieldAutoSize.NONE;
				height = textHeight + 10;
				
			}
			//if (!_font.embedded) setTextFormat(_fmt);
		}
		
		
		override public function set text(value:String):void 
		{
			if (_halign == 'right') var oxr:Number = this.x + this.width;
			if (_halign == 'center') var oxc:Number = this.x + this.width * .5;
			super.text = value;
			if (_halign == 'right') x = oxr - width;
			if (_halign == 'center') x = oxc - width * .5;

			if (!_font.embedded && !_htmlMode) setTextFormat(_fmt);
		}
		
		override public function set htmlText(value:String):void 
		{
			if (_halign == 'right') var oxr:Number = this.x + this.width;
			if (_halign == 'center') var oxc:Number = this.x + this.width * .5;
			super.htmlText = value;
			if (_halign == 'right') x = oxr - width;
			if (_halign == 'center') x = oxc - width * .5;

			if (!_font.embedded && !_htmlMode) setTextFormat(_fmt);
		}
		
		public function setFontSize(size:Number):void
		{
			if (_halign == 'right') var oxr:Number = this.x + this.width;
			if (_halign == 'center') var oxc:Number = this.x + this.width * .5;
			_font.size = size;
			updateFont();
			if (_halign == 'right') x = oxr - width;
			if (_halign == 'center') x = oxc - width * .5;
		}
		
		private function updateFont():void 
		{
			if (font.embedded) {
				if (styleSheet is StyleSheet) {
					_htmlMode = true;
					// ignoring font
				} else {
					_htmlMode = false;
					var format:TextFormat = new TextFormat(font.name, font.size, font.color, font.bold, font.italic, font.underline,
												null, null, _halign);
					format.kerning = font.kerning;
					format.letterSpacing = font.letterSpacing;
					format.leading = font.leading;
					defaultTextFormat = format;
				}
				alpha = font.alpha;
				embedFonts = font.embedded;
				
				this.multiline = multiline;
				
				autoSize = TextFieldAutoSize.LEFT;
				if (font.embedded) {
					antiAliasType = font.antiAliasType;
					sharpness = font.sharpness;
					thickness = font.thickness;
					
				}
				selectable = true;
				if (_htmlMode) {
					var html:String =  String(_txt);
					html = html.replace(/<b>/g, '<span class="bold">');
					html = html.replace(/<\/b>/g, '</span>');
					htmlText = html;
					condenseWhite = true;
					// setTextFormat(format);
				} else {
					//text = String(_txt);
					setTextFormat(format);
				}
				
				if (font.size > 127) {
					scaleX = scaleY = font.size / 127;
				}
			} else {
				if (styleSheet is StyleSheet) {
					_htmlMode = true;
				} else {
					_fmt = _fmt != null ? _fmt : new TextFormat();
					_fmt.font = font.name;
					_fmt.size = font.size;
					_fmt.color = font.color;
					_fmt.bold = font.bold;
					_fmt.italic = font.italic;
					_fmt.underline = font.underline;
					_fmt.kerning = font.kerning;
					_fmt.letterSpacing = font.letterSpacing;
					_fmt.leading = font.leading;
					
					setTextFormat(_fmt);
				}
			}
		}
		
		public function set font(value:Font):void 
		{
			_font = value;
			
			updateFont();
			
		}
	}
	
}