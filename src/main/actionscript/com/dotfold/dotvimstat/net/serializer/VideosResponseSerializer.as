package com.dotfold.dotvimstat.net.serializer
{
	import asx.array.forEach;
	
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONDecoder;
	import com.dotfold.dotvimstat.model.VideoEntity;

	/**
	 * Response serializer for a list of videos.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class VideosResponseSerializer extends BaseSerializer implements IResponseSerializer
	{
		// TODO: return VideoCollection
		
		/**
		 * Serialize the response JSON data.
		 * @return Array of VideoEntity.
		 */
		public function serialize(data:*):*
		{
			var decoder:JSONDecoder = new JSONDecoder(data, true);
			var videos:* = decoder.getValue();
			
			var result:Array = [];
			
			forEach(videos, function(item:*):void
			{
				var entity:VideoEntity = new VideoEntity();
				serializeFieldsTo(item, entity);
				result.push(entity);	
			});
			
			return result;
		}
	}
}