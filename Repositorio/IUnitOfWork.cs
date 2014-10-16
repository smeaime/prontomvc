using NebarisMVC.Data;

namespace NebarisMVC.Repositorio
{
    public interface IUnitOfWork
    {
        void Save();

        IRepository<BlogPost> BlogPostRepositorio { get; }
        IRepository<Autor> AutorRepositorio { get; }
        IRepository<Tag> TagRepositorio { get; }
        IRepository<ValorEstatico> ValorEstaticoRepositorio { get; }
        IRepository<Usuario> UsuarioRepositorio { get; }
        IRepository<Rol> RolRepositorio { get; }
        IRepository<Curso> CursoRepositorio { get; }
        IRepository<Capitulo> CapituloRepositorio { get; }
        IRepository<Video> VideoRepositorio { get; }
        IRepository<Seccion> SeccionRepositorio { get; }
        IRepository<IntentosLogin> IntentosLoginRepositorio { get; }
        IRepository<Pais> PaisRepositorio { get; }
        IRepository<IntentosRegistro> IntentosRegistroRepositorio { get; }
        IRepository<Token> TokenRepositorio { get; }
        IRepository<Error> ErrorRepositorio { get; }
        IRepository<VideoVisto> VideosVistosRepositorio { get; }
        IRepository<Punto> PuntoRepositorio { get; }
        IRepository<Conversacion> ConversacionesRepositorio { get; }
        IRepository<Comentario> ComentariosRepositorio { get; }
        IRepository<Pago> PagosRepositorio { get; }
        IRepository<Producto> ProductoRepositorio { get; }
    }
}
