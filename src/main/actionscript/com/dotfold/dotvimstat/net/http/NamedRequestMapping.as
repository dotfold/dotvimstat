package com.dotfold.dotvimstat.net.http
{
	import com.dotfold.dotvimstat.net.serializer.IResponseSerializer;
	
	/**
	 * Simple model for mapping a named endpoint with a URL and ISerializer.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class NamedRequestMapping
	{
		/**
		 * The (internally) named enpoint. 
		 */
		public var name:String;
		
		/**
		 * The absolute URL of the remote endpoint.
		 */
		public var url:String;
		
		/**
		 * Sets the response serializer to use once the request is resolved.
		 */
		public function addReponseSerializer(serializer:IResponseSerializer):void
		{
			_serializer = serializer;
		}
		private var _serializer:IResponseSerializer;
		
		/**
		 * Serialize the resolved response.
		 */
		public function serialize(data:*):*
		{
			return _serializer.serialize(data);
		}
		
	}
}