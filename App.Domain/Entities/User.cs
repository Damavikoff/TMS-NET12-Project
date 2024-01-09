using App.Domain.Interfaces;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_users")]
    public class User : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; }
        [Column("login")]
        public string Login { get; set; } = null!;
        [Column("password")]
        public required string Password { get; set; }
        [Column("role_id")]
        public UserRole Role { get; set; } = UserRole.User;
        [Column("image")]
        public string? Image { get; set; }
        [Column("created")]
        public DateTime Created { get; set; } = DateTime.UtcNow;
        [ForeignKey("info_id")]
        public virtual UserInfo Info { get; set; } = null!;
        [ForeignKey("address_id")]
        public virtual ShippingAddress? ShippingAddress { get; set; }
        public virtual ICollection<ShippingAddress> Addresses { get; set; } = new List<ShippingAddress>();
        public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
        public bool IsAdmin => Role == UserRole.Admin;
    }

    public enum UserRole
    {
        User = 1,
        Admin = 2
    }
}
