package com.filemanagerpn
{
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	public class SaveFileDialog extends OpenSaveFileDialog
	{
		public function SaveFileDialog()
		{
			//onInit = init;
			super();
			title = "Save file";
			
		}
		
		public static function show(parent:UIComponent):void {
			var dlg:SaveFileDialog = new SaveFileDialog();
			OpenSaveFileDialog.show(parent, dlg);
		}
		protected override function init(event:FlexEvent):void
		{
			super.init(event);
			view.btnOk.label = "Save";
		}
		
	}
}