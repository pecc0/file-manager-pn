﻿package  
{
	
	/**
	 * ...
	 * @author Petko
	 */
	public class DataPost
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
		private var request:URLRequest;
		
		public var onComplete:Function;
		
		private var loader:URLLoader;
		
		public function DataPost(dataSent:Object) 
		{
			
			request = new URLRequest();
			request.data = dataSent;
			loader = new URLLoader();
			onComplete = null;
		}
		
		public function setUrl(url:String):void
		{
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
		
		public function doPost():void
		{
			 request.method = URLRequestMethod.POST;

			 loader.addEventListener("complete", xmlLoaded);
			 configureListeners(loader);
			 
			 function xmlLoaded(event:Event):void
			 {
				//Alert.show("url:" + request.url + "\r\nResult="+loader.data);
				if (onComplete != null) 
				{
					onComplete(request, loader);
				}
			 }
			 loader.load(request);
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