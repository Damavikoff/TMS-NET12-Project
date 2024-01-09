using App.Infrastructure.Dto;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Mvc;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("app/user")]
    public class UserController
    {
        private readonly UserService _userService;

        public UserController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost]
        public async Task Save(UserDto data)
        {
            await _userService.Save(data);
        }
    }
}
