package net.vis4.treemap.data 
{
	/**
	 * ...
	 * @author gka
	 */
	public class Tree 
	{
		
		protected var _root:TreeNode;
		
		public function Tree(root:TreeNode) 
		{
			_root = root;
		}
		
		public function get root():TreeNode 
		{
			return _root;
		}
		
	}

}