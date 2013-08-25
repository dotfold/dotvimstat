package com.dotfold.dotvimstat.net.serializer
{
	import asx.array.forEach;
	
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONDecoder;
	import com.dotfold.dotvimstat.model.BaseEntity;
	import com.dotfold.dotvimstat.model.VideoEntity;

	/**
	 *	Response serializer for a list of videos.
	 *  
	 * @author jamesmcnamee
	 * 
	 */	
	public class VideosResponseSerializer implements IResponseSerializer
	{
		/**
		 * Serialize the response JSON data.
		 * @return Array of VideoEntity.
		 */		
		public function serialize(data:*):*
		{
			var decoder:JSONDecoder = new JSONDecoder(data);
			var s:* = decoder.getValue();
			
			var result:Array = [];
			
			forEach(s, function(item:*):void
			{
				var entity:VideoEntity = serializeVideo(item);
				result.push(entity);	
			});
			
			return result;
			
		}
		
		/**
		 * @private
		 * Serializes and individual video item.
		 * @return VideoEntity
		 */		
		private function serializeVideo(item:*):VideoEntity
		{
			var entity:VideoEntity = new VideoEntity();
			
			for (var key:* in item)
			{
				if (entity.hasOwnProperty(key))
				{
					entity[key] = item[key]; 
				}
			}
			
			return entity;
		}
	}
}