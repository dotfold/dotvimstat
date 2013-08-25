package com.dotfold.dotvimstat.net.http
{
	import com.codecatalyst.promise.Promise;
	
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class HTTPClient
	{
		
		private static var logger:ILogger = LoggerFactory.getClassLogger(HTTPClient);
		
		private var _namedResourceMap:Dictionary;
		
		/**
		 * Constructor.
		 */		
		public function HTTPClient()
		{
			super();

			_namedResourceMap = new Dictionary();
		}
		
		/**
		 * Base URL to use for requests. If this is not replaced in a subclass the properties can be set using
		 * the standard replace functionality for a request
		 * i.e. data = { host: "vimeo.com", application: "api/v2", user: jamesmcnamee, resource: "info" }
		 */
		public var baseUrlTemplate:String = "http://{host}/{application}/{user}/{resource}";
		
		/**
		 * Returns the Dictionary of named resource mappings.
		 */		
		public function get namedResourceMap():Dictionary
		{
			return _namedResourceMap;
		}

		/**
		 * Map a named resource to a URL endpoint.
		 */		
		public function mapUrl(name:String, data:Object):NamedRequestMapping
		{
			var mapping:NamedRequestMapping = new NamedRequestMapping();
			var url:String = replaceNamedTokens(baseUrlTemplate, data);
			mapping.name = name;
			mapping.url = url;
			_namedResourceMap[name] = mapping;
			return mapping;
		}
		
		/**
		 * Replaces named token strings in a template string.
		 */		
		protected function replaceNamedTokens(template:String, data:Object):String
		{
			var pattern:RegExp = new RegExp('{([^}]+)}', 'gi');
			
			return template.replace(pattern, function(...rest):String { //match:String, $1:Object):String {
				
				var match:String = rest[0] as String;
				var token:String = rest[1] as String;
				
				// find the token vlaue in the object
				if (data && data.hasOwnProperty(token)) {
					return data[token];
				}
				// could not replace token, return token as is
				return match;
			});
		}
		
		/**
		 * Sends a GET request to the API.
		 * 
		 * @param resource String the name of the resource to retrieve from the mapping.
		 * 
		 * <listing version="3.0">
		 * 
		 * </listing>
		 */		
		public function get(resource:String, params:Object = null):Promise
		{
			var mappedTransform:NamedRequestMapping = _namedResourceMap[resource];
			
			return requestFor(resource)
				.send()
				.then(mappedTransform.serialize);
		}
		
		/**
		 * Retrieves the NamedRequestMapping for the resource name.
		 * @return HTTPRequest
		 */		
		protected function requestFor(resourceName:String):HTTPRequest
		{
			var mapping:NamedRequestMapping = _namedResourceMap[resourceName];
			if (!mapping)
			{
				throw new Error('');
			}
			
			var request:HTTPRequest = new HTTPRequest();
			request.url = mapping.url;
			
			return request;
		}
		
	}
}