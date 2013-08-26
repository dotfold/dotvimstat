package com.dotfold.dotvimstat.net.serializer
{
	import com.dotfold.dotvimstat.model.BaseEntity;

	/**
	 * ResponseSerializer handles data returned from the Vimeo API
	 * and parses to Model Entity Objects usable in the application.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public interface IResponseSerializer
	{
		/**
		 * Takes the raw data and parses it into a Model object.
		 */
		function serialize(data:*):*
	}
}