using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Services
{
    public class SizeService
    {
        private readonly SizeRepository _sizeRepository;
        private readonly SizeMapper _sizeMapper;

        public SizeService(SizeRepository sizeRepository, SizeMapper sizeMapper)
        {
            _sizeRepository = sizeRepository;
            _sizeMapper = sizeMapper;
        }

        public IEnumerable<CountedItemDto> GetCountedItems()
        {
            return _sizeRepository._dbSet.OrderBy(x => x.Position).Select(x => new CountedItemDto() { Id = x.Id, Title = x.Title, Count = x.Products.Count() }).Where(x => x.Count > 0).ToList();
        }

        public async Task<IEnumerable<SizeDto>> GetItems()
        {
            var entries = await _sizeRepository.GetAllOrderByPositionAsync();
            return _sizeMapper.ToDto(entries);
        }
    }
}
