package com.dotfold.dotvimstat.model
{
	import com.dotfold.dotvimstat.model.enum.ImageSize;
	import com.dotfold.dotvimstat.model.image.EntityImage;
	import com.dotfold.dotvimstat.model.image.EntityImageCollection;
	
	/**
	 * VideoEntity.
	 * 
	 * Model class mapped to Vimeo video object.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class VideoEntity extends BaseEntity
	{
		
		/**
		 * Constructor.
		 */		
		public function VideoEntity()
		{
			super();
		}
		
		public var description:String;
		public var duration:int;
		public var embed_privacy:String;
		public var height:int;
		public var mobile_url:String;
		public var stats_number_of_comments:int;
		public var stats_number_of_likes:int;
		public var stats_number_of_plays:int;
		public var tags:String;
		public var title:String;
		public var upload_date:Date;
		public var url:String;
		public var user_name:String;
		public var user_url:String;
		public var width:int;
		
		
		//
		// Images
		//
		
		private var _thumbnail_small:String;
		public function get thumbnail_small():String
		{
			return _thumbnail_small;
		}
		
		public function set thumbnail_small(value:String):void
		{
			_thumbnail_small = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.SMALL;
			thumbnail_images.addItem(image);
		}
		
		private var _thumbnail_medium:String;
		public function get thumbnail_medium():String
		{
			return _thumbnail_medium;
		}
		
		public function set thumbnail_medium(value:String):void
		{
			_thumbnail_medium = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.MEDIUM;
			thumbnail_images.addItem(image);
		}
		
		private var _thumbnail_large:String;
		public function get thumbnail_large():String
		{
			return _thumbnail_large;
		}
		
		public function set thumbnail_large(value:String):void
		{
			_thumbnail_large = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.LARGE;
			thumbnail_images.addItem(image);
		}
		
		private var _user_portrait_small:String
		public function get user_portrait_small():String
		{
			return _user_portrait_small;
		}
		
		public function set user_portrait_small(value:String):void
		{
			_user_portrait_small = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.SMALL;
			user_portrait_images.addItem(image);
		}
		
		private var _user_portrait_medium:String
		public function get user_portrait_medium():String
		{
			return _user_portrait_medium;
		}
		
		public function set user_portrait_medium(value:String):void
		{
			_user_portrait_medium = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.MEDIUM;
			user_portrait_images.addItem(image);
		}
		
		private var _user_portrait_large:String
		public function get user_portrait_large():String
		{
			return _user_portrait_large;
		}
		
		public function set user_portrait_large(value:String):void
		{
			_user_portrait_large = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.LARGE;
			user_portrait_images.addItem(image);
		}
		
		private var _user_portrait_huge:String
		public function get user_portrait_huge():String
		{
			return _user_portrait_huge;
		}
		
		public function set user_portrait_huge(value:String):void
		{
			_user_portrait_huge = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.HUGE;
			user_portrait_images.addItem(image);
		}
		
		public var user_portrait_images:EntityImageCollection = new EntityImageCollection();
		public var thumbnail_images:EntityImageCollection = new EntityImageCollection();
		
	}
}