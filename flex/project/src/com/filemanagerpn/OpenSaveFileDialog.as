package com.filemanagerpn
{
	import flash.events.MouseEvent;
	
	import mx.containers.TitleWindow;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;

	public class OpenSaveFileDialog extends TitleWindow
	{
		protected var view:OpenSaveDialogModule;
		
		protected var fileName:String = null;
		
		public static const FILESELECTED:String="fileSelected";
		
		public function OpenSaveFileDialog()
		{
			super();
			view = new OpenSaveDialogModule();
			view.addEventListener(FlexEvent.CREATION_COMPLETE, init);
			
            showCloseButton = true;

			addEventListener(CloseEvent.CLOSE, titleWindow_close);
			addChild(view);
		}
		
		protected static function show(parent:UIComponent, dlg:TitleWindow):void {
			PopUpManager.addPopUp(dlg, parent, true);
            PopUpManager.centerPopUp(parent);
		}
		
		protected function init(event:FlexEvent):void
		{
			view.btnOk.addEventListener(MouseEvent.CLICK, onOk);
		}
		
		private function onFileOpen(event:DirectoryEvent):void {
			view.listing.removeEventListener(DirListing.LISTING_RECEIVED, onFileOpen);
			if (event.selectedFile != null && event.selectedFile.length > 0) {
				fileName = DirListing.getPathToNode( event.directory) + event.selectedFile;
				titleWindow_close(null);
				var e:DialogFileSelectedEvent = new DialogFileSelectedEvent(FILESELECTED);
				e.file = fileName;
				dispatchEvent(e);
			} else {
				view.fileName.text = "";
			}
		}
		
		private function onOk(event:MouseEvent):void {
			view.listing.addEventListener(DirListing.LISTING_RECEIVED, onFileOpen);
			view.listing.openFile(view.fileName.text);
		}
		
		private function titleWindow_close(evt:CloseEvent):void {
            PopUpManager.removePopUp(this);
        }

	}
}