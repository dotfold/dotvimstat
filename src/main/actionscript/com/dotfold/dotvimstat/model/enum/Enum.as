package com.dotfold.dotvimstat.model.enum
{
	import flash.utils.Dictionary;
	
	/**
	 * Defines an Enum.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class Enum
	{
		private static var _nextOrdinal:int = -1;
		
		private var _name:String;
		private var _ordinal:int;
		
		/**
		 * Constructor.
		 *
		 * @param stringValue String to associate with the Enum instance, cast from intValue if not given.
		 * @param intValue Integer to associate with the Enum instance, generated if not given.
		 */
		public function Enum(name:String = null, ordinal:int = -1)
		{
			super();
			
			_ordinal = ordinal == -1 ? ++_nextOrdinal : ordinal;
			_name = name ? name : String(ordinal);
		}
		
		/**
		 * Returns the name of this Enum instance.
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * Returns the ordinal value for this Enum instance.
		 * Use for ordering Enum instances in a collection.
		 */
		public function get ordinal():int
		{
			return _ordinal;
		}
		
		/**
		 * String representation of this Enum.
		 */
		public function toString():String
		{
			return _name;
		}
	}
}