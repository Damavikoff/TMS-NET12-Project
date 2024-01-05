using App.Domain.Entities;
using App.Infrastructure.Dto;

namespace App.Infrastructure.Mappers
{
    public class OrderMapper : BaseMapper<Order, OrderDto>
    {
        private readonly OrderItemMapper _orderItemMapper;
        private readonly ShippingAddressMapper _shippingAddressMapper;
        private readonly UserInfoMapper _userInfoMapper;

        public OrderMapper(OrderItemMapper orderItemMapper, ShippingAddressMapper shippingAddressMapper, UserInfoMapper userInfoMapper)
        {
            _orderItemMapper = orderItemMapper;
            _shippingAddressMapper = shippingAddressMapper;
            _userInfoMapper = userInfoMapper;
        }

        public override OrderDto ToDto(Order entity)
        {
            return new OrderDto()
            {
                Id = entity.Id,
                Number = entity.Number,
                State = (int)entity.State,
                Total = entity.Total,
                Shipping = entity.Shipping,
                PaymentMethod = (int)entity.PaymentMethod,
                Description = entity.Description,
                Created = entity.Created,
                Updated = entity.Updated,
                Items = _orderItemMapper.ToDto(entity.Items),
                UserInfo = _userInfoMapper.ToDto(entity.UserInfo),
                Address = _shippingAddressMapper.ToDto(entity.Address)
            };
        }
    }
}
