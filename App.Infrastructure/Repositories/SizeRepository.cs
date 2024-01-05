using App.Domain;
using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public class SizeRepository : DictionaryRepository<Size, Guid>
    {
        public SizeRepository(ApplicationDbContext context) : base(context) { }

        public async Task<IEnumerable<Size>> GetAllOrderByPositionAsync()
        {
            return await _dbSet.OrderBy(x => x.Position).ToListAsync();
        }
    }
}
