package com.dotfold.dotvimstat.mediator.summary
{
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.model.UserInfoEntity;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.summary.ActivitySummary;
	
	/**
	 * Mediator for ActivitySummary views.
	 * 
	 * Gathers activity data from the Vimeo Service and aggregates
	 * to a simple data structure to be displayed in the view.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class ActivitySummaryMediator extends Mediator
	{
		[Inject]
		public var service:IVimeoService;
		
		[Inject]
		public var user:UserInfoEntity;
		
		public var view:ActivitySummary;
		
		/**
		 * Constructor.
		 */
		public function ActivitySummaryMediator()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function init():void
		{
			getActivity();	
		}
		
		/**
		 * Calls the service to retrieve activity that happened to the user.
		 */
		private function getActivity():void
		{
			service.getActivityHappened()
				.then(activityDataLoaded);
		}
		
		/**
		 * 
		 */
		private function activityDataLoaded(result:*):void
		{
			
		}
		
		private function activityLoadFailure(error:*):void
		{
			
		}
		
	}
}