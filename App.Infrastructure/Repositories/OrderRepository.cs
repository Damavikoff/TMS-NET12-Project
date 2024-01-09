using App.Domain;
using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public class OrderRepository : BaseRepository<Order, Guid>
    {
        public OrderRepository(ApplicationDbContext context) : base(context) { }

        public async Task<IEnumerable<Order>> GetAllOrderByUpdatedDesc()
        {
            return await _dbSet.OrderByDescending(x => x.Updated == null).ThenByDescending(x => x.Updated).ThenByDescending(x => x.Created).ToListAsync();
        }
    }
}
