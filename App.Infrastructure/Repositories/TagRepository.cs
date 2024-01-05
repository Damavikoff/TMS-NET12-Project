using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class TagRepository : DictionaryRepository<Tag, Guid>
    {
        public TagRepository(ApplicationDbContext context) : base(context) { }
    }
}
