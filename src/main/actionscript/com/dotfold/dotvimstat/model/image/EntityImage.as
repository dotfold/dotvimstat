package com.dotfold.dotvimstat.model.image
{
	public class EntityImage
	{
		
		public static const sizes:Object = {
			'small': 30,
			'medium': 75,
			'large': 100,
			'huge': 300
		}
		
		
		private var _url:String;
		private var _size:String;
		
		/**
		 * Constructor.
		 */		
		public function EntityImage()
		{
			super();
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			_url = value;
		}
		
		/**
		 * 
		 */		
		public function get size():String
		{
			return _size;	
		}
		
		public function set size(value:String):void
		{
			_size = value;
		}
		
		public function get dimension():int
		{
			return EntityImage.sizes[size];
		}
		
	}
}