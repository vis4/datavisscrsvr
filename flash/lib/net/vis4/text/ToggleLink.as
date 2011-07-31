package net.vis4.text 
{
	import flash.events.MouseEvent;
	import net.vis4.color.Color;
	import net.vis4.text.fonts.Font;
	/**
	 * ...
	 * @author gka
	 */
	public class ToggleLink extends TextLink
	{
		private var _textColActive:uint;
		private var _bgColActive:uint;
		private var _textColInactive:uint;
		private var _bgColInactive:uint;
		
		protected var _sactive:Boolean;
		
		public function ToggleLink(active:Boolean, txt:String, font:Font, paddingH:Number = 2, paddingV:Number = 2, borderRadius:Number = 0,
			textColActive:uint = 0xffffff, bgColActive:uint = 0x98C272, textColInactive:uint = 0xffffff, bgColInactive:uint = 0x98C272) 
		{
			_bgColInactive = bgColInactive;
			_textColInactive = textColInactive;
			_bgColActive = bgColActive;
			_textColActive = textColActive;
			_sactive = active;
			
			super(txt, font, paddingH, paddingV, borderRadius);
			setColors();
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			_sactive = !_sactive;
			setColors();
		}
		
		
		
		private function setColors():void
		{
			var fg:uint, fgH:uint, fgC:uint, bg:uint, bgH:uint, bgC:uint;
			
			if (_sactive) {
				fg = _textColActive;
				bg = _bgColActive;
			} else {
				fg = _textColInactive;
				bg = _bgColInactive;
			}
			
			fgH = fgC = fg;
			bgH = Color.fromInt(bg).lightness("+.01")._int;
			bgC = Color.fromInt(bg).lightness("-.1")._int;
			
			this._fgColor = fg;
			this._fgColorClick = fgC;
			this._fgColorHover = fgH;
			this._bgColor = bg;
			this._bgColorClick = bgC;
			this._bgColorHover = bgH;
			
			drawBG();
		}
		
		public function get sactive():Boolean { return _sactive; }
		
		public function set sactive(value:Boolean):void 
		{
			_sactive = value;
			setColors();
		}
		
	}

}