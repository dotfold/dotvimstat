package com.dotfold.dotvimstat.net.http
{
	import com.codecatalyst.promise.Deferred;
	import com.codecatalyst.promise.Promise;
	import com.dotfold.dotvimstat.tokenreplacement.replacetokens;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * Encapsulates the load process for the Moogaloop Flash player.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class MoogaloopLoader extends EventDispatcher
	{
		private static var URL_TEMPLATE:String = "http://api.vimeo.com/moogaloop_api.swf?oauth_key={oauth_key}&clip_id={videoId}&width={width}&height={height}&fullscreen=0&fp_version=10&api=1&cache_buster=" + new Date().time;
		
		private var _deferred:Deferred;
		
		private var _oauth:String;
		private var _width:int;
		private var _height:int;
		private var _videoId:int;
		
		/**
		 * Constructor.
		 */
		public function MoogaloopLoader()
		{
			super();
		}
		
		/**
		 * The OAuth Consumer Key to send with the moogaloop request.
		 */		
		public function withOAuth(value:String):MoogaloopLoader
		{
			_oauth = value;
			return this;
		}
		
		/**
		 * The desired player width to send with the moogaloop request.
		 */
		public function withWidth(value:int):MoogaloopLoader
		{
			_width = value;	
			return this;
		}
		
		/**
		 * The desired player height to send with the moogaloop request.
		 */
		public function withHeight(value:int):MoogaloopLoader
		{
			_height = value;
			return this;
		}
		
		/**
		 * Vimeo clip ID to load with the Player.
		 */
		public function withVideoId(value:int):MoogaloopLoader
		{
			_videoId = value;
			return this;
		}
		
		/**
		 * Creates the request and initiates the player load.
		 * 
		 * @return Promise
		 */
		public function load():Promise
		{
			_deferred = new Deferred();
			
			createRequestAndLoad();
			
			return _deferred.promise;
		}
		
		/**
		 * Creates the request URL and starts the load of the player SWF.
		 */		
		private function createRequestAndLoad():void
		{
			var replaceData:Object = {
				oauth_key: _oauth,
				width: _width,
				height: _height,
				videoId: _videoId
			}
			
			var url:String = replacetokens(URL_TEMPLATE, replaceData);
			var request:URLRequest = new URLRequest(url);
			
			var loaderContext:LoaderContext = new LoaderContext(true);
			
			var loader:Loader = new Loader();
			addListenersTo(loader.contentLoaderInfo);
			loader.load(request, loaderContext);
		}
		
		/**
		 * Adds listeners to supplied <code>LoaderInfo</code>.
		 */
		private function addListenersTo(loaderInfo:LoaderInfo):void
		{
			loaderInfo.addEventListener(Event.COMPLETE, playerLoadComplete);
			loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, playerLoadSecurityError);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, playerLoadIOError);	
		}
		
		/**
		 * Removes listeners from supplied <code>LoaderInfo</code>.
		 */		
		private function removeListenersFrom(loaderInfo:LoaderInfo):void
		{
			loaderInfo.removeEventListener(Event.COMPLETE, playerLoadComplete);
			loaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, playerLoadSecurityError);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, playerLoadIOError);
		}
		
		/**
		 * Moogaloop player load has completed. Resolve the Deferred.
		 */		
		private function playerLoadComplete(event:Event):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			removeListenersFrom(loaderInfo);
			_deferred.resolve(loaderInfo.content);
		}
		
		/**
		 * SecurityError encountered loading Moogaloop player. Reject the Deferred.
		 */
		private function playerLoadSecurityError(event:SecurityErrorEvent):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			removeListenersFrom(loaderInfo);
			_deferred.reject(event.text);
		}
		
		/**
		 * IOError encountered loading Moogaloop player. Reject the Deferred.
		 */
		private function playerLoadIOError(event:IOErrorEvent):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			removeListenersFrom(loaderInfo);
			_deferred.reject(event.text);
		}
		
	}
}