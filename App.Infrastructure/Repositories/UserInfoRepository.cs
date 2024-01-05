using App.Domain;
using App.Domain.Entities;

namespace App.Infrastructure.Repositories
{
    public class UserInfoRepository : BaseRepository<UserInfo, Guid>
    {
        public UserInfoRepository(ApplicationDbContext context) : base(context) { }
    }
}
