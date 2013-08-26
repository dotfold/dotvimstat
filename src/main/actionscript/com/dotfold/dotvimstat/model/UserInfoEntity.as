package com.dotfold.dotvimstat.model
{
	import com.dotfold.dotvimstat.model.enum.ImageSize;
	import com.dotfold.dotvimstat.model.image.EntityImage;
	import com.dotfold.dotvimstat.model.image.EntityImageCollection;
	
	/**
	 * Model class for Vimeo User info.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class UserInfoEntity extends BaseEntity
	{
		/**
		 * Constructor.
		 */		
		public function UserInfoEntity()
		{
			super();
		}
		
		//
		//	Properties
		//
		
		public var display_name:String;
		public var created_on:Date;
		public var is_staff:Boolean;
		public var is_plus:Boolean;
		public var is_pro:Boolean;
		public var location:String;
		public var url:String;
		public var bio:String;
		public var profile_url:String;
		public var videos_url:String;
		public var total_videos_uploaded:int;
		public var total_videos_appears_in:int;
		public var total_videos_liked:int;
		public var total_contacts:int;
		public var total_albums:int;
		public var total_channels:int;
		
		//
		// Images
		//
		
		private var _portrait_small:String
		public function get portrait_small():String
		{
			return _portrait_small;
		}
		
		public function set portrait_small(value:String):void
		{
			_portrait_small = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.SMALL;
			images.addItem(image);
		}
		
		private var _portrait_medium:String
		public function get portrait_medium():String
		{
			return _portrait_medium;
		}
		
		public function set portrait_medium(value:String):void
		{
			_portrait_medium = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.MEDIUM;
			images.addItem(image);
		}
		
		private var _portrait_large:String
		public function get portrait_large():String
		{
			return _portrait_large;
		}
		
		public function set portrait_large(value:String):void
		{
			_portrait_large = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.LARGE;
			images.addItem(image);
		}
		
		private var _portrait_huge:String
		public function get portrait_huge():String
		{
			return _portrait_huge;
		}
		
		public function set portrait_huge(value:String):void
		{
			_portrait_huge = value;
			
			var image:EntityImage = new EntityImage();
			image.url = value;
			image.size = ImageSize.HUGE;
			images.addItem(image);
		}
		
		public var images:EntityImageCollection = new EntityImageCollection();
	}
}