package com.dotfold.dotvimstat.net.http
{
	/**
	 * Helper class to build HTTPRequests
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class HTTPRequestBuilder
	{
		/**
		 * Returns a new HTTPRequest
		 */
		public function buildRequestFor(url:String):HTTPRequest
		{
			const request:HTTPRequest = new HTTPRequest();
			request.url = url;
			return request;
		}
		
	}
}