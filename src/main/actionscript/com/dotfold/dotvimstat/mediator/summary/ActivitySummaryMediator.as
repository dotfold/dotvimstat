package com.dotfold.dotvimstat.mediator.summary
{
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.summary.ActivitySummary;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class ActivitySummaryMediator extends Mediator
	{
		[Inject]
		public var service:IVimeoService;
		
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
			service.getActivity()
				.then(activityDataLoaded);
		}
		
		/**
		 * 
		 */		
		private function activityDataLoaded(result:*):void
		{
			
		}
		
	}
}