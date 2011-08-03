package net.vis4.treemap.data 
{
	/**
	 * ...
	 * @author gka
	 */
	public class TreeNode 
	{
		/*
		 * the payload may contain any data that might be useful
		 * to render the treemap, like a label, category, tooltip,
		 * color, icon, ... whatever :)
		 */
		protected var _data:Object;
		
		/*
		 * the weight is used by treemap renderer to compute the 
		 * relative size of this node. 
		 */
		protected var _weight:Number;
		
		/*
		 * reference to the parent Node, may be null
		 */
		protected var _parent:TreeNode;
		
		/*
		 * array of child nodes, must be TreeNode instances
		 */
		protected var _children:Array;
		
		protected var _layout:TreeMapItemLayoutData;
		
		public function TreeNode(data:Object, weight:Number) 
		{
			_weight = weight;
			_data = data;
			_children = [];
			_layout = new TreeMapItemLayoutData(null);
		}
		
		public function get parent():TreeNode 
		{
			return _parent;
		}
		
		public function set parent(value:TreeNode):void 
		{
			_parent = value;
		}
		
		public function get children():Array 
		{
			return _children;
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function addChild(node:TreeNode):void
		{
			_children.push(node);
			node.parent = this;
		}
		
		public function get hasChildren():Boolean 
		{
			return _children.length > 0;
		}
		
		public function get layout():TreeMapItemLayoutData 
		{
			return _layout;
		}
		
		public function set layout(value:TreeMapItemLayoutData):void 
		{
			_layout = value;
		}
		
		public function get weight():Number 
		{
			return _weight;
		}
		
		public function set weight(value:Number):void 
		{
			_weight = value;
		}
		
	}

}