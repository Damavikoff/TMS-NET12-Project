using App.Domain.Entities;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Mvc;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("init")]
    public class InitControlles : ControllerBase
    {
        private readonly InitService _initService;

        public InitControlles(InitService initService)
        {
            _initService = initService;
        }

        [HttpGet]
        public IDictionary<string, object> GetInitData()
        {
            return _initService.GetInitData();
        }
    }
}
