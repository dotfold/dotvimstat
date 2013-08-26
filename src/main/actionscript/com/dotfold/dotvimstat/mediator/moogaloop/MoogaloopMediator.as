package com.dotfold.dotvimstat.mediator.moogaloop
{
	import com.codecatalyst.promise.Promise;
	import com.dotfold.dotvimstat.mediator.Mediator;
	import com.dotfold.dotvimstat.model.VideoEntity;
	import com.dotfold.dotvimstat.net.http.MoogaloopLoader;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.view.moogaloop.MoogaloopContainer;
	
	import flash.display.DisplayObject;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	
	/**
	 * Mediator class for MoogaloopContainer view.
	 * 
	 * Selects a random video from the first page of videos
	 * retrieved for the user.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class MoogaloopMediator extends Mediator
	{
		private static var logger:ILogger = LoggerFactory.getClassLogger(MoogaloopMediator);
		
		[Inject]
		public var service:IVimeoService;
		
		public var view:MoogaloopContainer;
		
		/**
		 * Constructor.
		 */
		public function MoogaloopMediator()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function init():void
		{
			view.enableLoadingState();
			
			loadVideos()
				.then(loadPlayerLib)
		}
		
		/**
		 * Loads the moogaloop player.
		 */
		private function loadPlayerLib(videos:Array):void
		{
			var videoId:int = getRandomVideo(videos)
			new MoogaloopLoader()
				.withOAuth('3befb4ee1c08ca0f2800703d7dcbd0b7dff30f02')
				.withWidth(view.width)
				.withHeight(view.height)
				.withVideoId(videoId)
				.load()
				.then(addMoogaloop, moogaloopLoadError)
		}
		
		/**
		 * Choose a random video from the returned Array.
		 */
		private function getRandomVideo(videos:Array):int
		{
			var index:int = Math.floor(Math.random() * videos.length);
			var video:VideoEntity = videos[index];
			
			return video ? video.id : 0;
		}
		
		/**
		 * Sets the player on the view.
		 */		
		private function addMoogaloop(player:DisplayObject):void
		{
			view.disableLoadingState();
			view.setPlayer(player);
		}
		
		/**
		 * Loads the 20 most recent videos from the Vimeo API.
		 */
		private function loadVideos():Promise
		{
			return service.getVideos()
		}
		
		/**
		 * Error encountered loading the player.
		 */
		private function moogaloopLoadError(error:*):void
		{
			logger.warn('Error loading Moogaloop from Vimeo');
		}
		
		/**
		 * Videos loaded successfully.
		 */
		private function videosLoaded():void
		{
			logger.debug('videos load success');
		}
		
		/**
		 * Error encountered loading the videos.
		 */
		private function videosLoadError(error:*):void
		{
			logger.warn('Error loading videos');
		}
	}
}