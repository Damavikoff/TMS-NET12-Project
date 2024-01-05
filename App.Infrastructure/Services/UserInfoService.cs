using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using App.Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Services
{
    public class UserInfoService
    {
        private readonly UserInfoRepository _userInfoRepository;
        private readonly UserInfoMapper _userInfoMapper;

        public UserInfoService(UserInfoRepository userInfoRepository, UserInfoMapper userInfoMapper)
        {
            _userInfoMapper = userInfoMapper;
            _userInfoRepository = userInfoRepository;
        }

        public async Task<UserInfo> GetActualEntry(OrderInfoDto dto)
        {
            var entry = await _userInfoRepository._dbSet.FirstOrDefaultAsync(x => x.FirstName == dto.FirstName &&
                                                                  x.LastName == dto.LastName &&
                                                                  x.Email == dto.Email &&
                                                                  x.PhoneNumber == dto.Phone
                                                                  );
            if (entry != null) { return entry; }

            return _userInfoMapper.ToEntity(dto);
        }
    }
}
