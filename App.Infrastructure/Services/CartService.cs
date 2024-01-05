using App.Infrastructure.Configuration;
using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using Microsoft.AspNetCore.Http;

namespace App.Infrastructure.Services
{
    public class CartService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly OrderItemMapper _orderItemMapper;
        private static IEnumerable<CartItemDto> _listus = new List<CartItemDto>();

        public CartService(IHttpContextAccessor httpContextAccessor, OrderItemMapper orderItemMapper)
        {
            _httpContextAccessor = httpContextAccessor;
            _orderItemMapper = orderItemMapper;
        }

        private IEnumerable<CartItemDto> GetCart()
        {
            // return _httpContextAccessor.HttpContext?.Session.Get<IEnumerable<CartItemDto>>("cart") ?? Enumerable.Empty<CartItemDto>();
            return _listus;
        }

        private void Save(IEnumerable<CartItemDto> items)
        {
            // _httpContextAccessor.HttpContext?.Session.Set("cart", items);
            _listus = items;
        }

        public async Task<IEnumerable<OrderItemDto>> GetCartDto()
        {
            return await _orderItemMapper.FromCartToDto(GetCart());
        }

        public async Task<IEnumerable<OrderItemDto>> Add(CartItemDto item, bool append)
        {
            var cart = GetCart();
            var existingItem = cart.FirstOrDefault(x => x.Product == item.Product && x.Size == item.Size);
            if (existingItem != null)
            {
                existingItem.Amount = append ? existingItem.Amount + item.Amount : item.Amount;
            }
            else
            {
                cart = cart.Append(item);
            }
            Save(cart);
            return await GetCartDto();
        }

        public void Remove(Guid product, Guid size)
        {
            var cart = GetCart().Where(x => x.Product != product || x.Size != size);
            Save(cart);
        }

        public void Clear()
        {
            Save(new List<CartItemDto>());
        }
    }
}
