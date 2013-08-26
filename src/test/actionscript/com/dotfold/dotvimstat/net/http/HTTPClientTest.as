package com.dotfold.dotvimstat.net.http
{
	import asx.array.toArray;
	import asx.fn.callFunction;
	import asx.object.isA;
	
	import com.codecatalyst.promise.Deferred;
	import com.codecatalyst.promise.Promise;
	
	import flash.utils.Dictionary;
	
	import mockolate.mock;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	
	public class HTTPClientTest
	{
		[Rule]
		public var mocks:MockolateRule = new MockolateRule();
		
		[Mock]
		public var builder:HTTPRequestBuilder;
		
		[Mock]
		public var request:HTTPRequest;
		
		public var httpClient:HTTPClient;
		
		[Before]
		public function setup():void
		{
			httpClient = new HTTPClient();
		}
		
		[Test]
		public function namedResourceMap_shouldReturnEmptyDictionary():void
		{
			assertThat(httpClient.namedResourceMap, isA(Dictionary));
			assertThat(toArray(httpClient.namedResourceMap).length, equalTo(0));
		}
		
		[Test]
		public function mapUrl_shouldReturnMapping():void
		{
			var result:NamedRequestMapping = httpClient.mapUrl('foo', {
				host: 'vimeo.com',
				application: 'api/v2',
				user: 'primarythreads',
				resource: 'videos.json'
			});
			
			assertThat(result, notNullValue());
		}
		
		[Test]
		public function mapUrl_shouldPopulateDictionary():void
		{
			var result:NamedRequestMapping = httpClient.mapUrl('foo', {
				host: 'vimeo.com',
				application: 'api/v2',
				user: 'primarythreads',
				resource: 'videos.json'
			});
			
			var resource:String = httpClient.namedResourceMap['foo'];
			
			assertThat(resource, notNullValue());
		}
		
		[Test]
		public function mapUrl_shouldPopulateUrl():void
		{
			var result:NamedRequestMapping = httpClient.mapUrl('foo', {
				host: 'vimeo.com',
				application: 'api/v2',
				user: 'primarythreads',
				resource: 'videos.json'
			});
			
			var resource:String = httpClient.namedResourceMap['foo'];
			var expected:String = 'http://vimeo.com/api/v2/primarythreads/videos.json';
			
			assertThat(result.url, equalTo(expected));
		}
		
		[Test]
		public function mapUrl_shouldHaveCorrectName():void
		{
			var result:NamedRequestMapping = httpClient.mapUrl('foo', {
				host: 'vimeo.com',
				application: 'api/v2',
				user: 'primarythreads',
				resource: 'videos.json'
			});
			
			assertThat(result.name, equalTo('foo'));
		}
		
		[Test]
		public function replaceNamedTokens_shouldReplaceAllNamed():void
		{
			var template:String = 'http://{url}/{endpoint}';
			var data:Object = {
				url: 'foo.com',
				endpoint: 'froogs.json'
			};
				
			var expected:String = 'http://foo.com/froogs.json';
			var result:String = httpClient.replaceNamedTokens(template, data);
			
			assertThat(result, equalTo(expected));
		}
		
		[Test]
		public function replaceNamedTokens_shouldLeaveUnmatched():void
		{
			var template:String = '{protocol}://{url}/{endpoint}';
			var data:Object = {
				url: 'foo.com',
				endpoint: 'froogs.json'
			};
			
			var expected:String = '{protocol}://foo.com/froogs.json';
			var result:String = httpClient.replaceNamedTokens(template, data);
			
			assertThat(result, equalTo(expected));
		}
		
		[Ignore(description="mocks are misbehaving, will talk to drew.")]
		[Test]
		public function get_shouldCallSendOnRequest():void
		{
			mocks.stub(request).method('send').returns(new Deferred().promise);
			
			mocks.stub(builder)
				.method('buildRequestFor')
				.anyArgs()
				.returns(request);
			
			httpClient.httpRequestBuilder = builder; 
			
			httpClient.mapUrl('foo', {
				host: 'vimeo.com',
				application: 'api/v2',
				user: 'primarythreads',
				resource: 'videos.json'
			});
			
			httpClient.get('foo');
			assertThat(request, received().method('send').once());
		}
		
		[Test]
		public function get_withNoMapping_shouldThrowError():void
		{
			mocks.stub(request).method('send').returns(new Deferred().promise);
			
			mocks.stub(builder)
				.method('buildRequestFor')
				.anyArgs()
				.returns(request);
			
			httpClient.httpRequestBuilder = builder; 
			
			assertThat(
				callFunction(httpClient, 'get', [ 'foo' ]),
				throws(instanceOf(Error)));
		}
	}
}