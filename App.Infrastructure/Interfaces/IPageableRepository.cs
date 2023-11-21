using App.Infrastructure.Miscellaneous;

namespace App.Infrastructure.Interfaces
{
    public interface IPageableRepository<T, E> : IRepository<T, E>
    {
        public Page<T> GetPage(int page, int limit, Sorting sorting);
    }
}
