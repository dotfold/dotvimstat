package com.dotfold.dotvimstat.net.http
{
	import com.dotfold.dotvimstat.net.serializer.IResponseSerializer;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class NamedRequestMapping
	{
		/**
		 * 
		 */		
		public var name:String;
		
		/**
		 * 
		 */		
		public var url:String;
		
		/**
		 * 
		 */		
		public function addReponseSerializer(serializer:IResponseSerializer):void
		{
			_serializer = serializer;
		}
		private var _serializer:IResponseSerializer;
		
		/**
		 * 
		 */		
		public function serialize(data:*):*
		{
			return _serializer.serialize(data);
		}
		
	}
}