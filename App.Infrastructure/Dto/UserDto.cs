namespace App.Infrastructure.Dto
{
    public class UserDto
    {
        public Guid? Id { get; set; }
        public string? Login {  get; set; }
        public UserInfoDto Info { get; set; } = null!;
        public ShippingAddressDto? Address { get; set; }
        public IEnumerable<OrderDto> Orders { get; set; } = new List<OrderDto>();
        public bool IsValid => Info.FirstName != null && Info.Email != null && Info.Phone != null && Address != null && Address.Street != null;
    }
}
