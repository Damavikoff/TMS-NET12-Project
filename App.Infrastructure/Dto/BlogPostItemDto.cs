using App.Domain.Entities;

namespace App.Infrastructure.Dto
{
    public class BlogPostItemDto
    {
        public Guid Id { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public string? Image { get; set; }
        public DateTime Created { get; set; }
    }
}
