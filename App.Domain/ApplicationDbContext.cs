using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using App.Common;
using App.Domain.Entities;
using App.Domain.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;

namespace App.Domain
{
    public class ApplicationDbContext : DbContext
    {
        public DbSet<Category> Categories { get; set; } = null!;
        public DbSet<Size> Sizes { get; set; } = null!;
        public DbSet<Tag> Tags { get; set; } = null!;
        public DbSet<Product> Products { get; set; } = null!;
        public DbSet<ProductImage> ProductImages { get; set; } = null!;
        public DbSet<BlogPost> BlogPosts { get; set; } = null!;
        public DbSet<City> Cities { get; set; } = null!;
        public DbSet<User> Users { get; set; } = null!;
        public DbSet<UserInfo> UserInfo { get; set; } = null!;
        public DbSet<ShippingAddress> ShippingAddresses { get; set; } = null!;
        public DbSet<ProductReview> Reviews { get; set; } = null!;
        public DbSet<Order> Orders { get; set; } = null!;
        public DbSet<OrderItem> OrderItems { get; set; } = null!;
        public DbSet<UserAddress> UserAddresses { get; set; } = null!;
        public DbSet<ProductSize> ProductSizes { get; set; } = null!;
        public DbSet<ProductTag> ProductTags { get; set; } = null!;

        // public static readonly ILoggerFactory factory = LoggerFactory.Create(builder => { builder.AddConsole(); });
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var configuration = ConfigProvider.FromJson(Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json"));
            // .UseLoggerFactory(factory).EnableSensitiveDataLogging().LogTo(message => System.Diagnostics.Debug.WriteLine(message))
            optionsBuilder.UseNpgsql(configuration.GetConnectionString("Default"));
            optionsBuilder.UseLazyLoadingProxies();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
           modelBuilder.ApplyConfiguration(new ProductConfiguration());
           modelBuilder.ApplyConfiguration(new SizeConfiguration());
           modelBuilder.ApplyConfiguration(new UserConfiguration());
        }

        protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
        {
            configurationBuilder.Conventions.Remove(typeof(ForeignKeyIndexConvention));
        }
    }
}
