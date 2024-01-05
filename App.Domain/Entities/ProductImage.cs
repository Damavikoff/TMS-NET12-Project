using App.Domain.Interfaces;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_product_images")]
    public class ProductImage : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; }
        [ForeignKey("product_id")]
        public required virtual Product Product { get; set; }
        [Column("image")]
        public string Image { get; set; } = null!;
    }
}
