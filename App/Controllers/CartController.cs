using App.Infrastructure.Dto;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Mvc;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("app/cart")]
    public class CartController
    {
        private readonly CartService _cartService;

        public CartController(CartService cartService)
        {
            _cartService = cartService;
        }


        [HttpPost]
        public async Task<IEnumerable<OrderItemDto>> AddToCart([FromBody] CartItemDto item, [FromQuery] bool append = true)
        {
            return await _cartService.Add(item, append);
        }

        [HttpDelete]
        [Route("{product}/{size}")]
        public void Remove([FromRoute] Guid product, [FromRoute] Guid size)
        {
            _cartService.Remove(product, size);
        }
    }
}
