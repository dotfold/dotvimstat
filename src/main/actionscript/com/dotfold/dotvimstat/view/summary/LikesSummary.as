package com.dotfold.dotvimstat.view.summary
{
	import com.dotfold.dotvimstat.view.IView;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import modena.core.Element;
	import modena.core.ElementContent;
	import modena.ui.Stack;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class LikesSummary extends Stack implements IView
	{
		public static const ELEMENT_NAME:String = "likesSummary";
		
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
			
			return content;
		}
		
		override public function validateRender():void
		{
			super.validateRender();
		}
	}
}