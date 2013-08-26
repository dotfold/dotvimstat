package com.dotfold.dotvimstat.view.moogaloop
{
	import com.dotfold.dotvimstat.view.IView;
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import modena.core.ElementContent;
	import modena.ui.Label;
	import modena.ui.Stack;
	
	/**
	 * A view class to hold the moogaloop player.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class MoogaloopContainer extends Stack implements IView
	{
		public static const ELEMENT_NAME:String = "moogaloop";
		
		private var _loading:Label;
		private var _playerMask:Shape;
		
		/**
		 * Constructor.
		 */
		public function MoogaloopContainer(styleClass:String = null)
		{
			super(styleClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createElementContent():ElementContent
		{
			var content:ElementContent = super.createElementContent();
			
			_loading = new Label("moogaload");
			_loading.text = "Moogalooping a fresh player just for you";
			_loading.alpha = 0;
			
			_playerMask = new Shape();
			paintShape(_playerMask);

			content.addChild(_loading);
			
			return content;
		}
		
		/**
		 * Shows the loading message.
		 */
		public function enableLoadingState():void
		{
			_loading.includeInLayout = true;
			TweenLite.to(_loading, 0.4, { alpha: 1 });
		}
		
		/**
		 * Hides the loading message.
		 */
		public function disableLoadingState():void
		{
			function onComplete():void
			{
				_loading.includeInLayout = false;
			}
			TweenLite.to(_loading, 0.4, { alpha: 0, onComplete: onComplete });
		}
		
		/**
		 * Sets the player object and adds to the display list.
		 * @param value DisplayObject the Moogaloop player
		 */		
		public function setPlayer(value:DisplayObject):void
		{
			value.alpha = 0;
			content.addChild(value);
			
//			addChild(_playerMask);
//			mask = _playerMask;
			
			validationManager.validateNow();
			
			TweenLite.to(value, 0.4, { alpha: 1 });
		}
		
		/**
		 * Paints a <code>Shape</code> Graphics with fill.
		 */
		private function paintShape(element:Shape, color:uint = 0x000000, alpha:Number = 1):void
		{
			var g:Graphics = element.graphics;
			g.clear();
			g.beginFill(color, alpha);
			g.drawRect(0, 0, width, height);
			g.endFill();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function validateRender():void
		{
			super.validateRender();
			
			if (_loading.visible)
			{
				_loading.x = (width - _loading.width) / 2;
				_loading.y = (height - _loading.height) / 2;
			}
		}
	}
}