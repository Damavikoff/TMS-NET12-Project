namespace App.Infrastructure.Interfaces
{
    public interface IMapper<T, E>
    {
        public E ToDto(T entity);
        public IEnumerable<E> ToDto(IEnumerable<T> entities);
    }
}
