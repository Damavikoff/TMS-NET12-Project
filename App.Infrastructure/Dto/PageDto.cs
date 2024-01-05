namespace App.Infrastructure.Dto
{
    public class PageDto<T>
    {   
        public int Count { get; set; }
        public IEnumerable<T> Items { get; set; } = Enumerable.Empty<T>();
    }
}
