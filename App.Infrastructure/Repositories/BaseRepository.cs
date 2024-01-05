using App.Common.Exceptions;
using App.Domain;
using App.Domain.Interfaces;
using App.Infrastructure.Interfaces;
using App.Infrastructure.Miscellaneous;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace App.Infrastructure.Repositories
{
    public abstract class BaseRepository<T, E> : IRepository<T, E> where T : class, IEntity<E>
    {
        public readonly ApplicationDbContext _context;
        public readonly DbSet<T> _dbSet;

        public BaseRepository(ApplicationDbContext context)
        {
            _context = context;
            _dbSet = context.Set<T>();
        }

        public async Task<IEnumerable<T>> GetAllAsync()
        {
            return await _context.Set<T>().ToListAsync();
        }

        public virtual async Task<T> GetByIdAsync(E id)
        {
            return await _dbSet.FindAsync(id) ?? throw new DatabaseException("Entry not found!");
        }

        public async Task<IEnumerable<T>> GetAllByIdInAsync(IEnumerable<E> list)
        {
            return await _dbSet.Where(v => list.Contains(v.Id)).ToListAsync();
        }

        public async Task<bool> RemoveAsync(E id)
        {
            return Remove(await _dbSet.FindAsync(id));
        }

        public bool Remove(T? entity)
        {
            if (entity == null) return false;
            _context.Remove(entity);
            return true;
        }

        public async Task DeleteAsync(E id)
        {
            if (await RemoveAsync(id)) await FlushAsync();
        }

        public async Task DeleteAsync(T entry)
        {
            if (Remove(entry)) await FlushAsync();
        }

        public virtual T Update(T entry)
        {
            if (_context.Entry(entry).State == EntityState.Detached)
            {
                _context.Add(entry);

            }
            else
            {
                _context.Entry(entry).CurrentValues.SetValues(entry);
            }
            return _context.Entry(entry).Entity;
        }

        public IEnumerable<T> Update(IEnumerable<T> list)
        {
            return list.Select(Update);
        }

        public async Task SaveAsync(T entry)
        {
            Update(entry);
            await FlushAsync();
        }

        public async Task SaveAsync(IEnumerable<T> list)
        {
            Update(list);
            await FlushAsync();
        }

        public async Task FlushAsync()
        {
            await _context.SaveChangesAsync();
        }

        public IOrderedQueryable<T> Order<K>(IQueryable<T> query, Expression<Func<T, K>> selector, SortDirection direction)
        {
            if (direction == SortDirection.Descending)
            {
                return query.OrderByDescending(selector);
            }
            return query.OrderBy(selector);
        }
    }
}
