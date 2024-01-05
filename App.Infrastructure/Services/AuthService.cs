using App.Common;
using App.Common.Exceptions;
using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using Microsoft.AspNetCore.Http;
using System.Net;

namespace App.Infrastructure.Services
{
    public class AuthService
    {
        private readonly UserService _userService;
        private readonly UserMapper _userMapper;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public AuthService (UserService userService, UserMapper userMapper, IHttpContextAccessor httpContextAccessor)
        {
            _userService = userService;
            _userMapper = userMapper;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<UserDto> Login(AuthDataDto data)
        {
            if (data.Login == null || data.Password == null)
            {
                throw new AppException("Login credentails are not fulfilled.", HttpStatusCode.BadRequest);
            }
            var user = await _userService.GetByEmailLoginAsync(data.Login);
            if (user == null || user.Password.ToLower() != Utils.GetMD5Hash(data.Password).ToLower())
            {
                throw new AppException("Invalid login or password.", HttpStatusCode.BadRequest);
            }
            _httpContextAccessor.HttpContext?.Session.SetString("UserId", user.Id.ToString());
            return _userMapper.ToDto(user);
        }

        public void Logout()
        {
            _httpContextAccessor.HttpContext?.Session.Remove("UserId");
        }

        public async Task<UserDto> Register(AuthDataDto data)
        {
            if (data.Login == null || data.Password == null)
            {
                throw new AppException("Login credentails are not fulfilled.", HttpStatusCode.BadRequest);
            }
            var user = await _userService.CreateUserFromAuthDataAsync(data);
            _httpContextAccessor.HttpContext?.Session.SetString("UserId", user.Id.ToString());
            return _userMapper.ToDto(user);
        }
    }
}
