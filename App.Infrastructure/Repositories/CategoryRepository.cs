using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class CategoryRepository : DictionaryRepository<Category, Guid>
    {
        public CategoryRepository(ApplicationContext context) : base(context) { }
    }
}
