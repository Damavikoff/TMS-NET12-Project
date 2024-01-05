using App.Domain.Interfaces;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_shipping_addresses")]
    public class ShippingAddress : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; } = Guid.NewGuid();
        [ForeignKey("city_id")]
        public virtual required City City { get; set; } = null!;
        [Column("zip")]
        public string? Zip {  get; set; }
        [Column("address")]
        public required string Street { get; set; }
    }
}
