using App.Infrastructure.Dto;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Mvc;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("orders")]
    public class OrderController
    {
        private readonly OrderService _orderService;

        public OrderController(OrderService orderService)
        {
            _orderService = orderService;
        }

        [HttpPost]
        public async Task<OrderDto> AddOrder([FromBody] OrderInfoDto data)
        {
            return await _orderService.CreateOrder(data);
        }
    }
}
