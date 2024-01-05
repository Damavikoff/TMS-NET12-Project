namespace App.Infrastructure.Dto
{
    public class OrderDto
    {
        public Guid Id { get; set; }
        public int State { get; set; }
        public required string Number { get; set; }
        public double Total { get; set; }
        public double Shipping { get; set; }
        public int PaymentMethod { get; set; }
        public string? Description { get; set; }
        public DateTime Created { get; set; }
        public DateTime? Updated { get; set; }
        public IEnumerable<OrderItemDto> Items { get; set; } = new List<OrderItemDto>();
        public UserInfoDto UserInfo { get; set; } = null!;
        public ShippingAddressDto Address { get; set; } = null!;
    }
}
