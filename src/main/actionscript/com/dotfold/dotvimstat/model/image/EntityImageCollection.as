package com.dotfold.dotvimstat.model.image
{
	import asx.array.empty;
	import asx.array.reduce;
	
	import com.dotfold.dotvimstat.model.enum.ImageSize;
	
	import flash.utils.Dictionary;

	
	/**
	 * Collection class for a list of <code>EntityImage</code>.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class EntityImageCollection
	{
		private var _list:Array;
		
		protected var sizes:Array = [30, 75, 100, 300];
		
		// TODO: `addItems` add many method
		
		/**
		 * Constructor. 
		 */
		public function EntityImageCollection(list:Array = null)
		{
			super();
			
			_list = list;
		}
		
		/**
		 * Adds an item to the internal collection, and sorts on the <code>dimension</code> field.
		 */
		public function addItem(item:EntityImage):void
		{
			_list ||= [];
			_list.push(item);
			_list.sortOn('dimension', Array.NUMERIC);
		}
		
		/**
		 * Retrieves an <code>EntityImage</code> from the list corresponding to the 
		 * supplied size parameter.
		 * 
		 * @param size ImageSize Enum of desired image size.
		 */
		public function getImageForSize(size:ImageSize):EntityImage
		{
			var dimension:int = EntityImage.ENTITY_IMAGE_SIZES[size];
			var index:int = sizes.indexOf(dimension);
			
			var image:EntityImage;
			if (index != -1)
			{
				image = _list[index];
			}
			
			return image;
		}
		
		/**
		 * Returns <code>true</code> if internal list is empty.
		 */
		public function isEmpty():Boolean
		{
			return empty(_list);
		}
		
		/**
		 * Returns length of internal list.
		 */
		public function get length():int
		{
			return _list.length;
		}
		
		/**
		 * Returns the sorted <code>Array</code> of <code>EntityImage</code>.
		 */
		public function get list():Array
		{
			return _list;
		}
		
		/**
		 * Binary Search for the closest <code>EntityImage</code> to the
		 * supplied width parameter.
		 * 
		 * Assumes that all Vimeo images are square, so width and height are the same value.
		 */
		public function findClosestMatchForWidth(width:int):*
		{
			var low:int = 0;
			var high:int = sizes.length;
			var result:Array = [];
			
			while (low < high) {
				var mid:int = (low + high) >>> 1;
				
				sizes[mid] < width
					? low = mid + 1
					: high = mid;
			}
			
			if (sizes[low] == width) {
				result.push(low);
				
				// because it's an ordered list, just check onwards
				while(sizes[++low] === width) {
					result.push(low);
				}
			}
			
			if (result.length > 0) {
				return result;
			}
			
			if (sizes[low] !== width) {
				var iterate:Array = [sizes[low - 1], sizes[low]];
				var diff:Object = reduce(0, iterate, function(memo:Number, val:Number):Number {
					var d1:Number = Math.abs(memo - width);
					var d2:Number = Math.abs(val - width);
					return d1 > d2 ? val : memo;
				});
				low = sizes.indexOf(diff);
			}
			
			return _list[low];
		}
		
	}
}