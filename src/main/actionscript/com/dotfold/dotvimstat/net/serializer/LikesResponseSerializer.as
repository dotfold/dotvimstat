package com.dotfold.dotvimstat.net.serializer
{
	import asx.array.forEach;
	
	import com.adobe.serialization.json.JSONDecoder;
	import com.dotfold.dotvimstat.model.LikeEntity;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class LikesResponseSerializer extends BaseSerializer implements IResponseSerializer
	{
		
		/**
		 * 
		 */		
		public function serialize(data:*):*
		{
			var decoder:JSONDecoder = new JSONDecoder(data, true);
			var likes:* = decoder.getValue();
			
			var result:Array = [];
			
			forEach(likes, function(item:*):void
			{
				var entity:LikeEntity = new LikeEntity();
				serializeFieldsTo(likes, entity);
				result.push(entity);	
			});
			
			return result;
		}
	}
}