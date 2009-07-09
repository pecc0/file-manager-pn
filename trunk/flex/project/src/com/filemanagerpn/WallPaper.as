package com.filemanagerpn
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import mx.core.UIComponent;
	
	public class WallPaper
	{
		[Bindable]
        private var backgroundImage:Class;

		private var imageName:String;
		private var receiver:UIComponent;
		
	
		public function WallPaper(receiver:UIComponent)
		{
			this.receiver = receiver;
		}
		public function initWallPaper():void{
			var dataPost:DataPost = new DataPost(new URLVariables());
			dataPost.setUrl("/secure/getUserData.php");
			dataPost.onComplete = function(request:URLRequest, loader:URLLoader):void
			{
				//Alert.show("url:" + request.url + "\r\nResult="+loader.data);
				var result:String = loader.data;
				
				var userData:XML = new XML(result);
				var xmll:XMLList = userData.WallPaper;
				
				if (xmll.length() > 0) {
					imageName = xmll.text();
				} else {
					imageName = "";
				}
				load();
			}
			dataPost.doPost();
		}
		
		public function setWallPaper(name:String):void{
			imageName = name;
			load();
			storeWallPaper();
		}
		private function storeWallPaper():void {
			var dataPost:DataPost = new DataPost(new URLVariables());
			dataPost.getData().WallPaper = imageName;
			dataPost.setUrl("/secure/setUserData.php");
			dataPost.doPost();
		}
		private function load():void{
			
			if (imageName.length > 0){
				DataPost.createTempSession("download", imageName, onLoadSid);
			} else {
				receiver.setStyle("backgroundImage", "default");
				//receiver.setStyle("backgroundColor", "white");
				
			}
		}
		private function onLoadSid(aRequest:URLRequest, aLoader:URLLoader):void {
			var result:String = aLoader.data;
			if (result.substr(0, 6) == "error:") {
				
			} else if (result.length > 0) {
				receiver.clearStyle("backgroundImage");
				
				receiver.setStyle("backgroundImage", DataPost.getNonSecureUrl() + "/downloadFile.php?" + result);
				
   			}
		}
		
	}
}