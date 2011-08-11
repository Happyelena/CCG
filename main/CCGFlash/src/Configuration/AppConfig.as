package Configuration
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.xml.XMLDocument;
	
	public class AppConfig
	{
		private static var appConfigSettings:Dictionary;
		
		private static var appConfig:AppConfig;
		
		private const ConfigFilePath:String="appConfig.xml";
		
		private static var loadCompletedTag:Boolean=false;
		
		public function AppConfig()
		{
			if(appConfig==null)
			{
				var appConfigReq:URLRequest=new URLRequest(ConfigFilePath);
				appConfigReq.contentType="text/xml";
				var appConfigLoader:URLLoader=new URLLoader( appConfigReq);
				var appConfigXml:XML=new XML(appConfigLoader.data);
				appConfigSettings=new Dictionary();
				for each(var item:XML in appConfigXml)
				{
					appConfigSettings[item.name]=item.value;
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
			return appConfigSettings[name];
		}
		
	}
}