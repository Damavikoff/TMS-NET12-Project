using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using App.Domain.Interfaces;

namespace App.Domain.Entities
{
    [Table("p_tags")]
    public class Tag :IDictionaryEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; }
        [Column("title")]
        public required string Title { get; set; }
    }
}
