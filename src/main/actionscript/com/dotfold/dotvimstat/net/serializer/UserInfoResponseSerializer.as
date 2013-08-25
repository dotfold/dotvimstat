package com.dotfold.dotvimstat.net.serializer
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.dotfold.dotvimstat.model.UserInfoEntity;

	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class UserInfoResponseSerializer extends BaseSerializer implements IResponseSerializer
	{
		/**
		 * @inheritDoc
		 */		
		public function serialize(data:*):*
		{
			var decoder:JSONDecoder = new JSONDecoder(data);
			var user:* = decoder.getValue();
			
			var entity:UserInfoEntity = new UserInfoEntity();
			serializeFieldsTo(user, entity);
			
			return entity;
		}
	}
}