package com.dotfold.dotvimstat.view.event
{
	import flash.events.Event;
	
	/**
	 * Defines events dispatched from the UserSummary view.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class UserSummaryEvent extends Event
	{
		public static const VISIT_PROFILE:String = "UserSummaryEvent.VisitProfile";
		
		/**
		 * Constructor.
		 */
		public function UserSummaryEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone():Event
		{
			return new UserSummaryEvent(type, bubbles, cancelable);
		}
	}
}