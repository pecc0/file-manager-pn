package com.filemanagerpn
{
	import flash.events.Event;
	
	import mx.containers.TitleWindow;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;

	public class UploadDownloadDialog extends TitleWindow
	{
		private var view:FileUploadDownload;
		
		[Bindable]
		public var serverFile:String;
		
		public function UploadDownloadDialog()
		{
			super();
			view = new FileUploadDownload();
			addEventListener(CloseEvent.CLOSE, titleWindow_close);
			addChild(view);
		}
		protected function titleWindow_close(evt:CloseEvent):void {
            PopUpManager.removePopUp(this);
        }
        
        public static function show(parent:UIComponent, type:String, serverFile:String):UploadDownloadDialog {
        	var dlg:UploadDownloadDialog = new UploadDownloadDialog();
        	var worker:DataPost;
        	switch (type) {
        		case "upload":
        			worker = dlg.view.fileUpload;
        		break;
        		case "download":
        			dlg.view.downloadFile = serverFile;
        			worker = dlg.view.fileDownload;
        		break;
        		 
        	}
        	worker.addEventListener(Event.COMPLETE, dlg.completeHandler);
        	worker.getData().serverfile = serverFile;
        	dlg.view.currentState = type;
        	
			PopUpManager.addPopUp(dlg, parent, true);
            PopUpManager.centerPopUp(dlg);
            return dlg;
		}
		
		private function completeHandler(event:Event):void {
			titleWindow_close(null);
			dispatchEvent(new Event( Event.COMPLETE ));
		}
	}
}