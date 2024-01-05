using App.Common.Exceptions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace PlantsStore.Filters
{
    public class ApplicationExceptionFilter : IActionFilter, IOrderedFilter
    {
        public int Order => int.MaxValue - 10;

        public void OnActionExecuting(ActionExecutingContext context) { }

        public void OnActionExecuted(ActionExecutedContext context)
        {
            if (context.Exception is AppException exception)
            {
                context.Result = new ObjectResult(exception.Message)
                {
                    StatusCode = (int)exception.StatusCode
                };
                context.ExceptionHandled = true;
            }
        }
    }
}
