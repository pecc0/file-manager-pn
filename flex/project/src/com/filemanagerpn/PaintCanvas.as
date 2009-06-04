// ActionScript file
//Paint Canvas

/*
 *by Nikolay 
 */
 
import flash.events.*;
 
private function drawOnCanvas() : void { 
	import com.adobe.images.JPGEncoder;

	var jpgSource:BitmapData = new BitmapData (canvas_board.width, canvas_board.height);
	jpgSource.draw(canvas_board);

	var jpgEncoder:JPGEncoder = new JPGEncoder(85);
	var jpgStream:ByteArray = jpgEncoder.encode(jpgSource);
}

private function saveJPG() : void {
	
	var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
	var jpgURLRequest:URLRequest = new URLRequest("jpg_encoder_download.php?name=sketch.jpg");
	jpgURLRequest.requestHeaders.push(header);
	jpgURLRequest.method = URLRequestMethod.POST;
	jpgURLRequest.data = jpgStream;
	navigateToURL(jpgURLRequest, "_blank");
	
}
private function init(e:Event):void {
	canvas:Canavas = Canvas(e.target);
	
	canvas.graphics.beginFill(0xFF00FF, 1);
	canvas.graphics.lineStyle(2, 0xFF0000, 1);

	canvas.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	canvas.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
}

private function onMouseDown(e:MouseEvent):void {
	//trace("onMouseDown");
	e.target.graphics.moveTo(e.target.mouseX,e.target.mouseY);
	e.target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
}

private function onMouseMove(e:MouseEvent):void {
	//trace("onMouseMove");
	e.target.graphics.lineTo(e.target.mouseX,e.target.mouseY);
}

private function onMouseUp(e:MouseEvent):void {
	//trace("onMouseUp");
	e.target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
}


