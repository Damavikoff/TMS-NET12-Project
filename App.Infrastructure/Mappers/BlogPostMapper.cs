using App.Domain.Entities;
using App.Infrastructure.Dto;

namespace App.Infrastructure.Mappers
{
    public class BlogPostMapper : BaseMapper<BlogPost, BlogPostItemDto>
    {
        public override BlogPostItemDto ToDto(BlogPost entity)
        {
            return new BlogPostItemDto()
            {
                Id = entity.Id,
                Title = entity.Title,
                Description = entity.Description,
                Image = entity.Image,
                Created = entity.Created,
            };
        }
    }
}
