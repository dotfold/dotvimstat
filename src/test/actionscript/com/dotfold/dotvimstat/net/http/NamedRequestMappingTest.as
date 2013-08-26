package com.dotfold.dotvimstat.net.http
{
	import com.dotfold.dotvimstat.net.serializer.VideosResponseSerializer;
	
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	
	import org.hamcrest.assertThat;

	public class NamedRequestMappingTest
	{
		[Rule]
		public var mocks:MockolateRule = new MockolateRule();
		
		[Mock]
		public var serializer:VideosResponseSerializer;
		
		public var mapping:NamedRequestMapping;
		
		[Before]
		public function setup():void
		{
			mapping = new NamedRequestMapping();
		}
		
		[Test]
		public function serialize_shouldCallSerializer():void
		{
			mapping.name = 'foo';
			mapping.url = 'http://foo.com';
			
			mapping.addReponseSerializer(serializer);
			mapping.serialize(null);
			
			assertThat(serializer, received().method('serialize').once());
		}
		
	}
}