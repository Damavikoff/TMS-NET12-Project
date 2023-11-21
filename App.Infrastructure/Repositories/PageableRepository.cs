using App.Domain;
using App.Domain.Interfaces;
using App.Infrastructure.Interfaces;
using App.Infrastructure.Miscellaneous;

namespace App.Infrastructure.Repositories
{
    public class PageableRepository<T, E> : BaseRepository<T, E>, IPageableRepository<T, E> where T : class, IEntity<E>
    {
        public PageableRepository(ApplicationContext context) : base(context) { }

        public Page<T> GetPage(int page, int limit, Sorting sorting)
        {
            var count = _dbSet.Count();
            var list  = _dbSet.Skip(page * limit).Take(limit).ToList();
            return new Page<T>(count, page, limit, list);
        }
    }
}
