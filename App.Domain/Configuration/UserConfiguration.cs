using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace App.Domain.Configuration
{
    internal class UserConfiguration : IEntityTypeConfiguration<User>
    {
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.HasMany(l => l.Addresses)
            .WithMany()
            .UsingEntity<UserAddress>(
                x =>
                {
                    x.HasOne(v => v.User).WithMany().HasForeignKey(v => v.UserId);
                    x.HasOne(v => v.Address).WithMany().HasForeignKey(v => v.AddressId);
                }
            );
        }
    }
}
