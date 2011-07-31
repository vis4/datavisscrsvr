package viz 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import data.types.RawData;
	import data.types.SNumber;
	import flash.display.Sprite;
	import net.vis4.text.fonts.embedded.QuicksandBold;
	import net.vis4.text.fonts.embedded.QuicksandLight;
	import net.vis4.text.Label;
	
	/**
	 * ...
	 * @author gka
	 */
	public class SingleNumber extends VizModule 
	{
		protected var no:SNumber;
		
		protected var _curNumber:Number;
		protected var noLabel:Label;
		
		public function SingleNumber(stage:Sprite, config:Object) 
		{
			super(stage, config);
			
		}
		
		override public function setData(data:RawData):void 
		{
			no = data as data.types.SNumber;
			
		}
		
		override public function fadeIn():void 
		{
			addTitle();
			addSubtitle();
			super.fadeIn();
			
			_curNumber = 0;
			
			noLabel = new Label(0, new QuicksandLight( { color: 0xffffff, size: 150 } ), 'center').place(_stage.stage.stageWidth * 0.5, _stage.stage.stageHeight * 0.5 - 70, _stage);
			
			TweenLite.from(noLabel, .9, { delay: 1.5, blurFilter: { blurX: 24, blurY: 24 }, alpha: 0} );
			TweenLite.to(this, 3, { delay: 1.5, curNumber: no.value, ease: Expo.easeOut } );
		}
		
		
		
		override public function fadeOut():void 
		{
			super.fadeOut();
			
			TweenLite.to(noLabel, .9, { delay: 0.1, blurFilter: { blurX: 24, blurY: 24 }, alpha: 0, onComplete: clean } );
			
			
		}
		
		public function get curNumber():Number 
		{
			return _curNumber;
		}
		
		public function set curNumber(value:Number):void 
		{
			_curNumber = value;
			noLabel.text = String(Math.round(value));
		}
		
		
	}

}