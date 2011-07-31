package net.vis4.utils 
{
	import com.adobe.images.BitString;
	import com.adobe.images.PNGEncoder;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;

	/**
	 * ...
	 * @author gka
	 */
	public class FileUtil
	{
		
		public static function snapshot(obj:DisplayObject, scale:Number = 1):Bitmap
		{
			var bbox:Rectangle = obj.getBounds(obj);
			
			
			var frame:BitmapData = new BitmapData(bbox.width * scale, bbox.height * scale,true, 0x00ffffff);
			// obj.scaleX = obj.scaleY = scale;
			frame.draw(obj, new Matrix(scale, 0,0,scale, -bbox.left*scale, -bbox.top*scale));
			
			var bitmap:Bitmap = new Bitmap(frame);
			trace(bitmap.bitmapData.width, bitmap.bitmapData.height);
			return bitmap;
			
			//var png:ByteArray = PNGEncoder.encode(frame);
			//return null;
		}
		
		public static function write(filename:String, content:String):void
		{
			var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			var req:URLRequest = new URLRequest('http://localhost/fileUtil.php?name='+filename);
			req.requestHeaders.push(header);
			req.method = URLRequestMethod.POST;
			req.data = content;
			new URLLoader(req);
		}
		
		public static function writeBitmap(filename:String, content:Bitmap):void
		{
					var png:ByteArray = PNGEncoder.encode(content.bitmapData);
					var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			var req:URLRequest = new URLRequest('http://localhost/fileUtil.php?name='+filename);
			req.requestHeaders.push(header);
			req.method = URLRequestMethod.POST;
			req.data = png;
			new URLLoader(req);
		}
		
		public static function send(filename:String, content:String):void
		{
			var fileRef:FileReference = new FileReference();
			
			try {
				//fileRef.addEventListener(IOErrorEvent.IO_ERROR, onErr);
				//fileRef.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErr);
				//fileRef.download(req, 'export.png');
				//var name:String = 'parteispenden.png';
				//name = name.replace(/[^\w|\d]/g, "_").toLocaleLowerCase() + '.png';
				fileRef.save(content, filename);
				
				return;
			} catch (err:Error) {
				//addChild(new Label(err.getStackTrace(), new Verdana()));
			} //*/
		}
		
	}

}