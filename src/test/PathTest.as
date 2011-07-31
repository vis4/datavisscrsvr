package test 
{
	import com.greensock.TweenLite;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import viz.util.Path;
	/**
	 * ...
	 * @author gka
	 */
	public class PathTest extends TestCase
	{
		protected var _stage:Sprite;
		protected var _t:Number = 0;
		protected var path:Path;
		
		public function PathTest(stage:Sprite) 
		{
			_stage = stage;
			
		}
		
		override public function run():void 
		{
			path = new Path();
			path.add(30, 100);
			path.add(300, 300);
			path.add(600, 150);
			path.add(600, 700);
			path.add(550, 650);
			
			
			TweenLite.to(this, 4, { t: 1 } ); 
		}
		
		public function get t():Number 
		{
			return _t;
		}
		
		public function set t(value:Number):void 
		{
			_t = value;
			var g:Graphics = _stage.graphics;
			g.clear();
			g.lineStyle(3, 0xffffff, 0.5);
			path.draw(g);
			
			g.lineStyle(5, 0xffbbbb, 1);
			path.draw(g, t-.1, t);
		}
		
	}

}