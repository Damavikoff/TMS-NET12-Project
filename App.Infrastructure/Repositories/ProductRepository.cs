using App.Common.Exceptions;
using App.Domain;
using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public class ProductRepository : PageableRepository<Product, Guid>
    {
        public ProductRepository(ApplicationDbContext context) : base(context) { }

        public override async Task<Product> GetByIdAsync(Guid id)
        {
            return await _context.Products.Include(x => x.Sizes.OrderBy(v => v.Position)).Include(x => x.Reviews.OrderByDescending(v => v.Created)).FirstOrDefaultAsync(x => x.Id == id) ?? throw new DatabaseException("Entry not found!");
        }
    }
}
