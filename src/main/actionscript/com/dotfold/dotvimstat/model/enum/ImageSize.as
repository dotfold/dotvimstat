package com.dotfold.dotvimstat.model.enum
{
	/**
	 * Enum of availble Image sizes from the Vimeo API.
	 *
	 * @author jamesmcnamee
	 * 
	 */
	public class ImageSize extends Enum
	{
		public static const SMALL:ImageSize = new ImageSize('SMALL');
		public static const MEDIUM:ImageSize = new ImageSize('MEDIUM');
		public static const LARGE:ImageSize = new ImageSize('LARGE');
		public static const HUGE:ImageSize = new ImageSize('HUGE');
		
		/**
		 * ImageSize Enum.
		 */		
		public function ImageSize(name:String = null, ordinal:int=-1)
		{
			super(name, ordinal);
		}
	}
}