package com.dotfold.dotvimstat.net.serializer
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.dotfold.dotvimstat.model.UserInfoEntity;

	/**
	 * Serialize the User Info response data.
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class UserInfoResponseSerializer extends BaseSerializer implements IResponseSerializer
	{
		/**
		 * @inheritDoc
		 * @return UserInfoEntity
		 */
		public function serialize(data:*):*
		{
			var decoder:JSONDecoder = new JSONDecoder(data, true);
			var user:* = decoder.getValue();
			
			var entity:UserInfoEntity = new UserInfoEntity();
			serializeFieldsTo(user, entity);
			
			return entity;
		}
	}
}