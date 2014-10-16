using System.Data.Entity;
using System.Linq;
using ProntoMVC.Data.Models;

using System.Data.Entity.Infrastructure;


namespace Repo
{

    //http://stackoverflow.com/questions/1230571/advantage-of-creating-a-generic-repository-vs-specific-repository-for-each-obje
    //http://programmers.stackexchange.com/questions/164000/is-there-a-real-advantage-to-generic-repository

    public class IServicio //, IEntity
    {


        // podría usar esto! el GetRepository que usan en http://stackoverflow.com/questions/16716527/unit-of-work-generic-repository-with-entity-framework-5 
            //private IRepository<Example> m_repo;

            //public ExampleService(IUnitOfWork uow)
            //{
            //    m_repo = uow.GetRepository<Example>();
            //}

            //public void Add(Example Example)
            //{
            //    m_repo.Add(Example);
            //}

            //public IEnumerable<Example> getAll()
            //{
            //    return m_repo.All();
            //}


        	 	
//@Gaui Wouldn't it be better to create your UnitOfWork instance inside your ExampleService class instead of your controller? That way your controller doesn't need to know about what DbContext it needs, it leaves it to the service. –  GFoley83 Nov 10 '13 at 22:19
  	 	
//@GFoley83 That's just a preference really. If you want to have many services using the same uow object, you would need to do it outside the service. –  Gaui Nov 18 '13 at 1:01
  	 	
//I would argue that, if the consumer of your service is remote, that you do not want the uow existing outside the service. You don't want open transactions/connections hanging around in a stateless environment. If the consumer is not remote, this may not be an issue. –  Aaron Palmer Nov 22 '13 at 18:12


        /* 
         * http://stackoverflow.com/questions/21349950/entity-framework-6-code-first-is-repository-implementation-a-good-one
         * A domin object should never know about persistence, EF, joins etc. It shouldn't know 
         * what db engine you're using or if you're using one. Same with the rest of the app, if you want 
         * it to be decoupled from the persistence details.
         * 
         * The implementation will reside in the DAL and will use EF to work with the db. However the implementation looks like this
         * (las interfaces las define el servicio, él impone el contrato. 
         * 
         * 
         * http://www.sapiensworks.com/blog/post/2014/06/02/The-Repository-Pattern-For-Dummies.aspx
         * 
         * I'll keep the criteria class for scenarios where I need to pass more than one parameter, but it's not like
         * there's a rule, it depends on what's more easier or semantically suited for that use case. It's also 
         * important to say that I decide the shelf's functionality. In tech speak, this means that the repository
         * interface is designed by the business layer's needs. That's why all the repository interfaces reside in
         * the business layer, while their concrete implementation is part of the Persistence Layer (DAL).

         * Oh, by the way, these shelves are ALL MINE! Only I can use them. I don't care about UI, Presentation, Reporting etc these 
         * shelves are only serving me (myself and I). If UI wants to do some queries, let it define its own shelves.
         * I won't share mine. I've created them ONLY for MY purposes and they have ONLY the functionality I need!
         * I say that everyone should have their own shelves. Sharing is not caring, sharing is messing (around).

        */



        //public interface IWriteEntities : IReadEntities, IUnitOfWork
        //{
        //    IQueryable<TEntity> Load<TEntity>();
        //    void Create<TEntity>(TEntity entity);
        //    void Update<TEntity>(TEntity entity);
        //    void Delete<TEntity>(TEntity entity);
        //}

        int Grabar<TCabecera, TDetalles>(TCabecera cab, TDetalles det)
        {
            //dddddd
            return 0;
        }

        //void TraerListado<T>() where T : class
        //{

        //    Repository<Parametros> repo = unitOfWork.ParametrosRepositorio;
        //    var q = repo.ObtenerTodos();

        //}

        //public FondoFijoRepositorio() // Implicitly chain to the parameterless base constructor
        //{
        //}

        //public FondoFijoRepositorio(DbContext contexto)
        //    : base(contexto) // Chain to parameterized constructor
        //{
        //}

        //public ProntoMVC.Data.Models.DemoProntoEntities HACKEADOcontext
        //{
        //    get
        //    {
        //        return (ProntoMVC.Data.Models.DemoProntoEntities)context;
        //    }
        //}



        // esto es un repositorio generico?
        //    public virtual ComprobanteProveedor ObtenerPorId(int id)
        //    {
        //        // http://stackoverflow.com/questions/1230571/advantage-of-creating-a-generic-repository-vs-specific-repository-for-each-obje

        //        //trampa: esta es una implementacion del metodo virtual de lo que sería un repositorio específico de ComprobanteProveedor
        //        ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)context;

