namespace App.Infrastructure.Miscellaneous
{
    public class Sorting
    {
        public string Name { get; }
        public SortDirection Direction { get; }

        public Sorting(string name, SortDirection direction)
        {
            Name = name;
            Direction = direction;
        }

        public Sorting(string name) : this(name, SortDirection.Ascending) { }
    }

    public enum SortDirection
    {
        Ascending = 1,
        Descending = 2
    }
}
