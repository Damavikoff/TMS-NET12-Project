using App.Common;
using App.Common.Exceptions;
using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System.Net;

namespace App.Infrastructure.Services
{
    public class UserService
    {
        private readonly UserRepository _userRepository;
        private readonly ShippingAddressService _shippingAddressService;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UserService(UserRepository userRepository, ShippingAddressService shippingAddressService, IHttpContextAccessor httpContextAccessor)
        {
            _userRepository = userRepository;
            _shippingAddressService = shippingAddressService;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<User?> GetCurrentUser()
        {
            return await _userRepository._dbSet.Include(x => x.Orders.OrderByDescending(v => v.Created)).FirstOrDefaultAsync(x => x.Id == Guid.Parse("d9ec6e20-4c52-43fd-bfec-5bc16a74411d"));
            //var session = _httpContextAccessor.HttpContext?.Session;
            //var isSet = Guid.TryParse(session?.GetString("UserId"), out var userId);
            //if (!isSet) return null;
            //return await _userRepository.GetByIdAsync(userId);
        }

        public void AddAdress(User user, ShippingAddress address, bool update = false)
        {
            if (user.Addresses.Any(x => x.Id == address.Id)) return;
            if (update)
                user.ShippingAddress = address;
            user.Addresses.Add(address);
            _userRepository.Update(user);
        }

        public async Task<User?> GetByEmailLoginAsync(string login) {
            return await _userRepository._dbSet.FirstOrDefaultAsync(x => x.Login.ToLower() == login.ToLower());
        }

        public async Task<User> CreateUserFromAuthDataAsync(AuthDataDto data)
        {
            if (data.Email == null)
            {
                throw new AppException("Email is not provided", HttpStatusCode.BadRequest);
            }
            var user = new User()
            {
                Login = data.Login,
                Password = Utils.GetMD5Hash(data.Password),
                Info = new UserInfo()
                {
                    Email = data.Email
                }
            };
            await _userRepository.SaveAsync(user);
            return user;
        }

        public async Task Save(UserDto dto)
        {
            var user = await GetCurrentUser() ?? throw new AppException("Not authorized.", HttpStatusCode.Unauthorized);
            var info = dto.Info;
            if (info.FirstName == null) throw new AppException("First name is not set.", HttpStatusCode.Unauthorized);
            if (info.Phone == null) throw new AppException("Phone number is not set.", HttpStatusCode.Unauthorized);
            if (info.Email == null) throw new AppException("Email is not set.", HttpStatusCode.Unauthorized);
            var addressDto = dto.Address ?? throw new AppException("Address info is not provided", HttpStatusCode.BadRequest);
            if (addressDto.Street == null) throw new AppException("Address field is not populated", HttpStatusCode.BadRequest);
            var address = await _shippingAddressService.GetActualEntry(addressDto.City, addressDto.Street, addressDto.Zip);
            user.Info.FirstName = info.FirstName;
            user.Info.LastName = info.LastName;
            user.Info.Email = info.Email;
            user.Info.PhoneNumber = info.Phone;
            AddAdress(user, address, true);
            await _userRepository.SaveAsync(user);
        }
    }
}
