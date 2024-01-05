using App.Common.Exceptions;
using App.Infrastructure.Mappers;
using App.Infrastructure.Miscellaneous;
using App.Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;
using System.Net;

namespace App.Infrastructure.Services
{
    public class InitService
    {
        private readonly CategoryService _categoryService;
        private readonly SizeService _sizeService;
        private readonly BlogPostService _blogPostService;
        private readonly CityRepository _cityRepository;
        private readonly ProductRepository _productRepository;
        private readonly CartService _cartService;
        private readonly UserService _userService;
        private readonly UserMapper _userMapper;

        public InitService(CategoryService categoryService, SizeService sizeService, BlogPostService blogPostService, ProductRepository productRepository, CityRepository cityRepository, CartService cartService, UserService userService, UserMapper userMapper)
        {
            _categoryService = categoryService;
            _sizeService = sizeService;
            _blogPostService = blogPostService;
            _productRepository = productRepository;
            _cityRepository = cityRepository;
            _cartService = cartService;
            _userService = userService;
            _userMapper = userMapper;
        }

        public async Task<IDictionary<string, object?>> GetInitData()
        {
            var user = await _userService.GetCurrentUser();
            return new Dictionary<string, object?> {
                { "blogPosts", await _blogPostService.GetItems(4) },
                { "filters", await GetFilters() },
                { "cart", await _cartService.GetCartDto() },
                { "directories", await GetDirectories() },
                { "user", user == null ? null : _userMapper.ToDto(user) }
            };
        }

        private async Task<Dictionary<string, object>> GetDirectories ()
        {
            return new Dictionary<string, object>
            {
                { "categories", await _categoryService.GetItems() },
                { "sizes", await _sizeService.GetItems() },
                { "cities", await _cityRepository.GetAllOrderByTitleAsync() }
            };
        }
        
        private async Task<IEnumerable<object>> GetFilters()
        {
            var productCount = await _productRepository._dbSet.CountAsync();
            var categories = _categoryService.GetCountedItems();
            var sizes = _sizeService.GetCountedItems();
            // var productSizedCount = _productRepository._dbSet.Where(x => x.Sizes.Any()).Count();
            var priceRange = _productRepository._dbSet.GroupBy(x => true).Select(x => new { Max = x.Max(v => v.Price), Min = x.Min(v => v.Price) }).First();
            var categoryFilter = new StoreFilterCategory<Guid?>() {
                Title = "Category",
                Name = "category",
                Values = categories.Select(x => new FilterValue<Guid?>() { Title = x.Title, Value = x.Id, Count = x.Count }).Prepend(new FilterValue<Guid?>() { Title = "All", Count = productCount })
            };
            var priceFilter = new StoreFilterRange() { Title = "Price", Name = "price", Prefix = "$", Min = (int)Math.Floor(priceRange.Min), Max = (int)Math.Ceiling(priceRange.Max) };
            var sizeFilter = new StoreFilterCategory<Guid?>()
            {
                Title = "Size",
                Name = "size",
                Values = sizes.Select(x => new FilterValue<Guid?>() { Title = x.Title, Value = x.Id, Count = x.Count }).Prepend(new FilterValue<Guid?>() { Title = "All", Count = productCount })
            };
            return new List<object>()
            {
                categoryFilter, priceFilter, sizeFilter
            };
        }
    }
}
