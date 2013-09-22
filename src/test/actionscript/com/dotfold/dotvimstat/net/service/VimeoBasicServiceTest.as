package com.dotfold.dotvimstat.net.service
{
	import com.codecatalyst.promise.Deferred;
	import com.codecatalyst.promise.Promise;
	import com.dotfold.dotvimstat.net.http.HTTPClient;
	import com.dotfold.dotvimstat.net.http.NamedRequestMapping;
	
	import mockolate.received;
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
		
		[Mock]
		public var mapping:NamedRequestMapping;
		
		[Before]
		public function setup():void
		{
			mocks.stub(httpClient).method('mapUrl').anyArgs().returns(mapping);
			
			vimeoService = new VimeoBasicService();
			vimeoService.http = httpClient;
		}
		
		[Test]
		public function httpClientExists():void
		{
			assertThat(vimeoService.http, notNullValue());
		}
		
		//
		// Tests throw errors in cmd runner, however :
		// Context menu > Execute FlexUnit Tests will run them correctly
		//
		[Ignore(description="mocks are misbehaving, will talk to drew.")]
		[Test]
		public function getVideos_shouldReturnDeferred():void
		{
			mocks.stub(httpClient).method('get').anyArgs().returns(new Deferred().promise);
			var promise:Promise = vimeoService.getVideos();
			
			assertThat(promise, notNullValue());
		}
		
		[Ignore(description="mocks are misbehaving, will talk to drew.")]
		[Test]
		public function getVideos_shouldCallHttpClient():void
		{
			mocks.stub(httpClient).method('get').anyArgs().returns(new Deferred().promise);
			vimeoService.getVideos();
				
			assertThat(httpClient, received().method('get').once());
		}
	}
}