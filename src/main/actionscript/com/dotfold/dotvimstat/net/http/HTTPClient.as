package com.dotfold.dotvimstat.net.http
{
	import com.codecatalyst.promise.Promise;
	import com.dotfold.dotvimstat.tokenreplacement.replacetokens;
	
	import flash.utils.Dictionary;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	/**
	 * HTTPClient is the base class for generating HTTP requests.
	 * 
	 * Endpoints are mapped via this class and generate a named mapping,
	 * containing the information needed to make the request.
	 * 
	 * The only RESTful method implemented at this time is GET.
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class HTTPClient
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(HTTPClient);
		
		[Inject]
		public var httpRequestBuilder:HTTPRequestBuilder;
		
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
		public function replaceNamedTokens(template:String, data:Object):String
		{
			return replacetokens(template, data);
		}
		
		/**
		 * Sends a GET request to the API.
		 * 
		 * @param resource String the name of the resource to retrieve from the mapping.
		 * 
		 */
		public function get(resource:String, params:Object = null):Promise
		{
			var mapped:NamedRequestMapping = _namedResourceMap[resource];
			
			return requestFor(resource)
				.send()
				.then(mapped.serialize);
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
				var reason:String = "No mapping found for " + resourceName;
				throw new Error(reason);
			}
			
			var request:HTTPRequest = httpRequestBuilder.buildRequestFor(mapping.url);
			
			return request;
		}
		
	}
}