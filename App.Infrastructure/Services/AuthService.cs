using App.Common;
using App.Common.Exceptions;
using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using System.Net;
using System.Security.Claims;

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

        private async Task Authenticate(User user)
        {
            var claims = new List<Claim>
            {
                new (ClaimTypes.Name, user.Login),
                new (ClaimTypes.Role, user.Role.ToString()),
            };

            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            var authProperties = new AuthenticationProperties
            {
                //AllowRefresh = <bool>,
                // Refreshing the authentication session should be allowed.

                //ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(10),
                // The time at which the authentication ticket expires. A 
                // value set here overrides the ExpireTimeSpan option of 
                // CookieAuthenticationOptions set with AddCookie.

                //IsPersistent = true,
                // Whether the authentication session is persisted across 
                // multiple requests. When used with cookies, controls
                // whether the cookie's lifetime is absolute (matching the
                // lifetime of the authentication ticket) or session-based.

                //IssuedUtc = <DateTimeOffset>,
                // The time at which the authentication ticket was issued.

                //RedirectUri = <string>
                // The full path or absolute URI to be used as an http 
                // redirect response value.
            };

            await _httpContextAccessor.HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity), authProperties);
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
            //_httpContextAccessor.HttpContext?.Session.SetString("UserId", user.Id.ToString());
            await Authenticate(user);
            return _userMapper.ToDto(user);
        }

        public async Task Logout()
        {
            await _httpContextAccessor.HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            // _httpContextAccessor.HttpContext?.Session.Remove("UserId");
        }

        public async Task<UserDto> Register(AuthDataDto data)
        {
            if (data.Login == null || data.Password == null)
            {
                throw new AppException("Login credentails are not fulfilled.", HttpStatusCode.BadRequest);
            }
            var user = await _userService.CreateUserFromAuthDataAsync(data);
            // _httpContextAccessor.HttpContext?.Session.SetString("UserId", user.Id.ToString());
            await Authenticate(user);
            return _userMapper.ToDto(user);
        }
    }
}
