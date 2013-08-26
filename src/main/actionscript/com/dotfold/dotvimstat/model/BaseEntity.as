package com.dotfold.dotvimstat.model
{
	/**
	 * Base entity class defines common fields for entity classes.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class BaseEntity
	{
		/**
		 * Constructor.
		 */		
		public function BaseEntity()
		{
			super();
		}
		
		private var _id:int;
		
		/**
		 * ID value as set by Vimeo.
		 */
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
	}
}
