using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace App.Domain.Configuration
{
    internal class SizeConfiguration : IEntityTypeConfiguration<Size>
    {
        public void Configure(EntityTypeBuilder<Size> builder)
        {
            builder.HasMany(l => l.Products)
            .WithMany()
            .UsingEntity<ProductSize>(
                x =>
                {
                    x.HasOne(v => v.Product).WithMany().HasForeignKey(v => v.ProductId);
                    x.HasOne(v => v.Size).WithMany().HasForeignKey(v => v.SizeId);
                }
            );
        }
    }
}
