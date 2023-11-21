using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace App.Domain.Configuration
{
    internal class ProductConfiguration : IEntityTypeConfiguration<Product>
    {
        public void Configure(EntityTypeBuilder<Product> builder)
        {
            builder.HasMany(l => l.Sizes)
            .WithMany()
            .UsingEntity<ProductSize>(
                x => {
                    x.HasOne<Product>().WithMany().HasForeignKey("ProductId");
                    x.HasOne<Size>().WithMany().HasForeignKey("SizeId");
                }
            );

            builder.HasMany(l => l.Sizes)
            .WithMany()
            .UsingEntity<ProductTag>(
                x => {
                    x.HasOne<Product>().WithMany().HasForeignKey("ProductId");
                    x.HasOne<Tag>().WithMany().HasForeignKey("TagId");
                }
            );
        }
    }
}
