using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Mappers
{
    public class UserInfoMapper : BaseMapper<UserInfo, UserInfoDto>
    {
        public override UserInfoDto ToDto(UserInfo entity)
        {
            return new UserInfoDto()
            {
                FirstName = entity.FirstName,
                LastName = entity.LastName,
                Email = entity.Email,
                Phone = entity.PhoneNumber
            };
        }

        public UserInfo ToEntity(OrderInfoDto dto)
        {
            return new UserInfo() {
                FirstName = dto.FirstName,
                LastName = dto.LastName,
                Email = dto.Email,
                PhoneNumber = dto.Phone
            };
        }
    }
}
