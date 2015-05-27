CREATE PROCEDURE [dbo].[OrdenesCompra_TX_DetalladoEntreFechas]

@Desde datetime,
@Hasta datetime

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111111111111133'
SET @vector_T='04934220E12023052520620600'

SELECT
 doc.IdDetalleOrdenCompra as [IdDetalleOrdenCompra],
 OrdenesCompra.NumeroOrdenCompraCliente as [Orden de compra],
 doc.IdDetalleOrdenCompra as [IdAux],
 OrdenesCompra.NumeroOrdenCompra as [Nro. interno],
 OrdenesCompra.FechaOrdenCompra [Fecha],
 Clientes.RazonSocial as [Cliente],
 Vendedores.Nombre as [Vendedor], 
 ListasPrecios.Descripcion as [Lista],
 Articulos.Descripcion as [Articulo],
 Colores.Descripcion as [Color],
 doc.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 doc.Precio as [Precio],
 (doc.Cantidad * doc.Precio) * (1-IsNull(doc.PorcentajeBonificacion,0)/100) as [Importe],
 Monedas.Abreviatura as [Mon.],
 doc.FechaEntrega as [Fecha entrega],
 E1.Nombre as [Ingreso],
 OrdenesCompra.FechaIngreso as [Fecha ingreso],
 IsNull(doc.Estado,'') as [Producido],
 E2.Nombre as [Marco como producido],
 doc.FechaCambioEstado as [Fecha marcado producido],
 IsNull(doc.Cumplido,'NO') as [Cumplido],
 E3.Nombre as [Dio por Cumplido],
 doc.FechaDadoPorCumplido as [Fecha dio por Cumplido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=OrdenesCompra.IdCliente
LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=Clientes.Vendedor1
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=OrdenesCompra.IdMoneda
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=OrdenesCompra.IdUsuarioIngreso
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=doc.IdUsuarioCambioEstado
LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado=doc.IdDioPorCumplido
LEFT OUTER JOIN ListasPrecios ON ListasPrecios.IdListaPrecios=OrdenesCompra.IdListaPrecios
LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
WHERE OrdenesCompra.FechaOrdenCompra Between @Desde And DATEADD(n,1439,@hasta) and IsNull(OrdenesCompra.Anulada,'NO')<>'SI'