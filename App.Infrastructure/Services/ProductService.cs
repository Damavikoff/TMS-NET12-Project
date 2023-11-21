using App.Domain.Entities;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Services
{
    public class ProductService
    {
        private readonly ProductRepository _productRepository;
        public ProductService(ProductRepository productRepository) {
            _productRepository = productRepository;
        }

        public Product Get(Guid id)
        {
            return _productRepository.GetById(id);
        }

        public IEnumerable<Product> Get()
        {
            return _productRepository.GetAll();
        }
    }
}
