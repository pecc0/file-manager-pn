package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import mx.utils.StringUtil;
	
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
		
		/**
		 * Processes the input rich text ID and returns the corresponding localized string
		 * The rich ID is composed by a text ID and optionally one or more parameters enclosed
		 * in parenthesis e.g. badUser(Dancho) 
		 * 
		 */
		[Bindable("textI18nChanged")]
		public function getText(textRichId:String):String {
			//extract the text ID
			var idRegExp:RegExp = /^[a-zA-Z0-9]+/;
			var textId:String = idRegExp.exec(textRichId)[0];
		
			if (texts != null) {
				var nodes:XMLList = texts.Text.(@id==textId);
				if (nodes.length() > 0) {
					var text:String = nodes[0].text();
					
					//extract the parameters (they are enclosed in parenthesis)
					var paramsRegExp:RegExp = /\([^\)]+\)/;
					var parametersResult:Object = paramsRegExp.exec(textRichId);
					var parameters:Array = null;
					if (parametersResult != null) {
						var strParams:String = parametersResult[0];
						//remove the parenthesis
						strParams = strParams.substr(1, strParams.length - 2);
						parameters = strParams.split(",");
						for (var i:String in parameters) {
							parameters[i] = unescape(parameters[i]);
						}
						text = StringUtil.substitute(text, parameters);
					}
					
					
					return text;
				}
			}
			return textRichId;
		}
		
	}
}