using App.Domain.Entities;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Mvc;

namespace PlantsStore.Controllers
{
    [ApiController]
    [Route("product")]
    public class ProductController
    {
        private readonly ProductService _productService;
        public ProductController(ProductService productService) {
            _productService = productService;
        }

        [HttpGet]
        public IEnumerable<Product> Get()
        {
            return _productService.Get();
        }

        [HttpGet]
        [Route("{id}")]
        public Product Get([FromRoute] Guid id)
        {
            return _productService.Get(id);
        }
    }
}
