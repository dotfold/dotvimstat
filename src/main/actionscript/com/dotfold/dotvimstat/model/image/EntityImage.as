package com.dotfold.dotvimstat.model.image
{
	import com.dotfold.dotvimstat.model.enum.ImageSize;
	
	import flash.utils.Dictionary;
	
	/**
	 * Defines properties for a Vimeo Image.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class EntityImage
	{
		/**
		 * Map of size names to dimension.
		 */		
		public static const ENTITY_IMAGE_SIZES:Dictionary = new Dictionary();
		
		ENTITY_IMAGE_SIZES[ImageSize.SMALL] = 30;
		ENTITY_IMAGE_SIZES[ImageSize.MEDIUM] = 75;
		ENTITY_IMAGE_SIZES[ImageSize.LARGE] = 100;
		ENTITY_IMAGE_SIZES[ImageSize.HUGE] = 300;
		
		private var _url:String;
		private var _size:ImageSize;
		
		/**
		 * Constructor.
		 */
		public function EntityImage()
		{
			super();
		}
		
		/**
		 * Absolute URL to the image resource.
		 */
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			_url = value;
		}
		
		/**
		 * ImageSize Enum for this Entity.
		 */
		public function get size():ImageSize
		{
			return _size;	
		}
		
		public function set size(value:ImageSize):void
		{
			_size = value;
		}
		
		/**
		 * Returns integer of the dimension for the given size of this image.
		 * 
		 * Assumes that all Vimeo images are processed to the same size, and are square.
		 */
		public function get dimension():int
		{
			return ENTITY_IMAGE_SIZES[size];
		}
		
	}
}