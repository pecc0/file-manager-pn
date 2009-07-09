package  com.filemanagerpn
{
	import flash.events.EventDispatcher;
	
	import mx.utils.URLUtil;
	
	
	/**
	 * General class used to make request to certain url on the server
	 * @author Petko
	 */
	public class DataPost extends EventDispatcher
	{
		import flash.events.Event;
		import flash.events.ProgressEvent;
		import flash.events.SecurityErrorEvent;
		import flash.events.HTTPStatusEvent;
		import flash.events.IOErrorEvent;
		import flash.events.IEventDispatcher;
		import flash.net.URLRequest;
		import flash.net.URLLoader;
		import flash.net.URLVariables;
		import flash.net.URLRequestMethod;
		import mx.rpc.events.ResultEvent;
		import mx.controls.Alert;
		
		//TODO: write getters and setters for these three
		//public var url:String;
		protected var request:URLRequest;
		
		public var onComplete:Function;
		
		private var loader:URLLoader;
		
		private static var serverUrl:String = null;
		
		private static var sessionId:String;
		
		public static function setSetverUrl(url:String):void {
			serverUrl = url;
		}
		public static function getNonSecureUrl():String {
			return "http://" + URLUtil.getServerNameWithPort(serverUrl);
		}
		public static function setSID(sid:String):void {
			sessionId = sid;
		}
		
		public function DataPost(dataSent:Object) 
		{
			request = new URLRequest();
			request.data = dataSent;
			loader = new URLLoader();
			onComplete = null;
		}
		
		public function setUrl(url:String):void
		{
			if (url.charAt(0) == "/") {
				url = serverUrl + url;
			}
			if (sessionId != null) {
				url = url + "?" + sessionId;
			}
			request.url = url;
		}
		
		/**
		 * setUrl for non-secure connection
		 */
		public function setUrlNonSecure(url:String):void {
			if (url.charAt(0) == "/") {
				url = getNonSecureUrl() + url;
			}
			request.url = url;
		}
		
		/**
		 * Returns the instance of request.data, so that it can be filled by the user
		 * This is the instance that have been passed to the constructor
		 * @return the instance of request.data
		 */
		public function getData():Object
		{
			return request.data;
		}
		
		public function set data(o:Object):void {
			request.data = o;
		}
		
		public function get requestHeaders():Array {
			return request.requestHeaders;
		}
		
		public function doPost():void
		{
			 request.method = URLRequestMethod.POST;
			 trace("Requesting: " + request.url);
			 loader.addEventListener("complete", xmlLoaded);
			 configureListeners(loader);
			 
			 function xmlLoaded(event:Event):void
			 {
				trace("Request returned: \n" + loader.data);
				//Alert.show("url:" + request.url + "\r\nResult="+loader.data);
				if (onComplete != null) 
				{
					onComplete(request, loader);
				}
			 }
			 loader.load(request);
		}
		
		/**
		 * Creates a temporary session for HTTP transfer
		 * @param aCommand A string that determines what will the session be used for
		 * @param aParameter Parameter for the command
		 * @param onSid A function that will be called when the new session ID is received
		 */
		public static function createTempSession(aCommand:String, aParameter:String, onSid:Function):void {
			var dataPost:DataPost = new DataPost(new URLVariables());
			dataPost.setUrl("/secure/createTempSession.php");
			dataPost.getData().command = aCommand;
			dataPost.getData().parameter = aParameter;
			dataPost.onComplete = onSid;
			dataPost.doPost();
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}

	
		private function openHandler(event:Event):void {
			trace("openHandler: " + event);
		}

		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}

		private function httpStatusHandler(event:HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
	}
	
}