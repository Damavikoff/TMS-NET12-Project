using App.Domain.Entities;
using App.Infrastructure.Dto;

namespace App.Infrastructure.Mappers
{
    public class ReviewMapper : BaseMapper<ProductReview, ReviewDto>
    {
        public override ReviewDto ToDto(ProductReview entity)
        {
            var user = entity.User == null ? null : new UserItemDto ()
            {
                Id = entity.User.Id,
                FirstName = entity.User.Info.FirstName,
                LastName = entity.User.Info.LastName,
                Image = entity.User.Image
            };
            return new ReviewDto()
            {
                Id = entity.Id,
                User = user,
                Name = entity.Name,
                Description = entity.Description,
                Score = entity.Score,
                Created = entity.Created
            };
        }
    }
}
