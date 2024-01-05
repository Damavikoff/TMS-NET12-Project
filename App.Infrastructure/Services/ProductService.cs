using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using App.Infrastructure.Miscellaneous;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Services
{
    public class ProductService
    {
        private readonly ProductRepository _productRepository;
        private readonly ProductMapper _productMapper;
        public ProductService(ProductRepository productRepository, ProductMapper productMapper)
        {
            _productRepository = productRepository;
            _productMapper = productMapper;
        }

        public async Task<ProductDto> Get(Guid id)
        {
            var product = await _productRepository.GetByIdAsync(id);
            var related = _productRepository._dbSet.Where(x => x.Category == product.Category && x != product).Take(5);
            var dto = _productMapper.ToViewDto(product);
            dto.Related = _productMapper.ToDto(related);
            return dto;
        }

        public async Task<PageDto<ProductItemDto>> GetItems(Guid? category, Guid? size, double? priceMin, double? priceMax, SortingColumn? sortBy, SortDirection? sortOrder, int limit, int page)
        {
            var query = GetPageQuery(category, size, priceMin, priceMax, sortBy, sortOrder);
            var resultPage = await _productRepository.GetPageAsync(page, limit, query);
            return new PageDto<ProductItemDto>() { Count = resultPage.OverallCount, Items = _productMapper.ToDto(resultPage.Entries) };
        }

        private IQueryable<Product> GetPageQuery(Guid? category, Guid? size, double? priceMin, double? priceMax, SortingColumn? sortBy, SortDirection? sortOrder)
        {
            var query = _productRepository._dbSet.AsQueryable();
            if (category != null)
                query = query.Where(x => x.Category.Id == category);
            if (size != null)
                query = query.Where(x => x.Sizes.Any(x => x.Id == size));
            if (priceMin != null)
                query = query.Where(x => (x.Price * (1 - 0.01 * (x.Discount ?? 0))) >= priceMin);
            if (priceMax != null)
                query = query.Where(x => (x.Price * (1 - 0.01 * (x.Discount ?? 0))) <= priceMax);

            if (sortBy == SortingColumn.Title)
            {
                query = _productRepository.Order(query, x => x.Title, sortOrder ?? SortDirection.Ascending);
            }
            else if (sortBy == SortingColumn.Price)
            {
                query = _productRepository.Order(query, x => (x.Price * (1 - 0.01 * (x.Discount ?? 0))), sortOrder ?? SortDirection.Ascending);
            }
            return query;
        } 
    }

    public enum SortingColumn
    {
        Title = 1,
        Price = 2
    }
}
