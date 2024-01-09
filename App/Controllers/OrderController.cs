using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("app/orders")]
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

        [Authorize(Roles = nameof(UserRole.Admin))]
        [HttpPost]
        [Route("state/{id}/{state}")]
        public async Task SetState([FromRoute] Guid id, [FromRoute] int state)
        {
            await _orderService.SetState(id, state);
        }
    }
}
