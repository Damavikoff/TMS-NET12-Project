using Microsoft.Extensions.Configuration;

namespace App.Common
{
    public class ConfigProvider
    {
        public static IConfigurationRoot FromJson(string path)
        {
           return new ConfigurationBuilder().AddJsonFile(path).Build();
        }
    }
}
