package com.dotfold.dotvimstat.mediator
{
	import modena.core.Element;
	
	/**
	 * Interface for View Mediators.
	 *
	 * @author jmcnamee
	 */
	public interface IMediator
	{
		function get enabled():Boolean;
		
		/**
		 * Sets the view Element this mediator should use.  
		 */
		function setView(element:Element):void;
		
		/**
		 * Called from ViewManager.
		 */
		function init():void;
		
		/**
		 * Teardown before re-initialise. Remove any listeners etc. in this function.
		 */
		function destroy():void;
		
		/**
		 * After a view has been disabled it can be re-enabled again via this method.
		 */
		function enable():void;
		
		/**
		 * If a View assocated with this Mediator becomes disabled (i.e. via layout configuration)
		 * the Mediator should temporarily stop listening to events etc. 
		 */
		function disable():void;
	}
}
