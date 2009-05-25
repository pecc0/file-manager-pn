// ActionScript file

import com.adobe.images.JPGEncoder;
import flash.net.URLRequest;
function sendFile():void {
	var jpgSource:BitmapData = new BitmapData (100, 50);
	jpgSource.draw(sketch_mc);
	
	var jpgEncoder:JPGEncoder = new JPGEncoder(85);
	var jpgStream:ByteArray = jpgEncoder.encode(jpgSource);
	 
	var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
	var jpgURLRequest:URLRequest = new URLRequest("jpg_encoder_download.php?name=sketch.jpg");
	jpgURLRequest.requestHeaders.push(header);
	jpgURLRequest.method = URLRequestMethod.POST;
	jpgURLRequest.data = jpgStream;
	navigateToURL(jpgURLRequest, "_blank");
}