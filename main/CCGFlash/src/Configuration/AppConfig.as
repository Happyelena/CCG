package Configuration
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	
	public class AppConfig
	{
		private static var appConfigSettings:Dictionary;
		
		private static var appConfig:AppConfig;
		
		private const ConfigFilePath:String="appConfig.xml";
		
		
		public function AppConfig()
		{
			if(appConfig==null)
			{
				var appConfigReq:URLRequest=new URLRequest(ConfigFilePath);
				appConfigReq.contentType="text/xml";
				var appConfigLoader:URLLoader=new URLLoader( appConfigReq);
				appConfigLoader.addEventListener(Event.COMPLETE,appConfigLoadCompletedEventHandler);
				
				function appConfigLoadCompletedEventHandler(e:Event):void
				{
					var appConfigXml:XML=new XML(appConfigLoader.data);
					appConfigSettings=new Dictionary();
					trace(appConfigXml.descendants("item").length());
					for each(var item:XML in appConfigXml.descendants("item"))
					{
						var name:String=item.@name;
						var value:String=item.@value;
						appConfigSettings[name]=value;
						trace(name);
						trace(value);
					}
				}
			}
			else
			{
				throw new Error("AppConfig 只能初始化一次");
			}
		}

		public static function GetAppConfigInstance():AppConfig
		{
			if(appConfig==null)
			{
				appConfig=new AppConfig();
			}
			return appConfig;
		}
		
		public static function GetAppSettings(name:String):String
		{
			trace(appConfigSettings[name]);
			return appConfigSettings[name];
		}
				
	}
}