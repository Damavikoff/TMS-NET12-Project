using App.Infrastructure.Dto;
using App.Infrastructure.Mappers;
using App.Infrastructure.Repositories;

namespace App.Infrastructure.Services
{
    public class BlogPostService
    {
        private readonly BlogPostRepository _blogPostRepository;
        private readonly BlogPostMapper _blogPostMapper;

        public BlogPostService(BlogPostRepository blogPostRepository, BlogPostMapper blogPostMapper)
        {
            _blogPostRepository = blogPostRepository;
            _blogPostMapper = blogPostMapper;
        }

        public async Task<IEnumerable<BlogPostItemDto>> GetItems(int id)
        {
            var entries = await _blogPostRepository.GetLastNRecordsAsync(id);
            return _blogPostMapper.ToDto(entries);
        }
    }
}
