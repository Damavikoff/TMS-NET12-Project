using App.Domain.Interfaces;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_blog_posts")]
    public class BlogPost : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; }
        [Column("title")]
        public required string Title { get; set; }
        [Column("description")]
        public string? Description { get; set; }
        [Column("content")]
        public string? Content { get; set; }
        [Column("image")]
        public string? Image { get; set; }
        [Column("created")]
        public DateTime Created { get; set; } = DateTime.UtcNow;
    }
}
