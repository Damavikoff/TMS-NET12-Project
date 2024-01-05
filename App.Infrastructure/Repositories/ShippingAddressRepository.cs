using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class ShippingAddressRepository : BaseRepository<ShippingAddress, Guid>
    {
        public ShippingAddressRepository(ApplicationDbContext context) : base(context) { }
    }
}
