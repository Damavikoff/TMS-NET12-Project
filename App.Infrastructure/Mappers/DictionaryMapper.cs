using App.Domain.Interfaces;
using App.Infrastructure.Dto;

namespace App.Infrastructure.Mappers
{
    public class DictionaryMapper<T, E> : BaseMapper<T, DictionaryItemDto<E>> where T : IDictionaryEntity<E>
    {
        public override DictionaryItemDto<E> ToDto(T entity)
        {
            return new DictionaryItemDto<E>()
            {
                Id = entity.Id,
                Title = entity.Title
            };
        }
    }
}
