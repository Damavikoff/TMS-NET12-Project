namespace App.Infrastructure.Dto
{
    public class SizeDto : DictionaryItemDto<Guid>
    {
        public string? Label { get; set; }
    }
}
