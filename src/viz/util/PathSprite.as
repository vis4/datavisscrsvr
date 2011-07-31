package viz.util 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gka
	 */
	public class PathSprite extends Sprite 
	{
		protected var _path:Path;
		protected var _from:Number = 0;
		protected var _to:Number = 1;
		protected var _color:uint;
		protected var _thickness:Number;
		protected var _alpha:Number;
		
		public function PathSprite(path:Path, thickness:Number, color:uint, alpha:Number = 1, from:Number = 0, to:Number = 1) 
		{
			_alpha = alpha;
			_color = color;
			_thickness = thickness;
			_color = color;
			_path = path;
			_from = from;
			_to = to;
			
		}
		
		public function draw():void
		{
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(_thickness, _color, _alpha);
			_path.draw(g, _from, _to);
		}
		
		public function get path():Path 
		{
			return _path;
		}
		
		public function set path(value:Path):void 
		{
			_path = value;
		}
		
		public function get from():Number 
		{
			return _from;
		}
		
		public function set from(value:Number):void 
		{
			_from = value;
			draw();
		}
		
		public function get to():Number 
		{
			return _to;
		}
		
		public function set to(value:Number):void 
		{
			_to = value;
			draw();
		}
		
	}

}