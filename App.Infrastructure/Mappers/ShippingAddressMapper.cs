using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Mappers
{
    public class ShippingAddressMapper : BaseMapper<ShippingAddress, ShippingAddressDto>
    {
        private readonly CityRepository _cityRepository;

        public ShippingAddressMapper(CityRepository cityRepository)
        {
            _cityRepository = cityRepository;
        }

        public override ShippingAddressDto ToDto(ShippingAddress entity)
        {
            return new ShippingAddressDto()
            {
                City = entity.City.Id,
                CityTitle = entity.City.Title,
                Zip = entity.Zip,
                Street = entity.Street
            };
        }

        public async Task<ShippingAddress> ToEntity(Guid city, string street, string? zip)
        {
            var cityEntry = await _cityRepository.GetByIdAsync(city);
            return new ShippingAddress() {
                City = cityEntry,
                Zip = zip,
                Street = street
            };
        }
    }
}
