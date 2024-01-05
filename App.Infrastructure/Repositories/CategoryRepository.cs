using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class CategoryRepository : DictionaryRepository<Category, Guid>
    {
        public CategoryRepository(ApplicationDbContext context) : base(context) { }
    }
}
