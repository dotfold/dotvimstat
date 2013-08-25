package com.dotfold.dotvimstat.net.service
{
	import com.codecatalyst.promise.Deferred;
	import com.codecatalyst.promise.Promise;
	import com.dotfold.dotvimstat.net.http.HTTPClient;
	
	import mockolate.runner.MockolateRule;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.notNullValue;

	public class VimeoBasicServiceTest
	{
		
		public var vimeoService:VimeoBasicService;
		
		[Rule]
		public var mocks:MockolateRule = new MockolateRule();
		
		[Mock]
		public var httpClient:HTTPClient;
		
		[Before]
		public function setup():void
		{
			vimeoService = new VimeoBasicService();
			vimeoService.http = httpClient;
			
			mocks.stub(httpClient).method('mapUrl');
		}
		
		[Test]
		public function httpClientExists():void
		{
			assertThat(vimeoService.http, notNullValue());
		}
		
		[Test]
		public function getVideos_shouldReturnDeferred():void
		{
			var promise:Promise = vimeoService.getVideos();
			
			assertThat(promise, notNullValue());
		}
	}
}