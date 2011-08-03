package data.types 
{
	import net.vis4.treemap.data.TreeNode;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TreeData extends RawData 
	{
		protected var _root:TreeNode;
		
		public function TreeData(root:TreeNode) {
			_root = root;
		}
		
		public function get root():TreeNode 
		{
			return _root;
		}
	}

}