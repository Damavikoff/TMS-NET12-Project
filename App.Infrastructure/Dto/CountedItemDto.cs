namespace App.Infrastructure.Dto
{
    public class CountedItemDto : DictionaryItemDto<Guid>
    {
        public int Count { get; set; }
    }
}
