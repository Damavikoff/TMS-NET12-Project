namespace App.Infrastructure.Miscellaneous
{
    public class StoreFilter
    {
        public virtual FilterType Type => FilterType.Category;
        public string? Title { get; set; }
        public string? Name { get; set; }
    }

    public class FilterValue<T>
    {
        public T? Value { get; set; }
        public string? Title { get; set; }
        public int Count { get; set; }
    }

    public class StoreFilterCategory<T> : StoreFilter
    {
        public IEnumerable<FilterValue<T>> Values { get; set; } = new List<FilterValue<T>>();
    }

    public class StoreFilterRange : StoreFilter
    {
        public override FilterType Type => FilterType.Range;
        public int Min { get; set; }
        public int Max { get; set; }
        public string? Prefix { get; set; }
    }

    public enum FilterType
    {
        Category = 1,
        Range = 2
    }
}
