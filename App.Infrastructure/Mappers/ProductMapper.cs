using App.Domain.Entities;
using App.Infrastructure.Dto;

namespace App.Infrastructure.Mappers
{
    public class ProductMapper : BaseMapper<Product, ProductItemDto>
    {
        private readonly CategoryMapper _categoryMapper;
        private readonly SizeMapper _sizeMapper;
        private readonly TagMapper _tagMapper;
        private readonly ReviewMapper _reviewMapper;

        public ProductMapper(CategoryMapper categoryMapper, SizeMapper sizeMapper, TagMapper tagMapper, ReviewMapper reviewMapper)
        {
            _categoryMapper = categoryMapper;
            _sizeMapper = sizeMapper;
            _tagMapper = tagMapper;
            _reviewMapper = reviewMapper;
        }

        public override ProductItemDto ToDto(Product entity)
        {
            return new ProductItemDto()
            {
                Id = entity.Id,
                Title = entity.Title,
                Price = entity.Price,
                Discount = entity.Discount,
                Sku = entity.Sku,
                Preview = entity.Preview
            };
        }

        public ProductDto ToViewDto(Product entity)
        {
            return new ProductDto()
            {
                Id = entity.Id,
                Title = entity.Title,
                Description = entity.Description,
                ShortDescription = entity.ShortDescription,
                Category = _categoryMapper.ToDto(entity.Category),
                Price = entity.Price,
                Discount = entity.Discount,
                Sku = entity.Sku,
                Tags = _tagMapper.ToDto(entity.Tags),
                Sizes = _sizeMapper.ToDto(entity.Sizes),
                Images = entity.Images.Select(x => x.Image),
                Reviews = _reviewMapper.ToDto(entity.Reviews)
            };
        }
    }
}
