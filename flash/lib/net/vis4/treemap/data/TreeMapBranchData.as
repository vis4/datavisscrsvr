////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) 2007-2010 Josh Tynjala
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to 
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////

package net.vis4.treemap.data
{
	import net.vis4.treemap.layout.ITreeMapLayoutStrategy;
	import net.vis4.treemap.TreeMap;

	/**
	 * The data passed to drop-in TreeMap branch renderers.
	 * 
	 * @see com.flextoolbox.controls.TreeMap
	 * @author Josh Tynjala
	 */
	public class TreeMapBranchData extends BaseTreeMapData
	{
		
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */
		public function TreeMapBranchData()
		{
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
		
		/**
		 * The layout strategy to be used by the branch renderer to position
		 * and size its children.
		 */
		public var layoutStrategy:ITreeMapLayoutStrategy;
		
		/**
		 * Does not display addition information to the user, such as a label.
		 */
		public var displaySimple:Boolean;
		
		/**
		 * If true, the branch will not position its children.
		 */
		public var closed:Boolean = false;
		
		/**
		 * If true, the branch is displayed at full size over the whole treemap.
		 */
		public var zoomed:Boolean = false;
		
	}
}