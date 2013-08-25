package com.dotfold.dotvimstat.view.summary
{
	import com.dotfold.dotvimstat.view.IView;
	
	import modena.core.Element;
	
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class ActivitySummary extends Element implements IView
	{
		public static const ELEMENT_NAME:String = "activitySummary";
		
		/**
		 * Constructor.
		 */		
		public function ActivitySummary(styleClass:String = null)
		{
			super(styleClass);
		}
	}
}