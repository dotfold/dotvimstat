package com.dotfold.dotvimstat.view.summary
{
	import com.dotfold.dotvimstat.view.IView;
	import com.dotfold.dotvimstat.view.animation.ElementAnimationSequencer;
	
	import modena.core.ElementContent;
	import modena.ui.HBox;
	import modena.ui.Label;
	
	/**
	 * VideosSummary view shows the count of videos retrieved from the Vimeo API.
	 * 
	 * @author jamesmcnamee
	 * 
	 */
	public class VideosSummary extends HBox implements IView
	{
		public static const ELEMENT_NAME:String = "videosSummary";
		
		private var _numVideos:Label;
		private var _staticText:Label;
		
		[Inject]
		public var animationQueue:ElementAnimationSequencer;
		
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
			
			_numVideos = new Label("summaryDetail");
			_numVideos.alpha = 0;
			
			_staticText = new Label("summarySmall");
			_staticText.text = "total videos";
			_staticText.alpha = 0;
			
			content.addChild(_numVideos);
			content.addChild(_staticText);
			
			return content;
		}
		
		/**
		 * Called from Mediator once data load is complete.
		 */
		public function show():void
		{
			runAnimationQueue();
		}
		
		/**
		 * Update the num videos label.
		 */
		public function set videosCount(value:int):void
		{
			_numVideos.text = value.toString();
			
			invalidateRender();
		}
		
		/**
		 * Add elements to the animation queue and start. 
		 */
		private function runAnimationQueue():void
		{
			animationQueue
				.addElement(_numVideos)
				.addElement(_staticText)
				.play();
		}
	}
}