        //        return c.ComprobantesProveedor
        //                        .Include(x => x.DetalleComprobantesProveedores)
        //                        .Include(x => x.Proveedor)
        //                       .Include(x => x.Proveedore)
        //                       .Include(x => x.Obra)
        //                       .Include(x => x.Cuenta)
        //                       .SingleOrDefault(x => x.IdComprobanteProveedor == id);


        //    }


        //    public virtual void Actualizar(ComprobanteProveedor ComprobanteProveedor)
        //    {

        //        /*
        //        //como hago usar estas llamadas al db?
        //    http://programmers.stackexchange.com/questions/170120/how-should-i-implement-the-repository-pattern-for-complex-object-models
        //    http://programmers.stackexchange.com/questions/180851/why-shouldnt-i-use-the-repository-pattern-with-entity-framework
        //        http://stackoverflow.com/questions/7171023/repository-pattern-with-entity-framework-4-1-and-parent-child-relationships
        //         * http://stackoverflow.com/questions/20471927/how-to-fake-dbcontext-entry-method-in-entity-framework-with-repository-pattern

        //         * supongamos que en este servicio no uso repositorio. Me tienen que pasar el db (que es el unitofwork)
        //         * 


        //         What I mean here, is that in your object model, some entities are likely contained in others in a master-detail relationship. If your entity is highly dependant on another, do not create a repository for this entity alone because it won't likely be persisted by itself. Instead, you will create a repository for each parent class, and you will make sure that the child entities and other relations are persisted at the same time

        //         http://stackoverflow.com/questions/7171023/repository-pattern-with-entity-framework-4-1-and-parent-child-relationships
        //         http://stackoverflow.com/questions/6904139/fake-dbcontext-of-entity-framework-4-1-to-test/6904479#6904479
        //         -The primary reason why I want to use this pattern is to avoid calling EF 4.1 specific data access operations from the domain. I'd rather call generic CRUD operations from a IRepository interface. This will make testing easier
        //        -NO, it will not make your testing easier. You exposed IQueryable so your repository is not unit testable.

        //        http://stackoverflow.com/questions/718624/to-return-iqueryablet-or-not-return-iqueryablet
        //        The cons; non-testability:
        //         */




        //        var EntidadOriginal = ObtenerPorId(ComprobanteProveedor.IdComprobanteProveedor);




        //        var EntidadEntry = Entry(EntidadOriginal);
        //        EntidadEntry.CurrentValues.SetValues(ComprobanteProveedor);

        //        foreach (var dr in ComprobanteProveedor.DetalleComprobantesProveedores)
        //        {
        //            var DetalleEntidadOriginal = EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor == dr.IdDetalleComprobanteProveedor && dr.IdDetalleComprobanteProveedor > 0).SingleOrDefault();
        //            if (DetalleEntidadOriginal != null)
        //            {
        //                var DetalleEntidadEntry = Entry(DetalleEntidadOriginal);
        //                DetalleEntidadEntry.CurrentValues.SetValues(dr);
        //            }
        //            else
        //            {
        //                EntidadOriginal.DetalleComprobantesProveedores.Add(dr);
        //            }
        //        }

        //        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor != 0).ToList())
        //        {
        //            if (!ComprobanteProveedor.DetalleComprobantesProveedores.Any(c => c.IdDetalleComprobanteProveedor == DetalleEntidadOriginal.IdDetalleComprobanteProveedor))
        //                EntidadOriginal.DetalleComprobantesProveedores.Remove(DetalleEntidadOriginal);
        //        }



        //        SetModified(EntidadOriginal);
        //    }



        //    public virtual IQueryable<ComprobanteProveedor> ObtenerTodos()
        //    {
        //        /*
        //               On the other hand, now you have given your users a shotgun. They can do things which you may not have intended 
        //               (over using .include(), doing heavy heavy queries and doing "in-memory" filtering in their respective 
        //               implementations, etc..), which would basically side-step the layering and behavioral controls because 
        //               you have given full access.
        //         * 
        //         * http://stackoverflow.com/questions/11964578/repository-iqueryable-query-object
        //         * http://ayende.com/blog/4784/architecting-in-the-pit-of-doom-the-evils-of-the-repository-abstraction-layer
        //         * 
        //               */

        //        ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)context;

        //        return c.ComprobantesProveedor
        //                 .Include(x => x.DetalleComprobantesProveedores)
        //                 .Include(x => x.DescripcionIva)
        //                 .Include(x => x.Cuenta)
        //                 .Include(x => x.Proveedor)
        //                 .Include(x => x.Proveedore)
        //                 .Include(x => x.Obra)
        //                     .Where(x => x.IdCuenta != null)
        //                           .AsQueryable();
        //    }
    }
}
