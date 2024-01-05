using App.Domain;
using App.Infrastructure.Interfaces;
using App.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public abstract class DictionaryRepository<T, E> : BaseRepository<T, E>, IDictionaryRepository<T, E> where T : class, IDictionaryEntity<E>
    {
        public DictionaryRepository(ApplicationDbContext context) : base(context) { }
        public async Task<IEnumerable<T>> GetAllOrderByTitleAsync()
        {
            return await _dbSet.OrderBy(x => x.Title).ToListAsync();
        }
    }
}
