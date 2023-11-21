namespace App.Infrastructure.Miscellaneous
{
    public class Page<T>
    {
        public int OverallCount { get; }
        public int PageIndex { get; }
        public int PageCount { get; }
        public IEnumerable<T> Entries { get; } = new List<T>();

        public Page(int count, int pageIndex, int pageCount, IEnumerable<T> entries)
        {
            OverallCount = count;
            PageIndex = pageIndex;
            PageCount = pageCount;
            Entries = entries;
        }
    }
}
