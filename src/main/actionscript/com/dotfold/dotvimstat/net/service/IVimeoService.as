package com.dotfold.dotvimstat.net.service
{
	import com.codecatalyst.promise.Promise;

	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public interface IVimeoService
	{
		function getInfo():Promise
		function getVideos():Promise
		function getLikes():Promise
		function getActivity():Promise
	}
}