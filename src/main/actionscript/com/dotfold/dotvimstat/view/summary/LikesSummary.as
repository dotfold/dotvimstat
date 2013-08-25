package com.dotfold.dotvimstat.view.summary
{
	import com.dotfold.dotvimstat.view.IView;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import modena.core.Element;
	import modena.core.ElementContent;
	import modena.ui.Label;
	import modena.ui.Stack;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class LikesSummary extends Stack implements IView
	{
		public static const ELEMENT_NAME:String = "likesSummary";
		
		private var _label:Label;
		
		/**
		 * Constructor.
		 */		
		public function LikesSummary(styleClass:String = null)
		{
			super(styleClass);
		}
		
		override protected function createElementContent():ElementContent
		{
			var content:ElementContent = super.createElementContent();
			
			_label = new Label("summaryCount");
			content.addChild(_label)
			
			return content;
		}
		
		/**
		 * 
		 */		
		public function set likesCount(value:int):void
		{
			_label.text = value.toString();	
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