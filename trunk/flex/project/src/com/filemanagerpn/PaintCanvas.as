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

import flash.display.Loader;
import flash.events.*;
import flash.net.URLRequest;

import mx.containers.Canvas;
private var loader:Loader;
private var request:URLRequest;
		
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
	canvas_board.graphics.moveTo(e.target.mouseX,e.target.mouseY);
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

public function openFile(fname:String):void{
	if (fname.length > 0) {
		fileName = fname;
		DataPost.createTempSession("download", fileName, onOpenSid);
	}	
}

private function onOpenSid(aRequest:URLRequest, aLoader:URLLoader):void {
	loader = new Loader();
	request = new URLRequest(DataPost.getNonSecureUrl() + "/downloadFile.php?" + aLoader.data);
	loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onDownloadComplete);
	loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCatcher);
	loader.load(request);
}
private function errorCatcher(event:Event):void {
	fileName = "";
}
private function onDownloadComplete(event:Event):void {
	var width:Number = Math.min(loader.width, canvas_board.width);
	var height:Number = Math.min(loader.height, canvas_board.height);

	var source:BitmapData = new BitmapData(width, height);
	source.draw(loader);
	 
	canvas_board.graphics.beginBitmapFill( source, null, false, true);
	
	canvas_board.graphics.moveTo(0, 0);
    canvas_board.graphics.lineTo(0, height);
    canvas_board.graphics.lineTo(width, height);
    canvas_board.graphics.lineTo(width, 0);
    canvas_board.graphics.lineTo(0, 0);

	canvas_board.graphics.endFill();
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

