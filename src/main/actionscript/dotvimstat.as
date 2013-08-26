package 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	[SWF(backgroundColor="#CCCCCC", width="906", height="480")]
	
	/**
	 * Entry point for the application.
	 *  
	 * @author jamesmcnamee
	 * 
	 */	
	public class dotvimstat extends MovieClip
	{
		private const APPLICATION_CLASS_NAME:String = "VimeoApplication";
		
		private var app:DisplayObject;
		
		
		/**
		 * Constructor.
		 */		
		public function dotvimstat()
		{
			super();
			
			waitForStage();
		}
		
		/**
		 * Wait for this element to be added to the Stage, if not already.
		 */		
		private function waitForStage():void
		{
			if (stage)
			{
				onAddedToStage();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}
		
		/**
		 * Once added to the Stage, start listening on EnterFrame for the main Application
		 * to be loaded completely.
		 */		
		private function onAddedToStage(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		/**
		 * Enterframe handler checks for main application load.
		 */		
		private function onEnterFrame(event:Event):void
		{
			var progress:Number = loaderInfo.bytesLoaded / loaderInfo.bytesTotal;
			
			if (framesLoaded == totalFrames)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				nextFrame();
				createApplication();
			}
		}
		
		/**
		 * Create the main Application class and add to the display list.
		 */		
		private function createApplication():void
		{
			var appClass:Class = Class(getDefinitionByName(APPLICATION_CLASS_NAME));
			app = new appClass();
			updateApplicationDimensions();
			addChildAt(app, 0);
		}
		
		/**
		 * In order for the Application to size itself correctly 
		 * its parent must have width and height. 
		 */		
		private function updateDimensions():void 
		{
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0, 0);
			g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			g.endFill();
		}
		
		/**
		 * Set the Application dimensions to full Stage.
		 */		
		private function updateApplicationDimensions():void 
		{
			if (parent is Stage)
			{
				switch (stage.displayState)
				{
					case StageDisplayState.FULL_SCREEN: 
						app.width = stage.fullScreenWidth;
						app.height = stage.fullScreenHeight;
						break;
					
					case StageDisplayState.NORMAL:
					default:
						app.width = stage.stageWidth;
						app.height = stage.stageHeight;
						break;
				}
				
				// call to modena element methods
				app['validateMetrics']();
				app['validateRender']();
			}
		}
	}
}