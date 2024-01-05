using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class CityRepository : DictionaryRepository<City, Guid>
    {
        public CityRepository(ApplicationDbContext context) : base(context) { }
    }
}
