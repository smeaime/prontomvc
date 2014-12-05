

namespace ProntoMVC.Data.Models
{
    public partial class ComprobanteProveedor : IEntity
    {

        public int ID { get { return this.IdComprobanteProveedor; } }
    }

    public partial class DetalleComprobantesProveedore : IEntity
    {

        public int ID { get { return this.IdDetalleComprobanteProveedor; } }
    }

    public partial class Parametros : IEntity
    {

        public int ID { get { return this.IdParametro; } }
    }

    public partial class Condiciones_Compra : IEntity
    {

        public int ID { get { return this.IdCondicionCompra; } }
    }

    public partial class Empleado : IEntity
    {

        public int ID { get { return this.IdEmpleado; } }
    }

    public partial class PlazosEntrega : IEntity
    {

        public int ID { get { return this.IdPlazoEntrega; } }
    }

    public partial class Moneda : IEntity
    {

        public int ID { get { return this.IdMoneda; } }
    }
}
