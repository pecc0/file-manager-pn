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
	
		private function onOk(event:MouseEvent):void {
			fileName = DirListing.getPathToNode( view.listing.getSelectedDirectory()) + view.fileName.text;
			titleWindow_close(null);
		}
		
		private function titleWindow_close(evt:CloseEvent):void {
            PopUpManager.removePopUp(this);
        }

	}
}