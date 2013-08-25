package com.dotfold.dotvimstat.manager
{
	import com.dotfold.dotvimstat.mediator.IMediator;
	
	import flash.utils.Dictionary;
	
	import modena.core.Element;
	
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.ReflectorBase;
	
	/**
	 * Creates mappings between view interfaces and mediator classes. Mediators are instantiated
	 * upon request with injection handled by SwiftSuspenders.
	 *
	 * Contains code taken from https://github.com/dnalot/robotlegs-utilities-variance
	 *
	 * SwiftSuspenders 2.0.0b3
	 * @see https://github.com/tschneidereit/SwiftSuspenders
	 *
	 * @author jmcnamee
	 *
	 */
	public class ViewMediatorMap
	{
		protected const mediatorClassMap:Dictionary = new Dictionary(false);
		protected const mediatorMap:Object = {};
		
		private var _mediatorByViewInterface:Dictionary;
		private var _injector:Injector;
		private var _reflector:ReflectorBase;
		
		/**
		 * Constructor.
		 */
		public function ViewMediatorMap()
		{
			super();
			
			_reflector = new ReflectorBase();
		}
		
		/**
		 * Injector property. If none is set, return a new Injector.
		 */		
		public function set injector(value:Injector):void
		{
			_injector = value;	
		}
		
		public function get injector():Injector
		{
			return _injector || new Injector();
		}
		
		/**
		 * Maps a view to be automatically mediated by an IMediator type.
		 *
		 * In invariant mediation, the type of component must match exactly to
		 * the type being mediated. This is invariant because only instances
		 * of the exact <code>viewType</code> will cause the
		 * <code>IVariantMediatorMap</code> to create the mapped mediator.
		 *
		 * In covariant mediation, if the component extends or implements any of
		 * the mapped <code>viewType</code>s, an instance of the mapped mediator
		 * will be instantiated and associated with the component. This is
		 * covariant, because a higher level generic type (be it interface or
		 * superclass) maps to the lower-level concrete implementation.
		 *
		 * @see https://github.com/dnalot/robotlegs-utilities-variance/blob/master/src/org/robotlegs/utilities/variance/base/IVariantMediatorMap.as
		 */
		public function mapMediator(viewType:Class, mediatorType:Class):void
		{
			const variance:int = int(true);
			
			if (!(viewType in mediatorClassMap))
			{
				mediatorClassMap[viewType] = [];
			}
			
			if (!mediatorClassMap[viewType][variance])
			{
				mediatorClassMap[viewType][variance] = mediatorType;
			}
		}
		
		/**
		 * Ensures registration of all the mediators for the given
		 * <code>viewComponent</code> instance.
		 *
		 * @returns A Vector of all the IMediator instances mapped with the
		 * <code>viewComponent</code> instance.
		 */
		public function registerMediators(viewComponent:Element):Vector.<IMediator>
		{
			const viewTypes:Vector.<Class> = retrieveViewTypes(viewComponent);
			const mediatorTypes:Vector.<Class> = retrieveMediatorClasses(viewComponent);
			const mediatorNames:Vector.<String> = retrieveMediatorNames(viewComponent, mediatorTypes);
			
			const mediators:Vector.<IMediator> = new <IMediator>[];
			
			mediatorNames.forEach(function(name:String, i:int, v:Vector.<String>):void
			{
				if (name in mediatorMap)
				{
					mediators.push(mediatorMap[name]);
					return;
				}
				
				const mediatorType:Class = mediatorTypes[i];
				
				viewTypes.forEach(function(viewType:Class, ... args):void
				{
					injector.map(viewType).toValue(viewComponent);
				});
				
				const mediator:IMediator = _injector.getInstance(mediatorType) as IMediator;
				
				viewTypes.forEach(function(viewType:Class, ... args):void
				{
					injector.unmap(viewType);
				});
				
				mediators.push(mediatorMap[name] = mediator);
			});
			
			return mediators;
		}
		
		/**
		 * Checks if the ViewMediatorMap has a mapping for a given <code>viewType</code>.
		 *
		 * @returns true if there is a mapping, false if there isn't.
		 */
		public function hasMediatorMapping(viewType:Class, covariant:Boolean = true):Boolean
		{
			return (viewType in mediatorClassMap) && Boolean(mediatorClassMap[viewType][int(covariant)]);
		}
		
		/**
		 * Returns a Vector of Classes that represent all the mapped
		 * <code>viewType</code>s that this <code>viewComponent</code> instance
		 * matches.
		 *
		 * @private
		 */
		protected function retrieveViewTypes(viewComponent:Object):Vector.<Class>
		{
			const classes:Vector.<Class> = new <Class>[];
			var viewType:* = _reflector.getClass(viewComponent);
			
			if (hasMediatorMapping(viewType, false))
			{
				classes.push(viewType);
			}
			for (viewType in mediatorClassMap)
			{
				if (viewComponent is viewType && hasMediatorMapping(viewType, true))
				{
					classes.push(viewType);
				}
			}
			
			return classes;
		}
		
		/**
		 * Returns a Vector of Classes that represent all the mapped
		 * <code>mediatorType</code>s that this <code>viewComponent</code>
		 * instance matches.
		 */
		protected function retrieveMediatorClasses(viewComponent:Object):Vector.<Class>
		{
			const classes:Vector.<Class> = new <Class>[];
			var viewType:* = _reflector.getClass(viewComponent);
			
			//Catch invariant type.
			if (hasMediatorMapping(viewType, false))
			{
				classes.push(mediatorClassMap[viewType][int(false)]);
			}
			//Check for covariance.
			for (viewType in mediatorClassMap)
			{
				if (viewComponent is viewType && hasMediatorMapping(viewType, true))
				{
					classes.push(mediatorClassMap[viewType][int(true)]);
				}
			}
			
			return classes;
		}
		
		/**
		 * Returns a Vector of unique String IDs from a combination of the given
		 * <code>viewComponent</code> instance and each mediator type.
		 */
		protected function retrieveMediatorNames(viewComponent:Object, mediatorTypes:Vector.<Class>):Vector.<String>
		{
			const mediatorNames:Vector.<String> = new <String>[];
			
			mediatorTypes.forEach(function(type:Class, ... args):void
			{
				mediatorNames.push(createMediatorName(viewComponent, type))
			});
			
			return mediatorNames;
		}
		
		/**
		 * Creates a semi-unique key from the combination of the given
		 * <code>viewComponent</code> instance and the mediatorType.
		 *
		 * Note: It is feasible that two <code>viewComponent</code>s of the same
		 * Class type can exist at the same nestLevel and with the same name
		 * as each other. It might be worth revisiting this later to harden the
		 * uniqueness guaranteed by this function.
		 */
		protected function createMediatorName(viewComponent:Object, mediatorType:Class):String
		{
			if (!viewComponent)
				return 'invalid mediator name';
			
			var viewName:String = _reflector.getFQCN(viewComponent, true);
			
			if ('name' in viewComponent)
				viewName += '#' + viewComponent['name'];
			
			return _reflector.getFQCN(mediatorType, true) + " : " + viewName;
		}
	}
}