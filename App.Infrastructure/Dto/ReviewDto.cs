namespace App.Infrastructure.Dto
{
    public class ReviewDto
    {
        public Guid? Id { get; set; } = Guid.NewGuid();
        public UserItemDto? User { get; set; }
        public string? Name { get; set; }
        public required string Description { get; set; }
        public int Score { get; set; }
        public DateTime Created { get; set; } = DateTime.UtcNow;
    }
}
