package com.dotfold.dotvimstat.net.serializer
{
	import com.dotfold.dotvimstat.model.BaseEntity;

	public interface IResponseSerializer
	{
		function serialize(data:*):*
	}
}