using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using NebarisMVC.Data;

namespace NebarisMVC.Repositorio
{
    public class EfRepository<T> : IRepository<T> where T : class, IEntity
    {
        private DbContext context;
        private DbSet<T> dbSet;

        public EfRepository(DbContext contexto)
        {
            this.context = contexto;
            this.dbSet = context.Set<T>();
        }

        public virtual IQueryable<T> ObtenerTodos()
        {
            return dbSet;
        }

        public virtual T ObtenerPorId(int id)
        {
            return dbSet.Find(id);
        }

        public virtual void Insertar(T entidad)
        {
            dbSet.Add(entidad);
        }

        public virtual void Borrar(int id)
        {
            T entidadABorrar = dbSet.Find(id);
            Borrar(entidadABorrar);
        }

        public virtual void Borrar(T entidadABorrar)
        {
            if (context.Entry(entidadABorrar).State == EntityState.Detached)
            {
                dbSet.Attach(entidadABorrar);
            }
            dbSet.Remove(entidadABorrar);
        }

        public virtual void Actualizar(T entidadAActualizar)
        {
            var entry = this.context.Entry(entidadAActualizar);
            var key = entidadAActualizar.Codigo;

            if (entry.State == EntityState.Detached)
            {
                var currentEntry = dbSet.Find(key);
                if (currentEntry != null)
                {
                    var attachedEntry = this.context.Entry(currentEntry);
                    attachedEntry.CurrentValues.SetValues(entidadAActualizar);
                }
                else
                {
                    dbSet.Attach(entidadAActualizar);
                    entry.State = EntityState.Modified;
                }
            }
        }
    }
}
