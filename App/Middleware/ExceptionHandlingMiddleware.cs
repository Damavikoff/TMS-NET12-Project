using App.Common.Exceptions;

namespace PlantsStore.Middleware
{
    public class ExceptionHandlingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ExceptionHandlingMiddleware> _logger;

        public ExceptionHandlingMiddleware(RequestDelegate next, ILogger<ExceptionHandlingMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                await HandleExceptionAsync(context, ex);
            }
        }

        private async Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            var status = 500;
            if (exception is AppException ex)
            {
                status = (int)ex.StatusCode;
            }
            else
            {
                _logger.LogError(exception, "An unexpected error occurred.");
            }

            context.Response.StatusCode = status;
            await context.Response.WriteAsync(exception.Message);
        }
    }
}
