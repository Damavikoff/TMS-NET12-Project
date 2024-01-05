using App.Domain.Interfaces;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_cities")]
    public class City : IDictionaryEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; }
        [Column("title")]
        public required string Title { get; set; }
    }
}
