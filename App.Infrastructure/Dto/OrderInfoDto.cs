namespace App.Infrastructure.Dto
{
    public class OrderInfoDto
    {
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public Guid City { get; set; }
        public required string Address { get; set; }
        public required string Email { get; set; }
        public required string Phone { get; set; }
        public string? Description { get; set; }
        public string? Zip { get; set; }
    }
}
