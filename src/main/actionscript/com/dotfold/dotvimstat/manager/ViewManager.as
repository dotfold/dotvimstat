package com.dotfold.dotvimstat.manager
{
	import com.dotfold.dotvimstat.mediator.IMediator;
	import com.dotfold.dotvimstat.mediator.summary.*;
	import com.dotfold.dotvimstat.view.IView;
	import com.dotfold.dotvimstat.view.summary.*;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import modena.core.Element;
	
	import org.as3commons.lang.DictionaryUtils;
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.swiftsuspenders.Injector;
	
	/**
	 * 
	 * ViewManager for the Application. The ViewManager is responsible
	 * for creating ManagedViews and initialising mediators for views
	 * when the view is added to the Stage.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class ViewManager
	{
		private static var _instance:ViewManager;
		
		/**
		 * ViewManager constructor, takes internal class SingletonEnforcer.
		 * 
		 * This should not be called externally, instead use getInstance().
		 */
		public function ViewManager(singleton:SingletonEnforcer)
		{
			super();
			
			if (!singleton)
			{
				throw new Error("ViewManager is a Singleton, use getInstance method");
			}
			
			_viewMediatorMap = new ViewMediatorMap();
			mapViewInterfacesToMediator();
		}
		
		/**
		 * Returns singleton instance of ViewManager.
		 */
		public static function getInstance():ViewManager
		{
			if (!_instance)
			{
				_instance = new ViewManager(new SingletonEnforcer());
			}
			
			return _instance;
		}
		
		// ----------------------------------------------------------------------------

		private static var logger:ILogger = LoggerFactory.getClassLogger(ViewManager);
		
		/**
		 * Sets the Flash Stage object. Used for listening when child elements
		 * are added and can be initialised.
		 */
		public function set stage(value:Stage):void
		{
			_stage = value;
			_stage.addEventListener(Event.ADDED_TO_STAGE, stage_addToStageHandler, true, int.MAX_VALUE);
		}
		
		/**
		 * Sets the Injector.
		 */
		public function set injector(value:Injector):void
		{
			_injector = value;
			_viewMediatorMap.injector = _injector;
		}
		
		private var _stage:Stage;
		private var _injector:Injector;
		
		private var _viewMediatorMap:ViewMediatorMap;
		private var _managedViewsByView:Dictionary = new Dictionary();
		private var _managedViews:Array = [];
		
		/**
		 * Creates a Dictionary of view classes and the Mediator to be created for them.
		 */
		private function mapViewToMediatorClass():Dictionary
		{
			var map:Dictionary = new Dictionary();
			
			map[VideosSummary] 		= VideosSummaryMediator;
			map[ActivitySummary] 	= ActivitySummaryMediator;
			map[UserSummary] 		= UserSummaryMediator;
			
			return map;
		}
		
		/**
		 * @see ViewMediatorMap#mapMediator
		 */
		protected function mapViewInterfacesToMediator():void
		{
			var mediatorsByViewClass:Dictionary = mapViewToMediatorClass();
			var keys:Array = DictionaryUtils.getKeys(mediatorsByViewClass);
			for each (var viewType:Class in keys)
			{
				var mediatorType:Class = mediatorsByViewClass[viewType] as Class;
				_viewMediatorMap.mapMediator(viewType, mediatorType);
			}
		}
		
		/**
		 * View Element has been added to the stage. Initialise the ManagedView.
		 */
		protected function stage_addToStageHandler(event:Event):void
		{
			var view:Element = event.target as Element;
			
			if (!view)
			{
				return;
			}

			addMediators(view);
		}
		
		/**
		 * Create Mediator for view Element.
		 */
		protected function addMediators(view:Element):void
		{
			var managedView:ManagedView = getManagedView(view);
			
			if (view is IView)
			{
				_injector.injectInto(view);
				
				// allow multiples, return a list
				var mediators:Vector.<IMediator> = _viewMediatorMap.registerMediators(view);
				mediators.forEach(function(mediator:IMediator, i:int, v:Vector.<IMediator>):void
				{
					managedView.addMediator(mediator);
					_managedViews.push(managedView);
				});
				
				managedView.initMediators(_injector);
			}
		}
		
		/**
		 * Returns a ManagedView for the supplied Element.
		 */
		protected function getManagedView(view:Element):ManagedView
		{
			var managedView:ManagedView = _managedViewsByView[view];
			if (!managedView)
			{
				managedView = new ManagedView();
				managedView.view = view;
				_managedViewsByView[view] = managedView;
			}
			
			return managedView;
		}
		
	}
}

/**
 * Internal class enables Singleton pattern.
 */
class SingletonEnforcer
{
	
}