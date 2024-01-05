using App.Domain.Interfaces;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_user_info")]
    public class UserInfo : IEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; } = Guid.NewGuid();
        [Column("first_name")]
        public string? FirstName { get; set; }
        [Column("last_name")]
        public string? LastName { get; set; }
        [Column("email")]
        public required string Email { get; set; }
        [Column("phone")]
        public string? PhoneNumber { get; set; }
    }
}
