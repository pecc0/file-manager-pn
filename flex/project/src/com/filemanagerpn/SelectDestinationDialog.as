package com.filemanagerpn
{
	import mx.containers.VBox;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	

	public class SelectDestinationDialog extends OpenSaveFileDialog
	{
		public function SelectDestinationDialog(enableMenu:Boolean=true)
		{
			super(enableMenu);
			title = TextI18n.getInstance().getText("selectDestination");;
		}
		private var sFile:String;
		public static function show(parent:UIComponent, startFile:String):SelectDestinationDialog {
			 
			var dlg:SelectDestinationDialog = new SelectDestinationDialog();
			dlg.sFile = startFile;
			OpenSaveFileDialog.show(parent, dlg);
			return dlg;
		}
		protected override function init(event:FlexEvent):void
		{
			super.init(event);
			view.btnOk.label = "Ok";
			view.listing.tileList.parent.removeChild(view.listing.tileList);
			((VBox) (view.listing.directoryTree.parent)).percentWidth=100;
			view.fileName.text = sFile;
		}
		protected override function checkFile(event:DirectoryEvent):Boolean{
			return event.selectedFile != null && event.selectedFile.length > 0;
		}
	}
}