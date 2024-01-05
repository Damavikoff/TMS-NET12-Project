namespace App.Infrastructure.Dto
{
    public class UserItemDto
    {
        public Guid Id { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Image { get; set; }
    }
}
