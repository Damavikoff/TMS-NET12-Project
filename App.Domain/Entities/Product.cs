using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using App.Domain.Interfaces;

namespace App.Domain.Entities
{
    [Table("p_products")]
    public class Product : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; }
        [ForeignKey("category_id")]
        public required virtual Category Category { get; set; } = null!;
        [Column("title")]
        public required string Title { get; set; }
        [Column("short_description")]
        public string? ShortDescription { get; set; }
        [Column("description")]
        public string? Description { get; set; }
        [Column("preview")]
        public string? Preview { get; set; }
        [Column("price")]
        public double Price { get; set; }
        [Column("discount")]
        public double? Discount { get; set; } = 0;
        [Column("sku")]
        public string? Sku { get; set; }
        [Column("is_active")]
        public bool IsActive { get; set; }
        [Column("created")]
        public DateTime Created { get; set; } = DateTime.UtcNow;
        public virtual ICollection<Size> Sizes { get; set; } = new List<Size>();
        public virtual ICollection<Tag> Tags { get; set; } = new List<Tag>();
        public virtual ICollection<ProductImage> Images { get; set; } = new List<ProductImage>();
        public virtual ICollection<ProductReview> Reviews { get; set; } = new List<ProductReview>();

        public double TotalPrice => Discount == null ? Price : Price * (1 - (Discount ?? 0) / 100);
    }
}
