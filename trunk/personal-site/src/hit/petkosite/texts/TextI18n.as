package hit.petkosite.texts
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class TextI18n extends EventDispatcher
	{
		private static var instance:TextI18n = new TextI18n();
		
		public function TextI18n()
		{
			
		}
		private static var mgr:IResourceManager;
		public static function init(manager:IResourceManager):void
		{
		}
		public static function getInstance():TextI18n{
			return instance;
		}
		public function changeLanguage(newLocale:String):void
		{
			var eventDispatcher:IEventDispatcher = ResourceManager.getInstance().loadResourceModule("Resources_" + newLocale + ".swf");
			// Search for the text string first in the locale just selected, but fallback on en_US
			var localeChain:Array = [newLocale, "en_US"];
			ResourceManager.getInstance().localeChain = localeChain;
			eventDispatcher.addEventListener(Event.COMPLETE, languageLoadCompleteHandler);
		}
		
		private function languageLoadCompleteHandler(event:Event):void {
			//trace("Language loaded.");
			instance.dispatchEvent( new Event( "textI18nChanged" ) );
		}
		
		[Bindable("textI18nChanged")]
		public function getText(id:String):String
		{
			return ResourceManager.getInstance().getString('mainBundle', id);
		} 
	}
}