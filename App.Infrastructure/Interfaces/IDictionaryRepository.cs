namespace App.Infrastructure.Interfaces
{
    internal interface IDictionaryRepository<T, E> : IRepository<T, E>
    {
        public Task<IEnumerable<T>> GetAllOrderByTitleAsync();
    }
}
