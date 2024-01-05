using App.Domain;
using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public class BlogPostRepository : BaseRepository<BlogPost, Guid>
    {
        public BlogPostRepository(ApplicationDbContext context) : base(context) { }

        public async Task<IEnumerable<BlogPost>> GetLastNRecordsAsync (int n)
        {
            return await _dbSet.OrderByDescending(x => x.Created).Take(n).ToListAsync();
        }
    }
}
