package com.dotfold.dotvimstat.mediator
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	
	import modena.core.Element;
	
	/**
	 * Base class for View Mediators.
	 *
	 * @author jmcnamee
	 */
	public class Mediator implements IMediator
	{
		private var _enabled:Boolean = false;
		
		/**
		 * Constructor.
		 */
		public function Mediator()
		{
			super();
			
			_enabled = true;
		}
		
		/**
		 * Sets the view property on this mediator if availble.
		 */
		public function setView(element:Element):void 
		{
			if (hasOwnProperty("view"))
			{
				this["view"] = element;
			}
		}
		
		/**
		 * Abstract method. Called from ViewManager.
		 */
		public function init():void
		{
			// override in subclass
		}
		
		/**
		 * Teardown before re-initialise. Remove any listeners etc. in this function.
		 */
		public function destroy():void
		{
			setView(null);
		}
		
		/**
		 * Returns the enabled state.
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * After a view has been disabled it can be re-enabled again via this method.
		 */
		public function enable():void
		{
			_enabled = true;
		}
		
		/**
		 * If a View assocated with this Mediator becomes disabled (i.e. via layout configuration)
		 * the Mediator should temporarily stop listening to events etc.
		 */
		public function disable():void
		{
			_enabled = false;
		}
	}
}
