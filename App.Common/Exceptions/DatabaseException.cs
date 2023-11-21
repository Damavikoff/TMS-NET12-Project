namespace App.Common.Exceptions
{
    public class DatabaseException : Exception
    {
        public override string Message { get; }

        public DatabaseException(string message) {
            this.Message = message;
        }
    }
}
