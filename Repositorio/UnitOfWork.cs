using System;
using ProntoMVC.Data.Models;
using System.Linq;
//using Data;

using System.Data.Entity;
using System.Data.Entity.Core.Objects;

namespace Repo
{
    public sealed class UnitOfWork : DbContext, IWriteEntities, IDisposable
    {
        private readonly DemoProntoEntities _contexto;

        //public UnitOfWork()
        //{
        //    _contexto = new DemoProntoEntities();
        //}


        public UnitOfWork(string sCadenaConexion)
        {
            _contexto = new DemoProntoEntities(sCadenaConexion);
        }


        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        // migrar

        public ObjectResult<Nullable<int>> CantidadAutorizaciones(Nullable<int> idFormulario, Nullable<decimal> importe, Nullable<int> idComprobante)
        {
            return _contexto.Autorizaciones_TX_CantidadAutorizaciones(idFormulario, importe, idComprobante);
        }

        public ObjectResult<AutorizacionesPorComprobante> AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(int idFormulario, int idComprobante)
        {
            return _contexto.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(idFormulario, idComprobante);
        }


        //public IQueryable<Empleado> Empleados()
        //{
        //    return _contexto.Empleados.AsQueryable();
        //}


        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////



        //private System.Collections.Generic.Dictionary<Type, object> _repositories;

        //public Repository<TEntity> GetRepository<TEntity>() where TEntity : class
        //{
        //    if (_repositories.Keys.Contains(typeof(TEntity)))
        //        return _repositories[typeof(TEntity)];

        //    var repository = new Repository<TEntity>(_ctx);
        //    _repositories.Add(typeof(TEntity), repository);
        //    return repository;
        //}




        public void Save()
        {
            _contexto.SaveChanges();
        }

        private bool _disposed = false;

        private void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _contexto.Dispose();
                }
            }

            _disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private Repository<Parametros> parametrosRepositorio;
        public Repository<Parametros> ParametrosRepositorio
        {
            get { return parametrosRepositorio ?? (parametrosRepositorio = new Repository<Parametros>(_contexto)); }
        }

        private Repository<ComprobanteProveedor> comprobantesproveedorRepositorio;
        public Repository<ComprobanteProveedor> ComprobantesproveedorRepositorio
        {
            get { return comprobantesproveedorRepositorio ?? (comprobantesproveedorRepositorio = new Repository<ComprobanteProveedor>(_contexto)); }
        }

        private Repository<DetalleComprobantesProveedore> detallecomprobantesproveedorRepositorio;
        public Repository<DetalleComprobantesProveedore> DetalleComprobantesproveedorRepositorio
        {
            get { return detallecomprobantesproveedorRepositorio ?? (detallecomprobantesproveedorRepositorio = new Repository<DetalleComprobantesProveedore>(_contexto)); }
        }

        private Repository<Condiciones_Compra> condicioncomprasRepositorio;
        public Repository<Condiciones_Compra> CondicioncomprasRepositorio
        {
            get { return condicioncomprasRepositorio ?? (condicioncomprasRepositorio = new Repository<Condiciones_Compra>(_contexto)); }
        }


        private Repository<Moneda> monedasRepositorio;
        public Repository<Moneda> MonedasRepositorio
        {
            get { return monedasRepositorio ?? (monedasRepositorio = new Repository<Moneda>(_contexto)); }
        }
        private Repository<PlazosEntrega> plazosentregasRepositorio;
        public Repository<PlazosEntrega> PlazosEntregasRepositorio
        {
            get { return plazosentregasRepositorio ?? (plazosentregasRepositorio = new Repository<PlazosEntrega>(_contexto)); }
        }

        private Repository<Empleado> empleadosRepositorio;
        public Repository<Empleado> EmpleadosRepositorio
        {
            get { return empleadosRepositorio ?? (empleadosRepositorio = new Repository<Empleado>(_contexto)); }
        }


        public IQueryable<TEntity> Query<TEntity>() where TEntity : class
        {
            return Set<TEntity>().AsNoTracking(); // detach results from context
        }

        public IQueryable<TEntity> Load<TEntity>() where TEntity : class
        {
            return Set<TEntity>();
        }

        public void Create<TEntity>(TEntity entity) where TEntity : class
        {
            if (Entry(entity).State == EntityState.Detached)
                Set<TEntity>().Add(entity);
        }


    }






}




public interface IUnitOfWork
{
    int SaveChanges();
}
public interface IReadEntities
{
    IQueryable<TEntity> Query<TEntity>() where TEntity : class;
}

public interface IWriteEntities : IReadEntities, IUnitOfWork
{
    IQueryable<TEntity> Load<TEntity>() where TEntity : class;
    void Create<TEntity>(TEntity entity) where TEntity : class;
    //void Update<TEntity>(TEntity entity) where TEntity : class;
    //void Delete<TEntity>(TEntity entity) where TEntity : class;
}
