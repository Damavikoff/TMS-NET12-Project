using App.Domain.Entities;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("app/init")]
    public class InitControlles : ControllerBase
    {
        private readonly InitService _initService;

        public InitControlles(InitService initService)
        {
            _initService = initService;
        }

        [HttpGet]
        public async Task<IDictionary<string, object?>> GetInitData()
        {
            return await _initService.GetInitData();
        }

        [Authorize(Roles = nameof(UserRole.Admin))]
        [HttpGet]
        [Route("admin")]
        public async Task<IDictionary<string, object>> GetAdminData()
        {
            return await _initService.GetAdminChunk();
        }
    }
}
