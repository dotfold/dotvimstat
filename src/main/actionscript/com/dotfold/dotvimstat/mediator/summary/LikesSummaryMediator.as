package com.dotfold.dotvimstat.mediator.summary
{
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.summary.LikesSummary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class LikesSummaryMediator extends Mediator
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(LikesSummaryMediator);
		
		[Inject]
		public var service:IVimeoService;
		
		public var view:LikesSummary;
		
		/**
		 * Constructor.
		 */		
		public function LikesSummaryMediator()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 * Retrieve the user likes via the VimeoService.
		 */		
		override public function init():void
		{
			logger.debug('init, calling service: {0}', service);
			
			service.getLikes()
				.then(likesDataLoaded, likesDataLoadError);
		}
		
		/**
		 * 
		 */		
		private function likesDataLoaded(result:Array):void
		{
			logger.debug('service responded fulfilled {0}', result);
			
			view.likesCount = result ? result.length : 0;
		}
		
		/**
		 * 
		 */		
		private function likesDataLoadError(error:*):void
		{
			// process error
			// notify view of error
		}
	}
}