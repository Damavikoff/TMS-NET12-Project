using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using App.Common;
using App.Domain.Entities;
using System.Reflection.Emit;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;
using App.Domain.Configuration;

namespace App.Domain
{
    public class ApplicationContext : DbContext
    {
        public DbSet<Category> Categories { get; set; } = null!;
        public DbSet<Size> Sizes { get; set; } = null!;
        public DbSet<Tag> Tags { get; set; } = null!;
        public DbSet<Product> Products { get; set; } = null!;
        public DbSet<ProductSize> ProductSizes { get; set; } = null!;
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var configuration = ConfigProvider.FromJson(Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json"));
            optionsBuilder.UseNpgsql(configuration.GetConnectionString("Default"));
            optionsBuilder.UseLazyLoadingProxies();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new ProductConfiguration());
        }
    }
}
