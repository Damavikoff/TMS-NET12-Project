using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class UserRepository : BaseRepository<User, Guid>
    {
        public UserRepository(ApplicationDbContext context) : base(context) { }
    }
}
