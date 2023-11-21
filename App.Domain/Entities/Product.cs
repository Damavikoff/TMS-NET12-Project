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
        public virtual Category? Category { get; set; }
        [Column("title")]
        public required string Title { get; set; }
        [Column("short_description")]
        public string? ShortDescription { get; set; }
        [Column("description")]
        public string? Description { get; set; }
        [Column("price")]
        public double Price { get; set; }
        [Column("discount")]
        public int? Discount { get; set; }
        [Column("is_active")]
        public bool IsActive { get; set; }
        [Column("created")]
        public DateTime Created { get; set; } = DateTime.Now;
        public virtual ICollection<Size> Sizes { get; set; } = new List<Size>();
        public virtual ICollection<Tag> Tags { get; set; } = new List<Tag>();
    }
}
