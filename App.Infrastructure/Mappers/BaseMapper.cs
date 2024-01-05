using App.Infrastructure.Interfaces;

namespace App.Infrastructure.Mappers
{
    public abstract class BaseMapper<T, E> : IMapper<T, E>
    {
        public abstract E ToDto(T entity);

        public virtual IEnumerable<E> ToDto(IEnumerable<T> entities)
        {
            return entities.Select(ToDto);
        }
    }
}
