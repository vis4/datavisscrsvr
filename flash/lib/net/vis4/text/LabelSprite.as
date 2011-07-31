package net.vis4.text 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author gka
	 */
	public class LabelSprite extends Sprite
	{
		private var _label:Label;
		
		public function LabelSprite(label:Label) 
		{
			_label = label;
			addChild(label);
		}
		
		public function get label():Label { return _label; }
		
	}

}