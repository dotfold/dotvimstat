package com.dotfold.dotvimstat.net.http
{
	import com.codecatalyst.promise.Deferred;
	import com.codecatalyst.promise.Promise;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.system.LoaderContext;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	public class HTTPRequest
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(HTTPRequest);
		
		private var _url:String;
		private var _deferred:Deferred;
		private var _responseTransformerFunction:Function;
		
		/**
		 * Constructor.
		 */		
		public function HTTPRequest()
		{
			super();
			
			logger.debug('new HTTPRequest');
		}
		
		/**
		 * URL to call.
		 */		
		public function set url(value:String):void
		{
			_url = value;
			
			logger.debug('url set: {0}', _url);
		}
		
		/**
		 * If set, the raw response data will be passed to this function.
		 */		
		public function set responseTransformerFunction(value:Function):void
		{
			_responseTransformerFunction = value;
		}
		
		/**
		 * Builds a URLLoader.
		 */		
		protected function getLoader():URLLoader
		{
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			addLoaderListenersTo(loader);
			return loader;
		}
		
		/**
		 * Builds a URLRequest.
		 */		
		protected function getRequest():URLRequest
		{
			var request:URLRequest = new URLRequest();
			request.method = URLRequestMethod.GET;
			request.url = _url;
			
			return request;
		}
		
		/**
		 * 
		 */		
		public function send():Promise
		{
			logger.debug('send');
			
			_deferred = new Deferred();
			
			var loader:URLLoader = getLoader();
			var request:URLRequest = getRequest();
			loader.load(request);
			
			return _deferred.promise;
		}
		
		/**
		 * Add listeners to loader object.
		 */		
		private function addLoaderListenersTo(loader:URLLoader):void
		{
			loader.addEventListener(Event.OPEN, urlLoader_openHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, urlLoader_progressHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoader_httpStatusHandler);
			loader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_ioErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, urlLoader_securityErrorHandler);
		}
		
		/**
		 * Remove all listeners from the loader object.
		 */		
		private function removeLoaderListenersFrom(loader:URLLoader):void
		{
			loader.removeEventListener(Event.OPEN, urlLoader_openHandler);
			loader.removeEventListener(ProgressEvent.PROGRESS, urlLoader_progressHandler);
			loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoader_httpStatusHandler);
			loader.removeEventListener(Event.COMPLETE, urlLoader_completeHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, urlLoader_ioErrorHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, urlLoader_securityErrorHandler);
		}
		
		/**
		 * Loader complete.
		 */		
		private function urlLoader_completeHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			removeLoaderListenersFrom(loader);
			
			logger.debug('request complete');
			
			var result:* = loader.data;
//			var serializer:* = JSONResponseSerializer.unmarshall(result);
//			if ()
//			{
//				result = _responseTransformerFunction(result);
//			}
			
			_deferred.resolve(result);
		}
		
		/**
		 * HTTP Status.
		 */		
		private function urlLoader_httpStatusHandler(event:HTTPStatusEvent):void
		{
			logger.debug('request httpStatus: {0}', event.status);
		}
		
		/**
		 * IOError.
		 */		
		private function urlLoader_ioErrorHandler(event:IOErrorEvent):void
		{
			removeLoaderListenersFrom(event.target as URLLoader);
			
			logger.debug('request IOError: {0}', event.text);
			
			_deferred.reject(event);
		}
		
		/**
		 * HTTP opened.
		 */		
		private function urlLoader_openHandler(event:Event):void
		{
			logger.debug('http request opened');
		}
		
		/**
		 * Progress events.
		 */		
		private function urlLoader_progressHandler(event:ProgressEvent):void
		{
//			logger.debug('request progress {0} / {1}', event.bytesLoaded, event.bytesTotal);
		}
		
		/**
		 * Security error.
		 */		
		private function urlLoader_securityErrorHandler(event:SecurityErrorEvent):void
		{
			removeLoaderListenersFrom(event.target as URLLoader);
			
			logger.debug('request SecurityError: {0}', event.text);
			
			_deferred.reject(event);
		}
	}
}