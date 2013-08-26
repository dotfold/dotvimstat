package com.dotfold.dotvimstat.net.service
{
	import com.codecatalyst.promise.Promise;

	/**
	 * Interface defines the methods available in the base service.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public interface IVimeoService
	{
		function getInfo():Promise
		function getVideos():Promise
		function getLikes():Promise
		function getActivityDid():Promise
		function getActivityHappened():Promise
	}
}