using System.Linq;
using NebarisMVC.Data;

namespace NebarisMVC.Repositorio
{
    public interface IRepository<T> where T : class, IEntity
    {
        IQueryable<T> ObtenerTodos();
        T ObtenerPorId(int id);
        void Insertar(T entidad);
        void Borrar(int id);
        void Borrar(T entidadABorrar);
        void Actualizar(T entidadAActualizar);
    }
}
