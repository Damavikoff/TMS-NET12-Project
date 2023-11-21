using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class SizeRepository : DictionaryRepository<Size, Guid>
    {
        public SizeRepository(ApplicationContext context) : base(context) { }
    }
}
