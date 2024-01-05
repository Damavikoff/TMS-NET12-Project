namespace App.Infrastructure.Interfaces
{
    public interface IRepository<T, E>
    {
        public Task<IEnumerable<T>> GetAllAsync();
        public Task<T> GetByIdAsync(E id);
        public Task<IEnumerable<T>> GetAllByIdInAsync(IEnumerable<E> list);
        public T Update(T entry);
        public IEnumerable<T> Update(IEnumerable<T> list);
        public Task<bool> RemoveAsync(E id);
        public bool Remove(T entry);
        public Task DeleteAsync(E id);
        public Task DeleteAsync(T entry);
        public Task SaveAsync(T entry);
        public Task SaveAsync(IEnumerable<T> list);
        public Task FlushAsync();
    }
}
