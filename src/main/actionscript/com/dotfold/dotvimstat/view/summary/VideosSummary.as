package com.dotfold.dotvimstat.view.summary
{
	import asx.string.empty;
	
	import com.dotfold.dotvimstat.net.service.VimeoBasicService;
	import com.dotfold.dotvimstat.view.IView;
	import com.greensock.TweenLite;
	
	import modena.core.Element;
	import modena.core.ElementContent;
	import modena.ui.Label;
	
	/**
	 * VideosSummary view shows the count of videos retrieved from the Vimeo API.
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class VideosSummary extends Element implements IView
	{
		public static const ELEMENT_NAME:String = "videosSummary";
		
		private var _label:Label;
		
		/**
		 * Constructor.
		 */		
		public function VideosSummary(styleClass:String = null)
		{
			super(styleClass);
		}
		
		/**
		 * @inheritDoc
		 */		
		override protected function createElementContent():ElementContent
		{
			var content:ElementContent = super.createElementContent();
			
			_label = new Label("summaryCount");
			content.addChild(_label);
			_label.alpha = 0;
			
			return content;
		}
		
		/**
		 * Update the label with count of videos.
		 */		
		public function set videosCount(value:int):void
		{
			_label.text = value.toString();
			
			TweenLite.to(_label, 0.4, { alpha: 1, ease: 'easeInQuad' }); 
			invalidateRender();
		}
		
		override public function validateRender():void
		{
			super.validateRender();
			
			_label.x = (width - _label.width) / 2;
			_label.y = (height - _label.height) / 2;
		}
		
	}
}