package com.dotfold.dotvimstat.mediator.summary
{
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.model.UserInfoEntity;
	import com.dotfold.dotvimstat.model.enum.ImageSize;
	import com.dotfold.dotvimstat.model.image.EntityImage;
	import com.dotfold.dotvimstat.model.image.EntityImageCollection;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.event.UserSummaryEvent;
	import com.dotfold.dotvimstat.view.summary.UserSummary;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	/**
	 * Mediator for UserSummary view.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class UserSummaryMediator extends Mediator
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(VideosSummaryMediator);
		
		[Inject]
		public var service:IVimeoService;
		
		[Inject]
		/**
		 * Injects the user retrieved during application startup. 
		 */
		public var user:UserInfoEntity
		
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
			setupViewClickHandler();
			displayUserInfo();
		}
		
		/**
		 * Enables Mouse events on the view, so it can be
		 * clicked through to the users profile page.
		 */
		private function setupViewClickHandler():void
		{
			view.addEventListener(UserSummaryEvent.VISIT_PROFILE, viewMouseClickHandler);
		}
		
		/**
		 * Using the injected <code>UserInfoEntity</code> pass the required
		 * summary information to the view.
		 */
		private function displayUserInfo():void
		{
			view.displayName = user.display_name;
			
			var images:EntityImageCollection = user.images;
			var imageToDisplay:EntityImage = images.getImageForSize(ImageSize.HUGE);
			view.image = imageToDisplay;
		}
		
		/**
		 * View click handler. Visit the user profile page.
		 */
		private function viewMouseClickHandler(event:UserSummaryEvent):void
		{
			var url:URLRequest = new URLRequest(user.profile_url);
			navigateToURL(url, "_blank");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void
		{
			view.removeEventListener(UserSummaryEvent.VISIT_PROFILE, viewMouseClickHandler);
		}
		
	}
}