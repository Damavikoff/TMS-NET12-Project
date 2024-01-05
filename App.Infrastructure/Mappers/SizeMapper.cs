using App.Domain.Entities;
using App.Infrastructure.Dto;

namespace App.Infrastructure.Mappers
{
    public class SizeMapper : DictionaryMapper<Size, Guid>
    {
        public override SizeDto ToDto(Size entity) {
            return new SizeDto()
            {
                Id = entity.Id,
                Title = entity.Title,
                Label = entity.Label
            };
        }

        public override IEnumerable<SizeDto> ToDto(IEnumerable<Size> entities)
        {
            return entities.Select(ToDto);
        }
    }
}
