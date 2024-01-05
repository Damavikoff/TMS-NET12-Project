using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Services
{
    public class CategoryService
    {
        private readonly CategoryRepository _categoryRepository;
        private readonly CategoryMapper _categoryMapper;

        public CategoryService (CategoryRepository categoryRepository, CategoryMapper categoryMapper)
        {
            _categoryRepository = categoryRepository;
            _categoryMapper = categoryMapper;
        }

        public IEnumerable<CountedItemDto> GetCountedItems()
        {
            return _categoryRepository._dbSet.Select(x => new CountedItemDto() { Id = x.Id, Title = x.Title, Count = x.Products.Count() }).Where(x => x.Count > 0).ToList();
        }

        public async Task<IEnumerable<DictionaryItemDto<Guid>>> GetItems()
        {
            var entries = await _categoryRepository.GetAllOrderByTitleAsync();
            return _categoryMapper.ToDto(entries);
        }
    }
}
