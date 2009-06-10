// ActionScript file
//Paint Canvas

/*
 *	by Nikolay 
 */
 
 
import com.adobe.images.JPGEncoder;
import com.example.programmingas3.fileio.RawDataPost;
import com.filemanagerpn.DataPost;
import com.filemanagerpn.DialogFileSelectedEvent;
import com.filemanagerpn.OpenSaveFileDialog;
import com.filemanagerpn.SaveFileDialog;
import com.filemanagerpn.UploadDownloadDialog;

import flash.events.*;

import mx.containers.Canvas;

private function init(e:Event):void {
	//trace("init");
	var canvas:Canvas = Canvas(e.target); 
	canvas.graphics.lineStyle(2, 0xFFFF0000, 1);
	//canvas.graphics.beginFill(0xFF00FF, 1);
	canvas.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	canvas.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
}

private function onMouseDown(e:MouseEvent): void {
	//trace("onMouseDown")
	e.target.graphics.moveTo(e.target.mouseX,e.target.mouseY);
	e.target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
}

private function onMouseMove(e:MouseEvent): void {
	//trace("onMouseMove")
	//trace(e.target.mouseX,e.target.mouseY)
	e.target.graphics.lineTo(e.target.mouseX,e.target.mouseY);
}

private function onMouseUp(e:MouseEvent): void {
	//trace("onMouseUp")
	//e.target.graphics.endFill();
	e.target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
}

private function bitComSaveJPG() : void { 
	if (fileName.length > 0) {
		UploadDownloadDialog.show(this, "download", fileName);
	}
}

[Bindable]
private var fileName:String="";

private function saveAs():void {
	var sdlg:SaveFileDialog = SaveFileDialog.show(this);
	sdlg.addEventListener(OpenSaveFileDialog.FILESELECTED, onSaveDlg);
}

private function save():void {
	if (fileName.length == 0) {
		saveAs();
	} else {
		saveJPG(fileName);
	}
}

private function saveJPG(fileName:String):void {
	DataPost.createTempSession("imgsave", fileName, onSidReceived);	
}

private function onSaveDlg(event:DialogFileSelectedEvent):void {
	//fileName = event.file;
	saveJPG(event.file);
}

private function onSidReceived(aRequest:URLRequest, loader:URLLoader):void {
	var jpgSource:BitmapData = new BitmapData (canvas_board.width, canvas_board.height);
	jpgSource.draw(canvas_board);

	var jpgEncoder:JPGEncoder = new JPGEncoder(85);
	var jpgStream:ByteArray = jpgEncoder.encode(jpgSource);
	var dataPost:RawDataPost = new RawDataPost(new URLVariables());
	dataPost.data = jpgStream;
	dataPost.setUrlNonSecure("/handlePainting.php?" + loader.data);
	dataPost.onComplete = function (aRequest:URLRequest, loader:URLLoader):void {
		fileName = loader.data;
	}
	dataPost.doPost();
}
//
// private function onSaveDlg(event:DialogFileSelectedEvent):void {
//    //tova se izpylnqva kogato potrebitelq natisne "save"
//    Alert.show("result:" + event.file);
//} 

