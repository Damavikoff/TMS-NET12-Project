using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_product_tags")]
    public class ProductTag
    {
        [Column("product_id")]
        public Guid ProductId { get; set; }
        [Column("tag_id")]
        public Guid TagId { get; set; }
    }
}
