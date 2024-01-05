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
                x =>
                {
                    x.HasOne(v => v.Product).WithMany().HasForeignKey(v => v.ProductId);
                    x.HasOne(v => v.Size).WithMany().HasForeignKey(v => v.SizeId);
                }
            );

            builder.HasMany(l => l.Tags)
            .WithMany()
            .UsingEntity<ProductTag>(
                x =>
                {
                    x.HasOne(v => v.Product).WithMany().HasForeignKey(v => v.ProductId);
                    x.HasOne(v => v.Tag).WithMany().HasForeignKey(v => v.TagId);
                }
            );
        }
    }
}
