package com.dotfold.dotvimstat.view.summary
{
	import com.dotfold.dotvimstat.model.image.EntityImage;
	import com.dotfold.dotvimstat.view.IView;
	import com.dotfold.dotvimstat.view.animation.ElementAnimationSequencer;
	import com.dotfold.dotvimstat.view.event.UserSummaryEvent;
	
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import modena.core.ElementContent;
	import modena.ui.Label;
	import modena.ui.Stack;
	
	/**
	 * Displays the User name and profile picture.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class UserSummary extends Stack implements IView
	{
		public static const ELEMENT_NAME:String = "userSummary";
		
		[Inject]
		public var animationQueue:ElementAnimationSequencer;
		
		private var _userNameLabel:Label;
		private var _loader:Loader;
		
		/**
		 * Constructor.
		 */
		public function UserSummary()
		{
			super();
		}
		
		/**
		 * @inheritDocs
		 */
		override protected function createElementContent():ElementContent
		{
			var content:ElementContent = super.createElementContent();
			
			_loader = new Loader();
			_loader.alpha = 0;
			
			_userNameLabel = new Label("titleLabel");
			_userNameLabel.alpha = 0;
			
			setupClickHandler();

			mouseEnabled = true;
			buttonMode = true;
			useHandCursor = true;
			
			content.addChild(_loader);
			content.addChild(_userNameLabel);
			
			return content;
		}
		
		/**
		 * Update the username label text.
		 */
		public function set displayName(value:String):void
		{
			_userNameLabel.text = value;
			
			invalidateRender();
		}
		
		/**
		 * Sets the image URL and triggers the load operation for the image.
		 */
		public function set image(value:EntityImage):void
		{
			loadUserImage(value.url);
		}
		
		/**
		 * Set up the <code>MouseEvent</code> handler on the click element.
		 */
		private function setupClickHandler():void
		{
			addEventListener(MouseEvent.CLICK, elementClickHandler);
		}
		
		/**
		 * Dispatches <code>UserSummaryEvent.VISIT_PROFILE</code> to Mediator.
		 */
		private function elementClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new UserSummaryEvent(UserSummaryEvent.VISIT_PROFILE));
		}
		
		/**
		 * Loads the user image.
		 */
		private function loadUserImage(url:String):void
		{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			_loader.load(new URLRequest(url));
		}
		
		/**
		 * Add elements to the sequencer and start animation.
		 */
		private function animateElements():void
		{
			animationQueue
				.addElement(_loader)
				.addElement(_userNameLabel)
				.play();
		}
		
		/**
		 * Image load completed successfully. Sets up mask and
		 * adds to the display list.
		 */
		private function loadComplete(event:Event):void
		{
			validationManager.validateNow();
			
			var imageIndex:int = getChildIndex(_loader);
			
			var mask:Shape = new Shape();
			paintShape(mask);
			
			content.addChildAt(mask, imageIndex);
			_loader.mask = mask;
			
			_loader.x = 0;
			_loader.y = 0;
			
			var overlay:Shape = new Shape();
			paintShape(overlay, 0x000000, 0.5);
			
			content.addChildAt(overlay, getChildIndex(_userNameLabel));
			
			animateElements();
		}
		
		/**
		 * Paints a <code>Shape</code> Graphics with fill.
		 */
		private function paintShape(element:Shape, color:uint = 0x000000, alpha:Number = 0.0):void
		{
			var g:Graphics = element.graphics;
			g.clear();
			g.beginFill(color, alpha);
			g.drawRect(0, 0, width, height);
			g.endFill();
		}
		
	}
}