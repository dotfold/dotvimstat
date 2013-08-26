package com.dotfold.dotvimstat.net.serializer
{
	import asx.array.map;
	
	import com.dotfold.dotvimstat.model.BaseEntity;
	
	import flash.utils.describeType;

	/**
	 * Base serializer implementation using reflection
	 * to infer native AS3 types.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class BaseSerializer
	{
		/**
		 * Serializes an individual entity
		 * @return BaseEntity specialization
		 */
		public function serializeFieldsTo(fields:*, entity:BaseEntity):BaseEntity
		{
			for (var key:* in fields)
			{
				if (entity.hasOwnProperty(key))
				{
					var obj:* = unmarshallFieldByreflection(entity, fields, key);
					
					entity[key] = obj;
				}
			}
			
			return entity;
		}
		
		/**
		 * Infers the type from the model class by reflection and casts the
		 * serialized JSON value to that type.
		 */
		public function unmarshallFieldByreflection(entity:BaseEntity, fields:*, field:*):*
		{
			var _type:XML = describeType(entity);
			var fieldType:String;
			
			for each(var node:XML in _type..variable)
			{
				if (node.@name == field)
				{
					fieldType = String(node.@type).toLowerCase();
					break;
				}
			}
			
			if (!fieldType)
			{
				// try accessors
				for each(var acc:XML in _type..accessor)
				{
					if (node.@name == field)
					{
						fieldType = String(node.@type).toLowerCase();
						break;
					}
				}
			}
			
			var theValue:*
			switch (fieldType)
			{
				case 'number' :
					theValue = Number(fields[field]);
					break;
				
				case 'int' :
					theValue = parseInt(fields[field]);
					break;
				
				case 'date' :
					theValue = parseDate(fields[field]);
					break;
				
				case 'boolean' :
					theValue = Boolean(fields[field]);
					break;
				
				case 'string' :
					theValue = String(fields[field]);
					break;
				
				default: theValue = fields[field];	
			}
			
			return theValue;
			
		}
		
		/**
		 * Parse the Vimeo API date format to UTC so Flash can have a native Date.
		 */
		private function parseDate(dateStr:String):Date
		{
			var matches:Array = dateStr.match(/((\d){4}-(\d){2}-(\d){2})\s((\d){2}:(\d){2}:(\d){2})/);
			
			var date:Date = new Date();
			
			function asInt(item:*):int
			{
				return parseInt(item);
			}
			
			var fullyear:Array = map(matches[1].split('-'), asInt);
			var hours:Array = map(matches[5].split(':'), asInt);
			date.setUTCFullYear(fullyear[0], fullyear[1] - 1, fullyear[2]);
			date.setUTCHours(hours[0], hours[1], hours[2], 0);

			return date;
		}
	}
}