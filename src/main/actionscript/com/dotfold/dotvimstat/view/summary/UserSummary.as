package com.dotfold.dotvimstat.view.summary
{
	import com.dotfold.dotvimstat.model.UserInfoEntity;
	import com.dotfold.dotvimstat.model.image.EntityImage;
	import com.dotfold.dotvimstat.view.IView;
	import com.greensock.TweenLite;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import modena.core.Element;
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
		
		private var _userNameLabel:Label;
		
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
			content.addChild(_loader);
			
			_userNameLabel = new Label("titleLabel");
			content.addChild(_userNameLabel);
			
			return content;
		}
		
		private var _loader:Loader;
		
		/**
		 * 
		 */		
		public function set displayName(value:String):void
		{
			_userNameLabel.text = value;
			
			invalidateRender();
		}
		
		public function set image(value:EntityImage):void
		{
			loadUserImage(value.url);
		}
		
		private function loadUserImage(url:String):void
		{
			_loader.alpha = 0;
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			_loader.load(new URLRequest(url));

		}
		
		private function loadComplete(event:Event):void
		{
			validationManager.validateNow();
			
			var mask:Shape = new Shape();
			var g:Graphics = mask.graphics;
			g.clear();
			g.beginFill(0x00ff00, 0.0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			content.addChild(mask);
			_loader.mask = mask;
			
			_loader.x = 0;
			_loader.y = 0;
			
			TweenLite.to(_loader, 0.6, { alpha: 0.7 });
			
			var overlay:Shape = new Shape();
			g = overlay.graphics;
			g.clear();
			g.beginFill(0x000000, 0.5);
			g.drawRect(0, 0, width, height);
			g.endFill();
			content.addChildAt(overlay, 1);
		}
		
		/**
		 * 
		 */		
		override public function validateRender():void
		{
			super.validateRender();
		}
	
	}
}