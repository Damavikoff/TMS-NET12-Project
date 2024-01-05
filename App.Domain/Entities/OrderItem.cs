using App.Domain.Interfaces;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_order_items")]
    public class OrderItem : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; } = Guid.NewGuid();
        [Column("amount")]
        public int Amount { get; set; }
        [Column("price")]
        public double Price { get; set; }
        [ForeignKey("product_id")]
        public required virtual Product Product { get; set; } = null!;
        [ForeignKey("order_id")]
        public virtual Order? Order { get; set; }
        [ForeignKey("size_id")]
        public required virtual Size Size { get; set; } = null!;
    }
}
