package com.dotfold.dotvimstat.net.http
{
	import asx.array.toArray;
	import asx.object.isA;
	
	import flash.utils.Dictionary;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class HTTPClientTest
	{
		
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
		public function mapUrl_shouldMapNamedUrl():void
		{
			httpClient.mapUrl('foo', {
				host: 'vimeo.com',
				application: 'api/v2',
				user: 'primarythreads',
				resource: 'videos.json'
			});
			
			var resource:String = httpClient.namedResourceMap['foo'];
			var expected:String = 'https://vimeo.com/api/v2/primarythreads/videos.json';
			
			assertThat(resource, equalTo(expected));
		}
	}
}