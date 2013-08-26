package com.dotfold.dotvimstat.manager
{
	import com.dotfold.dotvimstat.mediator.IMediator;
	
	import modena.core.Element;
	
	import org.swiftsuspenders.Injector;
	
	/**
	 * Manages a View by deferring to implementations of IMediator, IVisibilityMediator, IAnimationMediator.
	 * 
	 * @author jmcnamee
	 */
	internal class ManagedView
	{
		private var _view:Element;
		private var _mediators:Array;
		private var _visibilityMediators:Array;
		private var _animationMediators:Array;
		
		/**
		 * Constructor.
		 */
		public function ManagedView()
		{
			super();
			
			_mediators = [];
			_visibilityMediators = [];
			_animationMediators = [];
		}
		
		/**
		 * View <code>Element</code> being managed.
		 */
		public function get view():Element
		{
			return _view;
		}
		
		public function set view(value:Element):void
		{
			_view = value;
		}
		
		/**
		 * Add Mediator for view Element.
		 */
		public function addMediator(mediator:IMediator):void
		{
			mediator.setView(view);
			
			_mediators.push(mediator);
		}
		
		/**
		 * Initialise all Mediator with Kernel.
		 */
		public function initMediators(injector:Injector):void
		{
			var mediator:IMediator;
			
			for (var i:int = 0, n:int = _mediators.length; i < n; i++)
			{
				mediator = _mediators[i] as IMediator;
				injector.injectInto(mediator);
				mediator.init();
			}
		}
		
		/**
		 * Call <code>destroy</code> on all Mediator.
		 */
		public function destroyMediators():void
		{
			for each (var mediator:IMediator in _mediators)
			{
				mediator.destroy();
			}
		}
		
		/**
		 * Enables all mediators.
		 */
		protected function enableMediators():void
		{
			for each (var mediator:IMediator in _mediators)
			{
				mediator.enable();
			}
		}
		
		/**
		 * Disables all mediators.
		 */
		protected function disableMediators():void
		{
			for each (var mediator:IMediator in _mediators)
			{
				mediator.disable();
			}
		}
		
		/**
		 * Destroy Mediator and remove view Element reference.
		 */
		public function destroy():void
		{
			destroyMediators();
			
			if (view)
			{
				view = null;
			}
		}
	}
}
