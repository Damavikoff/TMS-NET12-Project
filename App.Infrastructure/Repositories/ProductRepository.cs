using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class ProductRepository : PageableRepository<Product, Guid>
    {
        public ProductRepository(ApplicationContext context) : base(context) { }
    }
}
