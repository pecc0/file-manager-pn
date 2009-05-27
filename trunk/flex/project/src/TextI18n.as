package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * Text internationalization 
	 */
	 
	public class TextI18n extends EventDispatcher
	{
		private static var instance:TextI18n = new TextI18n();
		private var texts:XML;
		
		public function TextI18n()
		{
		}
		
		public static function getInstance():TextI18n{
			return instance;
		}
		
		/**
		 * Should be called after DataPost.setSetverUrl is called
		 */
		public static function init():void {
			var dataPost:DataPost = new DataPost(new URLVariables());
			dataPost.setUrlNonSecure("/texts.xml");
			dataPost.onComplete = function(request:URLRequest, loader:URLLoader):void
			{
				//Alert.show("url:" + request.url + "\r\nResult="+loader.data);
				var result:String = loader.data;
				//Alert.show(result);
				instance.texts = new XML(result);
				instance.dispatchEvent( new Event( "textI18nChanged" ) );
			}
			dataPost.doPost();
			
		}
		
		[Bindable("textI18nChanged")]
		public function getText(textId:String):String {
			if (texts != null) {
				var nodes:XMLList = texts.Text.(@id==textId);
				if (nodes.length() > 0) {
					return nodes[0].text();
				}
			}
			return textId;
		}
		
	}
}