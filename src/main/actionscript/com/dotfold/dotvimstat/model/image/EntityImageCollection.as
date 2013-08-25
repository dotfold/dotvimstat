package com.dotfold.dotvimstat.model.image
{
	import asx.array.reduce;
	
	import flash.utils.Dictionary;

	public class EntityImageCollection
	{
		private var _list:Array;
		
		private var _sizeNames:Dictionary;
		
		/**
		 * Constructor. 
		 */		
		public function EntityImageCollection(list:Array = null)
		{
			super();
			
			_list = list;
			
			_sizeNames = new Dictionary();
			_sizeNames[30] = 'small';
			_sizeNames[75] = 'medium';
			_sizeNames[100] = 'large';
			_sizeNames[300] = 'huge';
		}
		
		/**
		 * 
		 */		
		public function addItem(item:Object):void
		{
			_list ||= [];
			_list.push(item);
			_list.sortOn('dimension', Array.NUMERIC);
		}
		
		public function get list():Array
		{
			return _list;
		}
		
		protected var sizes:Array = [30, 75, 100, 300];
		
		/**
		 * 
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