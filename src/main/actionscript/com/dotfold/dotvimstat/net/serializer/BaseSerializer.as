package com.dotfold.dotvimstat.net.serializer
{
	import com.dotfold.dotvimstat.model.BaseEntity;

	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class BaseSerializer
	{
		/**
		 * @private
		 * Serializes and individual entity
		 * @return BaseEntity specialization
		 */		
		public function serializeFieldsTo(fields:*, entity:BaseEntity):BaseEntity
		{
			for (var key:* in fields)
			{
				if (entity.hasOwnProperty(key))
				{
					entity[key] = fields[key]; 
				}
			}
			
			return entity;
		}
	}
}