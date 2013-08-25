package com.dotfold.dotvimstat.mediator.summary
{
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.summary.VideosSummary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class VideosSummaryMediator extends Mediator
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(VideosSummaryMediator);
		
		[Inject]
		public var service:IVimeoService;
		
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
			logger.debug('init, calling service: {0}', service);

			service.getVideos()
				.then(videosDataLoaded, videosDataLoadError);
		}
		
		/**
		 * 
		 */		
		private function videosDataLoaded(result:Array):void
		{
			logger.debug('service responded fulfilled {0}', result);
			
			view.videosCount = result ? result.length : 0;
		}
		
		/**
		 * 
		 */		
		private function videosDataLoadError(error:*):void
		{
			// process error
			// notify view of error
		}
	}
}