using System.ComponentModel.DataAnnotations.Schema;

namespace App.Domain.Entities
{
    [Table("p_product_sizes")]
    public class ProductSize
    {
        [Column("product_id")]
        public Guid ProductId { get; set; }
        [Column("size_id")]
        public Guid SizeId { get; set; }
    }
}
