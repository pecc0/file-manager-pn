package com.example.programmingas3.fileio
{
	import com.filemanagerpn.DataPost;
	
	import flash.net.URLRequestHeader;

	public class RawDataPost extends DataPost
	{
		public function RawDataPost(dataSent:Object)
		{
			super(dataSent);
		}
		
		public override function doPost():void
		{
			request.requestHeaders.push(
				new URLRequestHeader("Content-type", "application/octet-stream"));
			super.doPost();
		}
	}
}