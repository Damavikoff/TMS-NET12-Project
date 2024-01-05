using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using App.Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Services
{
    public class ShippingAddressService
    {
        private readonly ShippingAddressRepository _shippingAddressRepository;
        private readonly ShippingAddressMapper _shippingAddressMapper;

        public ShippingAddressService(ShippingAddressRepository shippingAddressRepository, ShippingAddressMapper shippingAddressMapper)
        {
            _shippingAddressRepository = shippingAddressRepository;
            _shippingAddressMapper = shippingAddressMapper;
        }

        private async Task<ShippingAddress?> GetExistingEntry(Guid city, string address, string? zip)
        {
            var entryQuery = _shippingAddressRepository._dbSet.Where(x => x.City.Id == city && x.Street.ToLower() == address.ToLower());
            if (zip != null)
            {
                entryQuery = entryQuery.Where(x => x.Zip == zip);
            }
            return await entryQuery.FirstOrDefaultAsync();
        }

        public async Task<ShippingAddress> GetActualEntry(Guid city, string address, string? zip)
        {
            var entry = await GetExistingEntry(city, address, zip);
            if (entry != null) { return entry; }
            entry = await _shippingAddressMapper.ToEntity(city, address, zip);
            _shippingAddressRepository.Update(entry);
            return entry;
        }
    }
}
