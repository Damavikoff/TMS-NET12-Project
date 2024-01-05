using System.Net;

namespace App.Common.Exceptions
{
    public class AppException : Exception
    {
        public HttpStatusCode StatusCode { get; set; }
        public override string Message { get; }

        public AppException(string message, HttpStatusCode code) {
            this.Message = message;
            this.StatusCode = code;
        }
        public AppException(string message) : this(message, HttpStatusCode.InternalServerError) { }
    }
}
