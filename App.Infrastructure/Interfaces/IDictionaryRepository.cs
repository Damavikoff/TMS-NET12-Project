namespace App.Infrastructure.Interfaces
{
    internal interface IDictionaryRepository<T, E> : IRepository<T, E>
    {
        public IEnumerable<T> GetAllOrderByTitle();
    }
}
