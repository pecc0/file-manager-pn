package com.filemanagerpn
{
	import flash.events.Event;

	public class DialogFileSelectedEvent extends Event
	{
		public var file:String;
		public function DialogFileSelectedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}