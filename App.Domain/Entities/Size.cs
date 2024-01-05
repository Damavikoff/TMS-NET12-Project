using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using App.Domain.Interfaces;

namespace App.Domain.Entities
{
    [Table("p_sizes")]
    public class Size : IDictionaryEntity<Guid>
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; }
        [Column("title")]
        public required string Title { get; set; }
        [Column("label")]
        public required string Label { get; set; }
        [Column("position")]
        public required int Position { get; set; }
        public virtual ICollection<Product> Products { get; set; } = new List<Product>();
    }
}
