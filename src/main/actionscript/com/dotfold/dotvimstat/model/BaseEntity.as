package com.dotfold.dotvimstat.model
{
	/**
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
