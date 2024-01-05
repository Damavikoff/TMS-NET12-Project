using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Repositories;
using System.Drawing;
using System.Linq;

namespace App.Infrastructure.Mappers
{
    public class OrderItemMapper : BaseMapper<OrderItem, OrderItemDto>
    {
        private readonly ProductMapper _productMapper;
        private readonly ProductRepository _productRepository;
        private readonly SizeMapper _sizeMapper;
        private readonly SizeRepository _sizeRepository;

        public OrderItemMapper(ProductMapper productMapper, ProductRepository productRepository, SizeMapper sizeMapper, SizeRepository sizeRepository)
        {
            _productMapper = productMapper;
            _productRepository = productRepository;
            _sizeMapper = sizeMapper;
            _sizeRepository = sizeRepository;
        }

        public async Task<OrderItem> ToEntity(OrderItemDto dto)
        {
            var product = await _productRepository.GetByIdAsync(dto.Product.Id);
            var size = await _sizeRepository.GetByIdAsync(dto.Size.Id);
            return new OrderItem()
            {
                Product = product,
                Size = size,
                Amount = dto.Amount,
                Price = dto.Price
            };
        }

        public async Task<IEnumerable<OrderItem>> ToEntity(IEnumerable<OrderItemDto> dto)
        {
            var products = await _productRepository.GetAllByIdInAsync(dto.Select(x => x.Product.Id));
            var sizes = await _sizeRepository.GetAllByIdInAsync(dto.Select(x => x.Size.Id));
            return dto.Select(e => new OrderItem()
            {
                Product = products.First(x => x.Id == e.Product.Id),
                Size = sizes.First(x => x.Id == e.Size.Id),
                Amount = e.Amount,
                Price = e.Price
            });
        }

        public override OrderItemDto ToDto(OrderItem entity)
        {
            return new OrderItemDto()
            {
                Id = entity.Id,
                Amount = entity.Amount,
                Price = entity.Price,
                Product = _productMapper.ToDto(entity.Product),
                Size = _sizeMapper.ToDto(entity.Size)
            };
        }

        public CartItemDto ToCartItem(OrderItem entity)
        {
            return new CartItemDto()
            {
                Product = entity.Product.Id,
                Amount = entity.Amount,
                Size = entity.Size.Id
            };
        }

        public async Task<IEnumerable<OrderItemDto>> FromCartToDto(IEnumerable<CartItemDto> cartItems)
        {
            if (!cartItems.Any()) return Enumerable.Empty<OrderItemDto>();
            var products = await _productRepository.GetAllByIdInAsync(cartItems.Select(x => x.Product));
            var sizes = await _sizeRepository.GetAllByIdInAsync(cartItems.Select(x => x.Size));
            return cartItems.Select(x => {
                var p = products.First(v => v.Id == x.Product);
                var s = sizes.First(v => v.Id == x.Size);
                return new OrderItemDto()
                {
                    Amount = x.Amount,
                    Price = p.TotalPrice,
                    Size = _sizeMapper.ToDto(s),
                    Product = _productMapper.ToDto(p)
                };
            });
        }
    }
}
