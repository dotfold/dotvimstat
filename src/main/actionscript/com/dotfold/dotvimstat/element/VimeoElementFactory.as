package com.dotfold.dotvimstat.element
{
	import com.dotfold.dotvimstat.view.container.TitleContainer;
	import com.dotfold.dotvimstat.view.moogaloop.MoogaloopContainer;
	import com.dotfold.dotvimstat.view.summary.ActivitySummary;
	import com.dotfold.dotvimstat.view.summary.UserSummary;
	import com.dotfold.dotvimstat.view.summary.VideosSummary;
	
	import modena.app.DefaultElementFactory;
	import modena.core.Element;
	
	/**
	 * ElementFactory sets up specific Element mappings for this Application.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class VimeoElementFactory extends DefaultElementFactory
	{
		
		/**
		 * Constructor.
		 */
		public function VimeoElementFactory()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 *  
		 * Defines view mappings specific to this application.
		 */
		override protected function createTypeFactories():void
		{
			super.createTypeFactories();
			
			mapViewFactory(TitleContainer.ELEMENT_NAME, function(xml:XML):Element
			{
				var title:String = String(xml.@title);
				var containerElement:TitleContainer = new TitleContainer();
				containerElement.title = title;
				return containerElement;
			});
			
			mapView(UserSummary.ELEMENT_NAME, UserSummary);	
			mapView(VideosSummary.ELEMENT_NAME, VideosSummary);
			mapView(ActivitySummary.ELEMENT_NAME, ActivitySummary);
			mapView(MoogaloopContainer.ELEMENT_NAME, MoogaloopContainer);
		}
	}
}