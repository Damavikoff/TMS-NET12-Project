namespace App.Domain.Interfaces
{
    public interface IDictionaryEntity<T> : IEntity<T>
    {
        public string Title { get; set; }
    }
}
