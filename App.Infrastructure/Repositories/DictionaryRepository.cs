using App.Domain;
using App.Infrastructure.Interfaces;
using App.Domain.Interfaces;

namespace App.Infrastructure.Repositories
{
    public abstract class DictionaryRepository<T, E> : BaseRepository<T, E>, IDictionaryRepository<T, E> where T : class, IDictionaryEntity<E>
    {
        public DictionaryRepository(ApplicationContext context) : base(context) { }
        public IEnumerable<T> GetAllOrderByTitle()
        {
            return _dbSet.OrderBy(x => x.Title).ToList();
        }
    }
}
