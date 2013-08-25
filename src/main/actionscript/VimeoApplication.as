package
{
	import asx.fn.execute;
	
	import com.dotfold.dotvimstat.element.VimeoElementFactory;
	import com.dotfold.dotvimstat.manager.ViewManager;
	import com.dotfold.dotvimstat.net.http.HTTPClient;
	import com.dotfold.dotvimstat.net.service.IVimeoService;
	import com.dotfold.dotvimstat.net.service.VimeoBasicService;
	
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import modena.app.Application;
	import modena.app.Bootstrap;
	
	import org.swiftsuspenders.Injector;
	
	[SWF(backgroundColor="#CCCCCC", width="854", height="480")]
	
	/**
	 * 
	 * @author jamesmcnamee
	 * 
	 */	
	public class VimeoApplication extends Application
	{
		
		private var _injector:Injector;
		
		/**
		 * Constructor.
		 */		
		public function VimeoApplication()
		{
			super();
			
			initialise();
		}
		
		/**
		 * 
		 */		
		private function initialise():void
		{
			// run the initialise functions in sequence
			execute([
				[ waitForStage ],
				[ initialiseSecuritySettings ],
				[ initialiseContextMenu ],
				[ initialiseViewManager ],
				[ initialiseInjectorMappings ],
				[ initialiseView ],
				]);
		}
		
		//
		//
		//
		
		/**
		 * Wait for the Stage to become available.
		 */		
		private function waitForStage(next:Function):void
		{
			if (stage)
			{
				next();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, function(event:Event):void
				{
					removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
					next();
				});
			}
		}
		
		/**
		 * 
		 */		
		private function initialiseSecuritySettings(next:Function):void
		{
			Security.allowDomain("*");
//			Security.allowInsecureDomain("*");
			Security.loadPolicyFile('http://vimeo.com/crossdomain.xml');
			
			next();
		}
		
		/**
		 * Hide the builtins and show custom menu items for this app.
		 */		
		private function initialiseContextMenu(next:Function):void
		{
			var customMenu:ContextMenu = new ContextMenu();
			customMenu.hideBuiltInItems();
			
			var name:ContextMenuItem = new ContextMenuItem("© James McNamee 2013");
			var email:ContextMenuItem = new ContextMenuItem("jamesmcnamee@gmail.com");
			var github:ContextMenuItem = new ContextMenuItem("https://github.com/dotfold");
			
			name.enabled = false;
			
			email.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(event:ContextMenuEvent):void
			{
				navigateToURL(new URLRequest("mailto:jamesmcnamee@gmail.com"), "_blank");
			});
			
			github.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(event:ContextMenuEvent):void
			{
				navigateToURL(new URLRequest("https://github.com/dotfold"), "_blank");
			});
			
			customMenu.customItems = [ name, email, github ];
			contextMenu = customMenu;
			
			next();
		}
		
		private function initialiseViewManager(next:Function):void
		{
			const viewManager:ViewManager = ViewManager.getInstance();
			viewManager.stage = stage;
			
			next();
		}
		
		/**
		 * Create the Modena Bootstrap process.
		 */		
		private function initialiseView(next:Function):void
		{
			const elementFactory:VimeoElementFactory = new VimeoElementFactory();
			const bootstrap:Bootstrap = new Bootstrap(this);
			
			bootstrap.addEventListener(Event.COMPLETE, function(event:Event):void
			{
				trace('bootstrap complete');
				
				bootstrap.removeEventListener(Event.COMPLETE, arguments.callee);
				stage_resize();
				
				next();
			});
			
			bootstrap
				.setElementFactory(elementFactory)
				.setThemeManifestDefaults({
					cssURL: 'dotvimstat.css',
					localeURL: 'dotvimstat.properties',
					layoutURL: 'dotvimstat.xml'
				})
				.addTheme('theme/theme.zip')
				.execute();
			
			next();
		}
		
		/**
		 * 
		 */		
		private function initialiseInjectorMappings(next:Function):void
		{
			_injector = new Injector();
			
			ViewManager.getInstance().injector = _injector;
			
			_injector.map(ViewManager).toValue(ViewManager.getInstance());
			_injector.map(HTTPClient);
			_injector.map(IVimeoService).toType(VimeoBasicService);
			
			next();
		}
			
	}
}