package com.dotfold.dotvimstat.mediator.summary
{
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.model.UserInfoEntity;
	import com.dotfold.dotvimstat.model.VideoEntity;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.summary.VideosSummary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	/**
	 * Mediator for VideosSummary view.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class VideosSummaryMediator extends Mediator
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(VideosSummaryMediator);
		
		[Inject]
		public var user:UserInfoEntity;
		
		public var view:VideosSummary;
		
		/**
		 * Constructor.
		 */
		public function VideosSummaryMediator()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 * Retrieve the videos via the VimeoService.
		 */
		override public function init():void
		{
			displayVideosCount();
			view.show();
		}
		
		/**
		 * Displays the number of videos owned by this User.
		 */
		private function displayVideosCount():void
		{
			view.videosCount = user.total_videos_uploaded;
		}
	}
}