namespace App.Infrastructure.Interfaces
{
    public interface IRepository<T, E>
    {
        public IEnumerable<T> GetAll();
        public T GetById(E id);
        public bool Remove(E id);
        public bool Remove(T entry);
        public void Delete(E id);
        public void Delete(T entry);
        public void Update(T entry);
        public void Update(IEnumerable<T> list);
        public void Save(T entry);
        public void Save(IEnumerable<T> list);
        public void Flush();
    }
}
