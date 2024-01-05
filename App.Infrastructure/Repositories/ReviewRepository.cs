using App.Domain;
using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public class ReviewRepository : BaseRepository<ProductReview, Guid>
    {
        public ReviewRepository(ApplicationDbContext context) : base(context) { }
    }
}
