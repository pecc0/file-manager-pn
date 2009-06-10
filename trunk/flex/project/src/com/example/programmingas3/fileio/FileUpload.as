package com.example.programmingas3.fileio {
    import com.filemanagerpn.DataPost;
    
    import flash.events.*;
    import flash.net.FileReference;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    
    import mx.controls.Button;
    import mx.controls.ProgressBar;

    public class FileUpload extends DataPost {
        // Hard-code the URL of the remote upload script.
        private const UPLOAD_URL:String = "http://www.yourdomain.com/upload_script.cfm";
        private var fr:FileReference;
        // Define reference to the upload ProgressBar component.
        private var pb:ProgressBar;
        // Define reference to the "Cancel" button which will immediately stop the upload in progress.
        private var btn:Button;

        public function FileUpload() {
        	super(new URLVariables());
        }

		/**
         * Set references to the components, and add listeners for the SELECT,
         * OPEN, PROGRESS, and COMPLETE events.
         */
        public function init(pb:ProgressBar, btn:Button):void {
            // Set up the references to the progress bar and cancel button, which are passed from the calling script.
            this.pb = pb;
            this.btn = btn;
            
            fr = new FileReference();
            fr.addEventListener(Event.SELECT, selectHandler);
            fr.addEventListener(Event.CANCEL, completeHandler);
            fr.addEventListener(Event.OPEN, openHandler);
            fr.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            fr.addEventListener(Event.COMPLETE, completeHandler);
            
            startUpload();
        }

        /**
         * Immediately cancel the upload in progress and disable the cancel button.
         */
        public function cancelUpload():void {
            fr.cancel();
//            pb.label = "UPLOAD CANCELLED";
            btn.enabled = false;
            dispatchEvent(new Event(Event.COMPLETE));
        }

        /**
         * Launch the browse dialog box which allows the user to select a file to upload to the server.
         */
        public function startUpload():void {
            fr.browse();
        }

        /**
         * Begin uploading the file specified in the UPLOAD_URL constant.
         */
        private function selectHandler(event:Event):void {
			createTempSession("upload", fr.name + fr.size, onSidReceived);
        }
        
		private function onSidReceived(aRequest:URLRequest, loader:URLLoader):void {
			var result:String = loader.data;
			if (result.substr(0, 6) == "error:") {
				
			} else if (result.length > 0) {
				setUrlNonSecure("/receiveFile.php?" + result);
				request.method = URLRequestMethod.POST;
				trace ("File uploaded to " + request.url);
	            fr.upload(request);
   			}
		}
		
        /**
         * When the OPEN event has dispatched, change the progress bar's label 
         * and enable the "Cancel" button, which allows the user to abort the 
         * upload operation.
         */
        private function openHandler(event:Event):void {
//            pb.label = "UPLOADING";
            btn.enabled = true;
        }

        /**
         * While the file is uploading, update the progress bar's status and label.
         */
        private function progressHandler(event:ProgressEvent):void {
//            pb.label = "UPLOADING %3%%";
            pb.setProgress(event.bytesLoaded, event.bytesTotal);
        }

        /**
         * Once the upload has completed, change the progress bar's label and 
         * disable the "Cancel" button since the upload is already completed.
         */
        private function completeHandler(event:Event):void {
//            pb.label = "UPLOADING COMPLETE";
            pb.setProgress(0, 100);
            btn.enabled = false;
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}