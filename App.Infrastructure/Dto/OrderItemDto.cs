namespace App.Infrastructure.Dto
{
    public class OrderItemDto
    {
        public Guid? Id { get; set; }
        public int Amount { get; set; }
        public double Price { get; set; }
        public ProductItemDto Product { get; set; } = null!;
        public SizeDto Size { get; set; } = null!;
    }
}
