package com.dotfold.dotvimstat.view.summary
{
	import com.dotfold.dotvimstat.net.service.VimeoBasicService;
	import com.dotfold.dotvimstat.view.IView;
	
	import modena.core.Element;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class VideosSummary extends Element implements IView
	{
		public static const ELEMENT_NAME:String = "videosSummary";
		
		[Inject]
		public var vimeoService:VimeoBasicService;
		
		/**
		 * Constructor.
		 */		
		public function VideosSummary(styleClass:String = null)
		{
			super(styleClass);
		}
	}
}