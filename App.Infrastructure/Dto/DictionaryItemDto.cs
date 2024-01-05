namespace App.Infrastructure.Dto
{
    public class DictionaryItemDto<T>
    {
        public T? Id { get; set; }
        public string? Title { get; set; }
    }
}
