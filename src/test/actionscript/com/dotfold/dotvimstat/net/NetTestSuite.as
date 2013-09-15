package com.dotvimstat.net
{
	import com.dotfold.dotvimstat.net.http.HTTPClientTest;
	import com.dotfold.dotvimstat.net.http.HTTPRequestTest;
	import com.dotfold.dotvimstat.net.http.NamedRequestMappingTest;
	import com.dotfold.dotvimstat.net.serializer.VideosResponseSerializerTest;
	import com.dotfold.dotvimstat.net.service.VimeoBasicServiceTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class NetTestSuite
	{
		// http
		public var httpClientTest:HTTPClientTest;
		public var httpRequestTest:HTTPRequestTest;
		public var namedRequestMappingTest:NamedRequestMappingTest;
		
		// serializer
		public var videosResponseSerializerTest:VideosResponseSerializerTest;
		
		// service
		public var vimeoBasicServiceTest:VimeoBasicServiceTest;
	}
}
