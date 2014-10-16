using System.Data.Entity;
using System.Linq;
using ProntoMVC.Data.Models;

namespace Repo
{
    public class Repository<T> where T : class  , IEntity
    {
        // esto es un repositorio generico?

        // InternalsVisibleTo
        //internal
        internal DbContext context; // http://stackoverflow.com/questions/204739/what-is-the-c-sharp-equivalent-of-friend
        internal DbSet<T> dbSet;



        public ProntoMVC.Data.Models.DemoProntoEntities HACKEADOcontext
        {
            get
            {
                return (ProntoMVC.Data.Models.DemoProntoEntities)context;
            }
        }


        /// <summary>
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="entity"></param>

        public void SetModified(object entity)
        {
            context.Entry(entity).State = EntityState.Modified;
        }

        public System.Data.Entity.Infrastructure.DbEntityEntry Entry(object entity)
        {
            return context.Entry(entity);
        }


        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////



        public Repository(DbContext contexto)
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
            var key = entidadAActualizar.ID;

            //  http://stackoverflow.com/questions/2958921/entity-framework-4-how-to-find-the-primary-key
            // http://stackoverflow.com/questions/7253943/entity-framework-code-first-find-primary-key
            //object o = entidadAActualizar;
            //var kvp = o.EntityKey.EntityKeyValues[0];
            //var firstCompany = (from c in context.Companies select c).FirstOrDefault();
            //var kvp = firstCompany.EntityKey.EntityKeyValues[0];
            // kvp shows {[Symbol, FOO]}




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
