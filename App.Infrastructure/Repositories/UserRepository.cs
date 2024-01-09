using App.Common.Exceptions;
using App.Domain;
using App.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public class UserRepository : BaseRepository<User, Guid>
    {
        public UserRepository(ApplicationDbContext context) : base(context) { }

        public async Task<User> GetByLogin(string login)
        {
            return await _dbSet.FirstOrDefaultAsync(x => x.Login.ToLower() == login.ToLower()) ?? throw new AppException("User not found.");
        }
    }
}
