using App.Common.Exceptions;
using App.Infrastructure.Dto;
using App.Infrastructure.Miscellaneous;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Mvc;
using System.Net;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("products")]
    public class ProductController
    {
        private readonly ProductService _productService;
        private readonly ReviewService _reviewService;

        public ProductController(ProductService productService, ReviewService reviewService) {
            _productService = productService;
            _reviewService = reviewService;
        }
        [HttpGet]
        public async Task<PageDto<ProductItemDto>> GetAll(
                                                [FromQuery] Guid? category,
                                                [FromQuery] Guid? size,
                                                [FromQuery] double? priceMin,
                                                [FromQuery] double? priceMax,
                                                [FromQuery] SortingColumn? sortBy,
                                                [FromQuery] SortDirection? sortOrder,
                                                [FromQuery] int limit,
                                                [FromQuery] int page
                                              )
        {
            return await _productService.GetItems(category, size, priceMin, priceMax, sortBy, sortOrder, limit, page);
        }

        [HttpGet]
        [Route("{id}")]
        public async Task<ProductDto> Get([FromRoute] Guid id)
        {
            return await _productService.Get(id);
        }

        [HttpPost]
        [Route("{id}/feedback")]
        public async Task<ReviewDto> AddFeedBack([FromRoute] Guid id, [FromBody] ReviewDto review)
        {
            return await _reviewService.AddReview(id, review);
        }
    }
}
