using App.Domain.Entities;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Services
{
    public class InitService
    {
        private readonly CategoryRepository _categoryRepository;
        private readonly TagRepository _tagRepository;
        private readonly SizeRepository _sizeRepository;

        public InitService(CategoryRepository categoryRepository, TagRepository tagRepository, SizeRepository sizeRepository)
        {
            _categoryRepository = categoryRepository;
            _tagRepository = tagRepository;
            _sizeRepository = sizeRepository;
        }

        public IDictionary<string, object> GetInitData()
        {
            return new Dictionary<string, object> {
                { "directories",
                    new Dictionary<string, object> {
                        { "categories", _categoryRepository.GetAllOrderByTitle() },
                        { "tags", _tagRepository.GetAllOrderByTitle() },
                        { "sizes", _sizeRepository.GetAllOrderByTitle() }
                    }
                }
            };
        }
    }
}
