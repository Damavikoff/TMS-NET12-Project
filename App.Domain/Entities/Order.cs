using App.Domain.Interfaces;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_orders")]
    public class Order : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; } = Guid.NewGuid();
        [Column("state")]
        public OrderState State { get; set; } = OrderState.Created;
        [Column("order_number")]
        public required string Number { get; set; }
        [Column("total")]
        public required double Total { get; set; }
        [Column("shipping")]
        public double Shipping { get; set; }
        [Column("payment_method")]
        public PaymentMethod PaymentMethod { get; set; } = PaymentMethod.Card;
        [Column("description")]
        public string? Description { get; set; }
        [Column("created")]
        public DateTime Created { get; set; } = DateTime.UtcNow;
        [Column("updated")]
        public DateTime? Updated { get; set; }
        public virtual ICollection<OrderItem> Items { get; set; } = new List<OrderItem>();
        [ForeignKey("user_info_id")]
        public virtual UserInfo UserInfo { get; set; } = null!;
        [ForeignKey("address_id")]
        public virtual ShippingAddress Address { get; set; } = null!;
        [ForeignKey("user_id")]
        public virtual User? User { get; set; } = null!;
    }

    public enum OrderState
    {
        Created = 1,
        Preparing = 2,
        Delivered = 3,
        Cancelled = 4
    }

    public enum PaymentMethod
    {
        Card = 1,
        Bank = 2,
        Cash = 3
    }
}
