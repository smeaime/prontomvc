using System.Linq;
using Data;
using Repo;

namespace Servicio
{
    public class MeowService
    {
        private Repository<Meow> meowRepository;
        private UsuarioService usuarioService;

        public MeowService(UnitOfWork unitOfWork)
        {
            meowRepository = unitOfWork.MeowRepositorio;
            usuarioService = new UsuarioService(unitOfWork);
        }

        public void Guardar(Meow meow)
        {
            meowRepository.Insertar(meow);
        }

        public System.Collections.Generic.List<Meow> ObtenerTodosPorUsuario(int codigoUsuario)
        {
            var codigos = usuarioService.ObtenerCodigosDeUsuariosSeguidos();
            return meowRepository
                .ObtenerTodos()
                .Where(m => (m.CodigoUsuario == codigoUsuario) ||
                            (codigos.Contains(m.CodigoUsuario)))
                .OrderByDescending(m => m.Fecha).ToList();
        }

        public int ObtenerCantidadPorUsuario(int codigoUsuario)
        {
            return meowRepository.ObtenerTodos().Count(m => m.CodigoUsuario == codigoUsuario);
        }
    }
}
