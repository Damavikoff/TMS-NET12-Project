using System.Security.Cryptography;
using System.Text;

namespace App.Common
{
    public static class Utils
    {
        public static string GetMD5Hash(string value)
        {
            var hash = MD5.HashData(Encoding.UTF8.GetBytes(value));
            return BitConverter.ToString(hash).Replace("-", String.Empty).ToLower();
        }
    }
}
