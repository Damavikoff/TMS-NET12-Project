using App.Domain.Entities;
using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Services
{
    public class ReviewService
    {
        private readonly UserService _userService;
        private readonly ProductRepository _productRepository;
        private readonly ReviewRepository _reviewRepository;
        private readonly ReviewMapper _reviewMapper;

        public ReviewService(UserService userService, ProductRepository productRepository, ReviewRepository reviewRepository, ReviewMapper reviewMapper)
        {
            _userService = userService;
            _productRepository = productRepository;
            _reviewRepository = reviewRepository;
            _reviewMapper = reviewMapper;
        }

        public async Task<ReviewDto> AddReview(Guid productId, ReviewDto dto)
        {
            var user = await _userService.GetCurrentUser();
            var review = new ProductReview()
            {
                Id = dto.Id ?? Guid.NewGuid(),
                Name = dto.Name,
                Description = dto.Description,
                Score = dto.Score,
                Product = await _productRepository.GetByIdAsync(productId),
                User = user
            };
            await _reviewRepository.SaveAsync(review);
            return _reviewMapper.ToDto(review);
        }
    }
}
