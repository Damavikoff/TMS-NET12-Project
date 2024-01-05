using App.Domain;
using App.Domain.Interfaces;
using App.Infrastructure.Interfaces;
using App.Infrastructure.Miscellaneous;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public class PageableRepository<T, E> : BaseRepository<T, E>, IPageableRepository<T, E> where T : class, IEntity<E>
    {
        public PageableRepository(ApplicationDbContext context) : base(context) { }

        public async Task<Page<T>> GetPageAsync(int page, int limit)
        {
            return await GetPageAsync(page, limit, _dbSet.AsQueryable());
        }

        public async Task<Page<T>> GetPageAsync(int page, int limit, IQueryable<T> query)
        {
            var count = await query.CountAsync();
            var list = await query.Skip(page * limit).Take(limit).ToListAsync();
            return new Page<T>(count, page, limit, list);
        }
    }
}
