namespace App.Infrastructure.Dto
{
    public class CartItemDto
    {
        public Guid Product { get; set; }
        public int Amount { get; set; }
        public Guid Size { get; set; }
    }
}
