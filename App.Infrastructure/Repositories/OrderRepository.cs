using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class OrderRepository : BaseRepository<Order, Guid>
    {
        public OrderRepository(ApplicationDbContext context) : base(context) { }
    }
}
