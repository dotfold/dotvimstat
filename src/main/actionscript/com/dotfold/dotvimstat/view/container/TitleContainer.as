package com.dotfold.dotvimstat.view.container
{
	import modena.core.ElementContent;
	import modena.ui.Label;
	import modena.ui.VBox;
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class TitleContainer extends VBox
	{
		/**
		 * Layout XML element name. 
		 */		
		public static const ELEMENT_NAME:String = "titleContainer";
		
		private var _title:Label;
		
		/**
		 * Constructor.
		 */		
		public function TitleContainer(styleClass:String = null)
		{
			super(styleClass);
		}
		
		/**
		 * @inheritDoc
		 * Creates the children used in the Element. 
		 */		
		override protected function createElementContent():ElementContent
		{
			var content:ElementContent = super.createElementContent();
			
			_title = new Label("summaryTitle");
			content.addChild(_title);
			
			return content;
		}
		
		/**
		 * Sets the title of the container. Typically set from layout via element factory.
		 * @param value String
		 * 
		 */		
		public function set title(value:String):void
		{
			_title.text = value;
		}
	}
}