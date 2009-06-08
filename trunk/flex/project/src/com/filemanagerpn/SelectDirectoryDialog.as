package com.filemanagerpn
{
	import flash.events.MouseEvent;
	
	import mx.containers.VBox;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	public class SelectDirectoryDialog extends OpenSaveFileDialog
	{
		public function SelectDirectoryDialog(enableMenu:Boolean=true)
		{
			super(enableMenu);
			title = "Select Directory";
		}
		public static function show(parent:UIComponent):SelectDirectoryDialog {
			var dlg:SelectDirectoryDialog = new SelectDirectoryDialog();
			OpenSaveFileDialog.show(parent, dlg);
			return dlg;
		}
		protected override function init(event:FlexEvent):void
		{
			super.init(event);
			view.btnOk.label = "OK";
			view.fileName.parent.removeChild(view.fileName);
			view.listing.tileList.parent.removeChild(view.listing.tileList);
			((VBox) (view.listing.directoryTree.parent)).percentWidth=100;
			view.btnOk.addEventListener(MouseEvent.CLICK, onOk);
			
		}
		
		private function onOk(event:MouseEvent):void {
			titleWindow_close(null);
			var e:DialogFileSelectedEvent = new DialogFileSelectedEvent(FILESELECTED);
			e.direvent = null;
			e.file = DirListing.getPathToNode( view.listing.getSelectedDirectory() );
			dispatchEvent(e);
		}
		
		protected override function checkFile(event:DirectoryEvent):Boolean{
			return event.selectedFile != null && event.selectedFile.length > 0;
		}
	}
}