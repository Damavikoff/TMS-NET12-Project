using App.Infrastructure.Miscellaneous;

namespace App.Infrastructure.Interfaces
{
    public interface IPageableRepository<T, E> : IRepository<T, E>
    {
        public Task<Page<T>> GetPageAsync(int page, int limit);
        public Task<Page<T>> GetPageAsync(int page, int limit, IQueryable<T> query);
    }
}
