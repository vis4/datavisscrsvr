package net.vis4.treemap.renderer 
{
	import net.vis4.treemap.data.TreeMapItemLayoutData;
	import net.vis4.treemap.data.TreeNode;
	/**
	 * ...
	 * @author gka
	 */
	public class BranchRenderer implements ITreeMapBranchRenderer
	{
		protected var _nodes:Array;
	
		
		public function BranchRenderer() 
		{
			
		}
		
		public function setNodes(nodes:Array):void
		{
			_nodes = nodes;
			// prepare nodes, initialize TreeMapItemLayoutData instances
			for each (var node:TreeNode in _nodes) {
				node.layout = new TreeMapItemLayoutData(null);
				node.layout.weight = node.weight;
			}
		}
		
		/* INTERFACE net.vis4.treemap.renderer.ITreeMapBranchRenderer */
		
		public function get itemCount():int 
		{
			return _nodes.length;
		}
		
		public function getItemAt(index:int):TreeMapItemLayoutData 
		{
			return _nodes[index].layout;
		}
		
		public function itemsToArray():Array 
		{
			var out:Array = [];
			for each (var node:TreeNode in _nodes) {
				out.push(node.layout);
			}
			return out;
		}
		
		
		
	}

}