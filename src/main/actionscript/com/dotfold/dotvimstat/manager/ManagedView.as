package com.dotfold.dotvimstat.manager
{
	import asx.array.every;
	import asx.array.forEach;
	
	import com.dotfold.dotvimstat.mediator.IMediator;
	
	import modena.core.Element;
	
	import org.swiftsuspenders.Injector;
	
	/**
	 * Manages a View by deferring to implementations of IMediator, IVisibilityMediator, IAnimationMediator.
	 *
	 * @see com.movideo.player.mediator.IMediator
	 * @see com.movideo.player.mediator.IVisibilityMediator
	 * @see com.movideo.player.mediator.IAnimationMediator
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
		
//		/**
//		 * Make view Element invisible.
//		 * View is still included in Layout.
//		 */
//		public function hide():void
//		{
//			if (allowedToHide())
//			{
//				animateHide();
//			}
//		}
		
//		protected function animateHide():void
//		{
//			forEach(_animationMediators, animateHideByMediator);
//		}
		
//		private function animateHideByMediator(mediator:IAnimationMediator):void
//		{
//			mediator.executeHideAnimation();
//		}
		
//		/**
//		 * Make view Element visible.
//		 */
//		public function show():void
//		{
//			if (allowedToShow())
//			{
//				animateShow();
//			}
//		}
		
//		protected function animateShow():void
//		{
//			forEach(_animationMediators, animateShowByMediator);
//		}
		
//		private function animateShowByMediator(mediator:IAnimationMediator):void
//		{
//			mediator.executeShowAnimation();
//		}
		
//		protected function allowedToShow():Boolean
//		{
//			return every(_visibilityMediators, isAllowedToShowByMediator);
//		}
		
//		private function isAllowedToShowByMediator(mediator:IVisibilityMediator):Boolean
//		{
//			return mediator.allowShow();
//		}
		
//		protected function allowedToHide():Boolean
//		{
//			return every(_visibilityMediators, isAllowedToHideByMediator);
//		}
//		
//		private function isAllowedToHideByMediator(mediator:IVisibilityMediator):Boolean
//		{
//			return mediator.allowHide();
//		}
		
		/**
		 * Add Mediator for view Element.
		 */
		public function addMediator(mediator:IMediator):void
		{
			mediator.setView(view);
			
			_mediators.push(mediator);
			
//			if (mediator is IVisibilityMediator)
//			{
//				_visibilityMediators.push(mediator);
//			}
//			
//			if (mediator is IAnimationMediator)
//			{
//				_animationMediators.push(mediator);
//			}
		}
		
		/**
		 * Initialise all Mediator with Kernel.
		 */
		public function initMediators(injector:Injector):void
		{
			trace('init mediators');
			
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
		
//		/**
//		 * Enable all Mediators for the View
//		 * and include the Element.
//		 */
//		public function enable():void
//		{
//			if (allowedToEnable())
//			{
//				animateEnable();
//				enableMediators();
//			}
//		}
		
//		/**
//		 * Disable all Mediators for the View
//		 * and exclude the Element.
//		 */
//		public function disable():void
//		{
//			if (allowedToDisable())
//			{
//				animateDisable();
//				disableMediators();
//			}
//		}
		
//		protected function allowedToEnable():Boolean
//		{
//			return every(_visibilityMediators, isAllowedToEnableByMediator);
//		}
//		
//		private function isAllowedToEnableByMediator(mediator:IVisibilityMediator):Boolean
//		{
//			return mediator.allowEnable();
//		}
//		
//		protected function allowedToDisable():Boolean
//		{
//			return every(_visibilityMediators, isAllowedToDisableByMediator);
//		}
//		
//		private function isAllowedToDisableByMediator(mediator:IVisibilityMediator):Boolean
//		{
//			return mediator.allowDisable();
//		}
		
		protected function enableMediators():void
		{
			for each (var mediator:IMediator in _mediators)
			{
				mediator.enable();
			}
		}
		
		protected function disableMediators():void
		{
			for each (var mediator:IMediator in _mediators)
			{
				mediator.disable();
			}
		}
		
//		protected function animateEnable():void
//		{
//			forEach(_animationMediators, animateEnableByMediator);
//		}
//		
//		private function animateEnableByMediator(mediator:IAnimationMediator):void
//		{
//			mediator.executeEnableAnimation();
//		}
//		
//		protected function animateDisable():void
//		{
//			forEach(_animationMediators, animateDisableByMediator);
//		}
//		
//		private function animateDisableByMediator(mediator:IAnimationMediator):void
//		{
//			mediator.executeDisableAnimation();
//		}
		
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
