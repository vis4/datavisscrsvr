package viz 
{
	import data.types.RawData;
	import data.types.TreeData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import net.vis4.treemap.data.Tree;
	import net.vis4.treemap.display.Sprite3;
	import net.vis4.treemap.TreeMap;
	import net.vis4.treemap.data.TreeNode;
	import viz.util.MyTreeMap;
	/**
	 * ...
	 * @author gka
	 */
	public class TreemapModule extends VizModule
	{
		
		private var _tree:Tree;
		
		override public function setData(data:RawData):void 
		{
			_tree = new Tree(TreeData(data).root);
			
		}
		
		override public function fadeIn():void 
		{
			var treemap:TreeMap = new TreeMap(
				_tree, _vizBounds, TreeMap.SQUARIFY_LAYOUT, renderNode, renderBranch
			);
			super.fadeIn();
		}
		
		protected function renderBranch(node:TreeNode, container:Sprite3, level:uint):void 
		{
			
		}
		
		protected function renderNode(node:TreeNode, container:Sprite, level:uint):void 
		{
			
		}
		
		override public function fadeOut():void 
		{
			super.fadeOut();
		}
		
		
		
	}

}