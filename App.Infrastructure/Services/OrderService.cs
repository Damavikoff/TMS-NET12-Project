using App.Common.Exceptions;
using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using App.Infrastructure.Repositories;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using System;
using System.Net;

namespace App.Infrastructure.Services
{
    public class OrderService
    {
        private readonly OrderMapper _orderMapper;
        private readonly OrderItemMapper _orderItemMapper;
        private readonly UserInfoService _userInfoService;
        private readonly ShippingAddressService _shippingAddressService;
        private readonly OrderRepository _orderRepository;
        private readonly UserService _userService;
        private readonly CartService _cartService;

        public OrderService(OrderMapper orderMapper, OrderItemMapper orderItemMapper, UserInfoService userInfoService, ShippingAddressService shippingAddressService, OrderRepository orderRepository, UserService userService, CartService cartService)
        {
            _orderMapper = orderMapper;
            _orderItemMapper = orderItemMapper;
            _userInfoService = userInfoService;
            _shippingAddressService = shippingAddressService;
            _orderRepository = orderRepository;
            _userService = userService;
            _cartService = cartService;
        }

        public async Task<OrderDto> CreateOrder(OrderInfoDto data)
        {
            var cart = await _cartService.GetCartDto();
            var user = await _userService.GetCurrentUser();
            var shippingAddress = await _shippingAddressService.GetActualEntry(data.City,data.Address, data.Zip);
            var userInfo = await _userInfoService.GetActualEntry(data);
            var total = cart.Select(x => x.Price * x.Amount).Sum();
            var items = await _orderItemMapper.ToEntity(cart);
            var entry = new Order() {
                Number = GetDocNumber(),
                Total = total,
                Shipping = 16,
                Address = shippingAddress,
                UserInfo = userInfo,
                User = user,
                Description = data.Description,
                Items = items.ToList()
            };
            if (user != null)
                _userService.AddAdress(user, shippingAddress);
            await _orderRepository.SaveAsync(entry);
            _cartService.Clear();
            return _orderMapper.ToDto(entry);
        }

        private string GetDocNumber()
        {
            var rnd = new Random();
            return $"{rnd.Next(9999)}/{rnd.Next(999999)}-{rnd.Next(9)}";
        }

        public async Task<IEnumerable<OrderDto>> GetAllOrders()
        {
            var orders = await _orderRepository.GetAllOrderByUpdatedDesc();
            return _orderMapper.ToDto(orders);
        }

        public async Task SetState(Guid id, int state)
        {
            if (!Enum.IsDefined(typeof(OrderState), state))
                throw new AppException("Wron status code.", HttpStatusCode.BadRequest);
            var order = await _orderRepository.GetByIdAsync(id);
            order.State = (OrderState)state;
            await _orderRepository.SaveAsync(order);
        }
    }
}
