using App.Common.Exceptions;
using App.Domain;
using App.Domain.Interfaces;
using App.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace App.Infrastructure.Repositories
{
    public abstract class BaseRepository<T, E> : IRepository<T, E> where T : class, IEntity<E>
    {
        public readonly ApplicationContext _context;
        public readonly DbSet<T> _dbSet;

        public BaseRepository(ApplicationContext context)
        {
            _context = context;
            _dbSet = context.Set<T>();
        }

        public IEnumerable<T> GetAll()
        {
            return _context.Set<T>().ToList();
        }

        public T GetById(E id)
        {
            return _dbSet.Find(id) ?? throw new DatabaseException("Entry not found!");
        }

        public bool Remove(E id)
        {
            var entity = _dbSet.Find(id);
            if (entity != null)
            {
                _context.Remove(entity);
                return true;
            }
            return false;
        }

        public bool Remove(T entry)
        {
            return Remove(entry.Id);
        }

        public void Delete(E id)
        {
            if (Remove(id)) Flush();
        }

        public void Delete(T entry)
        {
            Delete(entry.Id);
        }

        public virtual void Update(T entry)
        {
            var entity = _dbSet.Find(entry.Id);
            if (entity == null)
            {
                _context.Add(entry);
            }
            else
            {
                _context.Entry(entity).CurrentValues.SetValues(entry);
            }
        }

        public void Update(IEnumerable<T> list)
        {
            foreach (var item in list)
            {
                Update(item);
            }
        }

        public void Save(T entry)
        {
            Update(entry);
            Flush();
        }

        public void Save(IEnumerable<T> list)
        {
            Update(list);
            Flush();
        }

        public void Flush()
        {
            _context.SaveChanges();
        }
    }
}
