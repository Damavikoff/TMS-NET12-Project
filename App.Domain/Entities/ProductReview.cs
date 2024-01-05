using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using App.Domain.Interfaces;

namespace App.Domain.Entities
{
    [Table("p_reviews")]
    public class ProductReview : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; }
        [Column("name")]
        public string? Name { get; set; }
        [Column("description")]
        public required string Description { get; set; }
        [Column("score")]
        public required int Score { get; set; }
        [Column("created")]
        public DateTime Created { get; set; } = DateTime.UtcNow;
        [ForeignKey("user_id")]
        public virtual User? User { get; set; } = null!;
        [ForeignKey("product_id")]
        public virtual Product Product { get; set; } = null!;
    }
}
