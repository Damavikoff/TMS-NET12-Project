using App.Domain.Entities;

namespace App.Infrastructure.Dto
{
    public class ProductDto
    {
        public Guid Id { get; set; }
        public DictionaryItemDto<Guid>? Category { get; set; } = null!;
        public string? Title { get; set; }
        public string? ShortDescription { get; set; }
        public string? Description { get; set; }
        public double Price { get; set; }
        public double? Discount { get; set; }
        public string? Sku { get; set; }
        public IEnumerable<SizeDto> Sizes { get; set; } = new List<SizeDto>();
        public IEnumerable<DictionaryItemDto<Guid>> Tags { get; set; } = new List<DictionaryItemDto<Guid>>();
        public IEnumerable<string> Images { get; set; } = new List<string>();
        public IEnumerable<ReviewDto> Reviews { get; set; } = new List<ReviewDto>();
        public IEnumerable<ProductItemDto> Related { get; set; } = new List<ProductItemDto>();
    }
}
