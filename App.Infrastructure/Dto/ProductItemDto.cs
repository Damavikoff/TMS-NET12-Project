namespace App.Infrastructure.Dto
{
    public class ProductItemDto
    {
        public Guid Id { get; set; }
        public string? Title { get; set; }
        public double Price { get; set; }
        public string? Sku { get; set; }
        public double? Discount { get; set; }
        public string? Preview { get; set; }
    }
}
