namespace App.Infrastructure.Dto
{
    public class ShippingAddressDto
    {
        public required Guid City { get; set; }
        public string? CityTitle { get; set; }
        public string? Zip { get; set; }
        public string? Street { get; set; }
    }
}
