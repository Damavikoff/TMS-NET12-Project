using App.Infrastructure.Dto;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Mvc;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("app/auth")]
    public class AuthController
    {
        private readonly AuthService _authService;

        public AuthController(AuthService authService)
        {
            _authService = authService;
        }

        [HttpPost]
        [Route("login")]
        public async Task<UserDto> Login([FromBody] AuthDataDto data)
        {
            return await _authService.Login(data);
        }

        [HttpPost]
        [Route("logout")]
        public void Logout()
        {
            _authService.Logout();
        }

        [HttpPost]
        [Route("register")]
        public async Task<UserDto> Register([FromBody] AuthDataDto data)
        {
            return await _authService.Register(data);
        }
    }
}
