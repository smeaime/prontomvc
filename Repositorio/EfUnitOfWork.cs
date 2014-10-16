using System;
using NebarisMVC.Data;

namespace NebarisMVC.Repositorio
{
    public sealed class EfUnitOfWork : IDisposable, IUnitOfWork 
    {
        private readonly NebarisMvcContext _contexto;

        public EfUnitOfWork()
        {
            _contexto = new NebarisMvcContext();
        }

        public void Save()
        {
            _contexto.SaveChanges();
        }

        private bool _disposed = false;

        private void Dispose(bool disposing)
        {
            if (!this._disposed)
            {
                if (disposing)
                {
                    _contexto.Dispose();
                }
            }

            this._disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private EfRepository<BlogPost> blogPostRepositorio;
        public IRepository<BlogPost> BlogPostRepositorio
        {
            get
            {

                if (this.blogPostRepositorio == null)
                {
                    this.blogPostRepositorio = new EfRepository<BlogPost>(_contexto);
                }
                return blogPostRepositorio;
            }
        }

        private EfRepository<Autor> autorRepositorio;
        public IRepository<Autor> AutorRepositorio
        {
            get
            {

                if (this.autorRepositorio == null)
                {
                    this.autorRepositorio = new EfRepository<Autor>(_contexto);
                }
                return autorRepositorio;
            }
        }

        private EfRepository<Tag> tagRepositorio;
        public IRepository<Tag> TagRepositorio
        {
            get
            {

                if (this.tagRepositorio == null)
                {
                    this.tagRepositorio = new EfRepository<Tag>(_contexto);
                }
                return tagRepositorio;
            }
        }

        private EfRepository<ValorEstatico> valorEstaticoRepositorio;
        public IRepository<ValorEstatico> ValorEstaticoRepositorio
        {
            get
            {

                if (this.valorEstaticoRepositorio == null)
                {
                    this.valorEstaticoRepositorio = new EfRepository<ValorEstatico>(_contexto);
                }
                return valorEstaticoRepositorio;
            }
        }


        private EfRepository<Usuario> usuarioRepositorio;
        public IRepository<Usuario> UsuarioRepositorio
        {
            get
            {

                if (this.usuarioRepositorio == null)
                {
                    this.usuarioRepositorio = new EfRepository<Usuario>(_contexto);
                }
                return usuarioRepositorio;
            }
        }

        private EfRepository<Rol> rolRepositorio;
        public IRepository<Rol> RolRepositorio
        {
            get
            {

                if (this.rolRepositorio == null)
                {
                    this.rolRepositorio = new EfRepository<Rol>(_contexto);
                }
                return rolRepositorio;
            }
        }

        private EfRepository<Curso> cursoRepositorio;
        public IRepository<Curso> CursoRepositorio
        {
            get
            {

                if (this.cursoRepositorio == null)
                {
                    this.cursoRepositorio = new EfRepository<Curso>(_contexto);
                }
                return cursoRepositorio;
            }
        }

        private EfRepository<Capitulo> capituloRepositorio;
        public IRepository<Capitulo> CapituloRepositorio
        {
            get
            {

                if (this.capituloRepositorio == null)
                {
                    this.capituloRepositorio = new EfRepository<Capitulo>(_contexto);
                }
                return capituloRepositorio;
            }
        }

        private EfRepository<Video> videoRepositorio;
        public IRepository<Video> VideoRepositorio
        {
            get
            {

                if (this.videoRepositorio == null)
                {
                    this.videoRepositorio = new EfRepository<Video>(_contexto);
                }
                return videoRepositorio;
            }
        }

        private EfRepository<Seccion> seccionRepositorio;
        public IRepository<Seccion> SeccionRepositorio
        {
            get
            {

                if (this.seccionRepositorio == null)
                {
                    this.seccionRepositorio = new EfRepository<Seccion>(_contexto);
                }
                return seccionRepositorio;
            }
        }

        private EfRepository<IntentosLogin> intentosLoginRepositorio;
        public IRepository<IntentosLogin> IntentosLoginRepositorio
        {
            get
            {

                if (this.intentosLoginRepositorio == null)
                {
                    this.intentosLoginRepositorio = new EfRepository<IntentosLogin>(_contexto);
                }
                return intentosLoginRepositorio;
            }
        }

        private EfRepository<IntentosRegistro> intentosRegistroRepositorio;
        public IRepository<IntentosRegistro> IntentosRegistroRepositorio
        {
            get
            {

                if (this.intentosRegistroRepositorio == null)
                {
                    this.intentosRegistroRepositorio = new EfRepository<IntentosRegistro>(_contexto);
                }
                return intentosRegistroRepositorio;
            }
        }

        private EfRepository<Token> tokenRepositorio;
        public IRepository<Token> TokenRepositorio
        {
            get
            {

                if (this.tokenRepositorio == null)
                {
                    this.tokenRepositorio = new EfRepository<Token>(_contexto);
                }
                return tokenRepositorio;
            }
        }

        private EfRepository<Pais> paisRepositorio;
        public IRepository<Pais> PaisRepositorio
        {
            get
            {

                if (this.paisRepositorio == null)
                {
                    this.paisRepositorio = new EfRepository<Pais>(_contexto);
                }
                return paisRepositorio;
            }
        }

        private EfRepository<Error> errorRepositorio;
        public IRepository<Error> ErrorRepositorio
        {
            get
            {

                if (this.errorRepositorio == null)
                {
                    this.errorRepositorio = new EfRepository<Error>(_contexto);
                }
                return errorRepositorio;
            }
        }

        private EfRepository<VideoVisto> videosVistosRepositorio;
        public IRepository<VideoVisto> VideosVistosRepositorio
        {
            get
            {

                if (this.videosVistosRepositorio == null)
                {
                    this.videosVistosRepositorio = new EfRepository<VideoVisto>(_contexto);
                }
                return videosVistosRepositorio;
            }
        }

        private EfRepository<Punto> puntoRepositorio;
        public IRepository<Punto> PuntoRepositorio
        {
            get
            {

                if (this.puntoRepositorio == null)
                {
                    this.puntoRepositorio = new EfRepository<Punto>(_contexto);
                }
                return puntoRepositorio;
            }
        }

        private EfRepository<Conversacion> conversacionesRepositorio;
        public IRepository<Conversacion> ConversacionesRepositorio
        {
            get
            {

                if (this.conversacionesRepositorio == null)
                {
                    this.conversacionesRepositorio = new EfRepository<Conversacion>(_contexto);
                }
                return conversacionesRepositorio;
            }
        }

        private IRepository<Comentario> comentariosRepositorio;
        public IRepository<Comentario> ComentariosRepositorio
        {
            get
            {

                if (this.comentariosRepositorio == null)
                {
                    this.comentariosRepositorio = new EfRepository<Comentario>(_contexto);
                }
                return comentariosRepositorio;
            }
        }

        private IRepository<Pago> pagosRepositorio;
        public IRepository<Pago> PagosRepositorio
        {
            get
            {

                if (this.pagosRepositorio == null)
                {
                    this.pagosRepositorio = new EfRepository<Pago>(_contexto);
                }
                return pagosRepositorio;
            }
        }

        private IRepository<Producto> productoRepositorio;
        public IRepository<Producto> ProductoRepositorio
        {
            get
            {

                if (this.productoRepositorio == null)
                {
                    this.productoRepositorio = new EfRepository<Producto>(_contexto);
                }
                return productoRepositorio;
            }
        }
    }
}
