package com.dotfold.dotvimstat.model
{
	
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
		public var thumbnail_large:String;
		public var thumbnail_medium:String;
		public var thumbnail_small:String;
		public var title:String;
		public var upload_date:String;
		public var url:String;
		public var user_name:String;
		public var user_portrait_huge:String;
		public var user_portrait_large:String;
		public var user_portrait_medium:String;
		public var user_portrait_small:String;
		public var user_url:String;
		public var width:int;
		
	}
}