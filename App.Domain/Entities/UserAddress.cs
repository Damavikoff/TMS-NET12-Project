using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_user_addresses")]
    public class UserAddress
    {
        [Column("user_id")]
        public Guid UserId { get; set; }
        public virtual required User User { get; set; }
        [Column("address_id")]
        public Guid AddressId { get; set; }
        public virtual required ShippingAddress Address { get; set; }
    }
}
