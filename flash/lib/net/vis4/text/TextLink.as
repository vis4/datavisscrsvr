package net.vis4.text 
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import net.vis4.text.fonts.Font;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TextLink extends Sprite
	{
		protected var _lbl:Label;
		
		
		protected var _paddingH:Number;
		protected var _paddingV:Number;
		protected var _borderRadius:Number;
		
		protected var _bgColor:int;
		protected var _bgAlpha:Number;
		protected var _bgColorHover:int;
		protected var _bgAlphaHover:Number;
		protected var _bgColorClick:int;
		protected var _bgAlphaClick:Number;
		protected var _fgColor:int;
		protected var _fgAlpha:Number;
		protected var _fgColorHover:int;
		protected var _fgAlphaHover:Number;
		protected var _fgColorClick:int;
		protected var _fgAlphaClick:Number;

		
		protected var _mode:uint = 0;
		protected const NORMAL:uint = 0;
		protected const HOVER:uint = 1;
		protected const CLICK:uint = 2;
		
		protected var _active:Boolean = true;
		protected var _hover:Boolean = false;
		protected var _clicked:Boolean = false;
		
		public function TextLink(txt:String, font:Font, paddingH:Number = 2, paddingV:Number = 2, borderRadius:Number = 0,
			fgColor:int = 0xBD0606, fgAlpha:Number = 1, bgColor:int = -1, bgAlpha:Number = 1, 
			fgColorHover:int = 0xA90505, fgAlphaHover:Number = 1, bgColorHover:int = 0xFEE7E7, bgAlphaHover:Number = 1, 
			fgColorClick:int = 0, fgAlphaClick:Number = 1, bgColorClick:int = 0xFEE7E7, bgAlphaClick:Number = 1) 
		{
			_borderRadius = borderRadius;
			
			_paddingV = paddingV;
			_paddingH = paddingH;
			_fgColor = fgColor;
			_fgAlpha = fgAlpha;
			_bgColor = bgColor;
			_bgAlpha = bgAlpha;
			_fgColorHover = fgColorHover;
			_fgAlphaHover = fgAlphaHover;
			_bgColorHover = bgColorHover;
			_bgAlphaHover = bgAlphaHover;
			_fgColorClick = fgColorClick;
			_fgAlphaClick = fgAlphaClick;
			_bgColorClick = bgColorClick;
			_bgAlphaClick = bgAlphaClick;
			
			_lbl = new Label(txt, font);
			_lbl.autoSize = 'left';
			addChild(_lbl);
			_lbl.x = paddingH;
			_lbl.y = paddingV;
			
			mouseChildren = false;
			buttonMode = true;
			
			drawBG();
			addEventListener(MouseEvent.ROLL_OVER, rollOver);
			addEventListener(MouseEvent.ROLL_OUT, rollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			if (!_active) return;
			_clicked = true;
			mode = CLICK;
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			if (!_active) return;
			_clicked = false;
			mode = _hover ? HOVER : NORMAL;
		}
		
		private function rollOver(e:MouseEvent):void 
		{
			if (!_active) return;
			_hover = true;
			mode = _clicked ? CLICK : HOVER;
		}
		
		public function set text(s:String):void
		{
			_lbl.text = s;
			drawBG();
		}
		
		private function rollOut(e:MouseEvent):void 
		{
			if (!_active) return;
			_hover = false;
			mode = _clicked ? CLICK : NORMAL;
		}
		
		protected function drawBG():void
		{
			graphics.clear();
			var c:int;
			switch (_mode) {
				case NORMAL: 
					if (_bgColor >= 0) graphics.beginFill(_bgColor, _bgAlpha);
					if (_fgColor >= 0) _lbl.color = _fgColor;
					_lbl.alpha = _fgAlpha;
					break;
				case CLICK: 
					if (_bgColorClick >= 0) graphics.beginFill(_bgColorClick, _bgAlphaClick);
					if (_fgColorClick >= 0) _lbl.color = _fgColorClick;
					_lbl.alpha = _fgAlphaClick;
					break;
				case HOVER: 
					if (_bgColorHover >= 0) graphics.beginFill(_bgColorHover, _bgAlphaHover);
					if (_fgColorHover >= 0) _lbl.color = _fgColorHover;
					_lbl.alpha = _fgAlphaHover;
					break;
			}
			graphics.drawRoundRect(0, 0, Math.round(_lbl.width + _paddingH * 2), Math.round(_lbl.height + _paddingV * 2), _borderRadius, _borderRadius);
			graphics.endFill();
		}
		
		protected function set mode(m:uint):void
		{
			if (m != _mode) {
				_mode = m;
				drawBG();
			}
		}
		
		public function get label():Label { return _lbl; }
		
		public function get bgColor():int { return _bgColor; }
		
		public function set bgColor(value:int):void 
		{
			_bgColor = value;
			drawBG();
		}
		
		public function get bgAlpha():Number { return _bgAlpha; }
		
		public function set bgAlpha(value:Number):void 
		{
			_bgAlpha = value;
			drawBG();
		}
		
		public function get bgColorHover():int { return _bgColorHover; }
		
		public function set bgColorHover(value:int):void 
		{
			_bgColorHover = value;
			drawBG();
		}
		
		public function get bgAlphaHover():Number { return _bgAlphaHover; }
		
		public function set bgAlphaHover(value:Number):void 
		{
			_bgAlphaHover = value;
			drawBG();
		}
		
		public function get bgColorClick():int { return _bgColorClick; }
		
		public function set bgColorClick(value:int):void 
		{
			_bgColorClick = value;
			drawBG();
		}
		
		public function get bgAlphaClick():Number { return _bgAlphaClick; }
		
		public function set bgAlphaClick(value:Number):void 
		{
			_bgAlphaClick = value;
			drawBG();
		}
		
		public function get active():Boolean { return _active; }
		
		public function set active(value:Boolean):void 
		{
			_active = value;
			mode = NORMAL;
			drawBG();
			
		}
		
		public function get fgColor():int { return _fgColor; }
		
		public function set fgColor(value:int):void 
		{
			_fgColor = value; drawBG();
		}
		
		public function get fgColorHover():int { return _fgColorHover; }
		
		public function set fgColorHover(value:int):void 
		{
			_fgColorHover = value; drawBG();
		}
		
		public function get fgColorClick():int { return _fgColorClick; }
		
		public function set fgColorClick(value:int):void 
		{
			_fgColorClick = value; drawBG();
		}
		

		protected var _url:String;
		
		public function enableContextMenu(url:String):void
		{
			// store url
			_url = url;
			
			var menu:ContextMenu, newWindow: ContextMenuItem, copyUrl:ContextMenuItem;
			
			menu = new ContextMenu();
			menu.hideBuiltInItems();
						
			newWindow = new ContextMenuItem('Link in neuem Fenster öffnen');
			newWindow.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, openInNewWindow);
			menu.customItems.push(newWindow);
			
			copyUrl = new ContextMenuItem('Link-Adresse kopieren', true);
			copyUrl.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, copyLinkUrl);
			menu.customItems.push(copyUrl);
			
			contextMenu = menu;
		}
		
		private function openInNewWindow(e:ContextMenuEvent):void 
		{
			navigateToURL(new URLRequest(_url));
		}
		
		private function copyLinkUrl(e:ContextMenuEvent):void 
		{
			System.setClipboard(_url);
		}
		
	}
	
}