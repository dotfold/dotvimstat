package com.dotfold.dotvimstat.model
{
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class UserInfoEntity extends BaseEntity
	{
		public function UserInfoEntity()
		{
			super();
		}
		
		public var displayName:String;
		public var created_on:String;
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
		public var portrait_small:String;
		public var portrait_medium:String;
		public var portrait_large:String;
		public var portrait_huge:String;
	}
}