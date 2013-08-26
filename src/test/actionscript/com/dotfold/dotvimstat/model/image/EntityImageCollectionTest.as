package com.dotfold.dotvimstat.model.image
{
	import com.dotfold.dotvimstat.model.enum.ImageSize;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;

	public class EntityImageCollectionTest
	{
		
		public var collection:EntityImageCollection;
		
		private function buildImage(size:ImageSize):EntityImage
		{
			var img:EntityImage = new EntityImage();
			img.size = size;
			return img;
		}
		
		[Before]
		public function setup():void
		{
			collection = new EntityImageCollection();
		}
		
		[Test]
		public function addOne_shouldAddToList():void
		{
			var img:EntityImage = buildImage(ImageSize.SMALL);	
			collection.addItem(img);
			
			assertThat(collection.length, equalTo(1));
		}
		
		[Test]
		public function addMany_shouldAddToList():void
		{
			var img1:EntityImage = buildImage(ImageSize.SMALL);
			var img2:EntityImage = buildImage(ImageSize.MEDIUM);
			var img3:EntityImage = buildImage(ImageSize.LARGE);
			collection.addItem(img1);
			collection.addItem(img2);
			collection.addItem(img3);
			
			assertThat(collection.length, equalTo(3));
		}
		
		[Test]
		public function listShouldSortOnAdd():void
		{
			var img1:EntityImage = buildImage(ImageSize.SMALL);
			var img2:EntityImage = buildImage(ImageSize.MEDIUM);
			var img3:EntityImage = buildImage(ImageSize.LARGE);
			collection.addItem(img2);
			collection.addItem(img3);
			collection.addItem(img1);
			
			assertThat(collection.list, array([
				hasPropertyWithValue('dimension', 30),
				hasPropertyWithValue('dimension', 75),
				hasPropertyWithValue('dimension', 100)
				]));
		}
		
		[Test]
		public function getImageForSize_shouldReturnCorrectImage():void
		{
			var img1:EntityImage = buildImage(ImageSize.SMALL);
			var img2:EntityImage = buildImage(ImageSize.MEDIUM);
			var img3:EntityImage = buildImage(ImageSize.LARGE);
			collection.addItem(img2);
			collection.addItem(img3);
			collection.addItem(img1);
			
			var result:EntityImage = collection.getImageForSize(ImageSize.MEDIUM);
			assertThat(result.size, equalTo(ImageSize.MEDIUM));
			assertThat(result.dimension, equalTo(75));
		}
	}
}