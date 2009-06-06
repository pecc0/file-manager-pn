// ActionScript file
//Paint Canvas

/*
 *	by Nikolay 
 */
 
 
import flash.events.*;
import mx.containers.Canvas;
import com.adobe.images.JPGEncoder;
import com.filemanagerpn.DialogFileSelectedEvent;
import com.filemanagerpn.SaveFileDialog;
import com.filemanagerpn.OpenSaveFileDialog;
import mx.controls.Alert;

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

	var jpgSource:BitmapData = new BitmapData (canvas_board.width, canvas_board.height);
	jpgSource.draw(canvas_board);

	var jpgEncoder:JPGEncoder = new JPGEncoder(85);
	var jpgStream:ByteArray = jpgEncoder.encode(jpgSource);
	
	var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
	var jpgURLRequest:URLRequest = new URLRequest("handlePainting.php?name=sketch.jpg");
	jpgURLRequest.requestHeaders.push(header);
	jpgURLRequest.method = URLRequestMethod.POST;
	jpgURLRequest.data = jpgStream;
	navigateToURL(jpgURLRequest, "_blank");
}

private function saveJPG():void {
//	var dlg:SaveFileDialog = SaveFileDialog.show(this);
//    dlg.addEventListener(OpenSaveFileDialog.FILESELECTED, onSaveDlg);
}
//
// private function onSaveDlg(event:DialogFileSelectedEvent):void {
//    //tova se izpylnqva kogato potrebitelq natisne "save"
//    Alert.show("result:" + event.file);
//} 

