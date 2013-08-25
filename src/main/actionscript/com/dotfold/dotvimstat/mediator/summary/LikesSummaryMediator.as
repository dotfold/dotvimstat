package com.dotfold.dotvimstat.mediator.summary
{
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.summary.LikesSummary;

	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class LikesSummaryMediator extends Mediator
	{
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
		 */		
		override public function init():void
		{
			
		}
	}
}