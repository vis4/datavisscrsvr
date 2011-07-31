package net.vis4.text 
{
	import flash.events.FocusEvent;
	import flash.text.TextField;
	//import net.vis4.managers.UsabilityManager;
	
	public class UsableTextField extends TextField
	{
		
		public function UsableTextField() 
		{
			super();
			
			addEventListener(FocusEvent.FOCUS_IN, focusChange);
			addEventListener(FocusEvent.FOCUS_OUT, focusChange);
		}
		
		private function focusChange(e:FocusEvent):void 
		{
			//UsabilityManager.KEEP_FOCUS = e.type == FocusEvent.FOCUS_IN;
		}
			
	}

}