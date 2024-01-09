using App.Domain.Entities;
using App.Infrastructure.Dto;

namespace App.Infrastructure.Mappers
{
    public class UserMapper : BaseMapper<User, UserDto>
    {
        private readonly UserInfoMapper _userInfoMapper;
        private readonly ShippingAddressMapper _shippingAddressMapper;
        private readonly OrderMapper _orderMapper;

        public UserMapper(UserInfoMapper userInfoMapper, ShippingAddressMapper shippingAddressMapper, OrderMapper orderMapper)
        {   
            _userInfoMapper = userInfoMapper;
            _shippingAddressMapper = shippingAddressMapper;
            _orderMapper = orderMapper;
        }

        public override UserDto ToDto(User entity)
        {
            return new UserDto()
            {
                Id = entity.Id,
                Login = entity.Login,
                Role = (int)entity.Role,
                Info = _userInfoMapper.ToDto(entity.Info),
                Address = entity.ShippingAddress == null ? null : _shippingAddressMapper.ToDto(entity.ShippingAddress),
                Orders = _orderMapper.ToDto(entity.Orders)
            };
        }

        public UserItemDto? ToItemDto(User? entity)
        {
            if (entity == null) return null;

            return new UserItemDto()
            {
                Id = entity.Id,
                FirstName = entity.Info.FirstName,
                LastName = entity.Info.LastName,
                Image = entity.Image
            };
    }
    }
}
