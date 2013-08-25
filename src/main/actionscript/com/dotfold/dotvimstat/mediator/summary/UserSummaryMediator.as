package com.dotfold.dotvimstat.mediator.summary
{
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.model.UserInfoEntity;
	import com.dotfold.dotvimstat.model.image.EntityImage;
	import com.dotfold.dotvimstat.model.image.EntityImageCollection;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.summary.UserSummary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class UserSummaryMediator extends Mediator
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(VideosSummaryMediator);
		
		[Inject]
		public var service:IVimeoService;
		
		public var view:UserSummary;
		
		/**
		 * Constructor.
		 */		
		public function UserSummaryMediator()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 * Retrieves the User Info from the Vimeo API.
		 */		
		override public function init():void
		{
			service.getInfo()
				.then(infoDataLoaded, infoDataLoadError);
		}
		
		/**
		 * 
		 */		
		private function infoDataLoaded(result:UserInfoEntity):void
		{
			logger.debug('load; result: {0} {1}', result, view.width);
			view.displayName = result.display_name;
			
			var images:EntityImageCollection = result.images;
//			var imageToDisplay:EntityImage = images.findClosestMatchForWidth(view.width);
			var imageToDisplay:EntityImage = images.list[images.list.length - 1];
			view.image = imageToDisplay;
		}
		
		/**
		 * 
		 */		
		private function infoDataLoadError(error:*):void
		{
			logger.error('load error');
		}
	}
}