package com.dotfold.dotvimstat.net.service
{
	import asx.object.merge;
	
	import com.codecatalyst.promise.Deferred;
	import com.codecatalyst.promise.Promise;
	import com.dotfold.dotvimstat.net.http.HTTPClient;
	import com.dotfold.dotvimstat.net.serializer.*;
	
	import flash.media.Video;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	/**
	 * Service layer handles communications with the Vimeo Basic API.
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class VimeoBasicService implements IVimeoService
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(VimeoBasicService);
		
		
		[Inject]
		/**
		 * HTTPClient used for API communications.
		 */		
		public function set http(value:HTTPClient):void
		{
			_http = value;
			initialiseMappings();
		}
		
		public function get http():HTTPClient
		{
			return _http;
		}
		
		private var _http:HTTPClient;
		
		/**
		 * Default name value pairs used in common URL endpoints. 
		 */		
		protected function get urlDefaults():Object
		{
			return {
				host: 'vimeo.com',
				application: 'api/v2',
				user: 'primarythreads'
			};
		}
		
		/**
		 * Constructor.
		 */		
		public function VimeoBasicService()
		{
			super();
		}
		
		/**
		 * Set up the named resource mappings on the HTTPClient.
		 */		
		private function initialiseMappings():void
		{
			http.mapUrl("videos", 
				merge(urlDefaults, {
					resource: 'videos.json'
				})
			)
			.addReponseSerializer(new VideosResponseSerializer())
			
			http.mapUrl("likes", 
				merge(urlDefaults, {
					resource: 'likes.json'
				})
			)
			.addReponseSerializer(new LikesResponseSerializer());
			
			http.mapUrl("activity", 
				merge(urlDefaults, {
					application: 'api/v2/activity',
					resource: 'user_did.json'
				})
			)
			.addReponseSerializer(new ActivityResponseSerializer());
			
			http.mapUrl("info", 
				merge(urlDefaults, {
					resource: 'info.json'
				})
			)
			.addReponseSerializer(new UserInfoResponseSerializer());
		}
		
		//
		//	API Endpoints
		//
		
		/**
		 * Retrieves the `info` for the set username.
		 */		
		public function getInfo():Promise
		{
			logger.debug('getInfo');
			
			return http.get("info");
		}
		
		/**
		 * Retrieves the `videos` listing for the set username.
		 */		
		public function getVideos():Promise
		{
			logger.debug('getVideos');
			
			return http.get("videos");
		}
		
		/**
		 * Retrieves the `likes` listing for the set username.
		 */		
		public function getLikes():Promise
		{
			logger.debug('getLikes');
			
			return http.get("likes");
		}
		
		/**
		 * Retrieves the user activity listing for the set username.
		 */		
		public function getActivity():Promise
		{
			logger.debug('getActivity');
			
			return http.get("activity");
		}
		
	}
}