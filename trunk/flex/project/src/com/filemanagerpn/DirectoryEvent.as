package com.filemanagerpn
{
	import flash.events.Event;

	public class DirectoryEvent extends Event
	{
		public var directory:XML;
		public function DirectoryEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}