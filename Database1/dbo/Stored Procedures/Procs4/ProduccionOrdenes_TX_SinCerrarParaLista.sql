CREATE Procedure ProduccionOrdenes_TX_SinCerrarParaLista

@IdArticuloFiltro int=0,
@IdArticuloMaterial int=0

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
---------------1...56...012345678901234567890	
Set @vector_X='00111111111111111111133'
Set @vector_T='009249919E1099999999900'

Select DISTINCT
 IdProduccionOrden as IdProduccionOrden2,
 IdProduccionOrden as IdProduccionOrden,
 NumeroOrdenProduccion,
 NumeroOrdenProduccion as [O. Produccion],
 FechaOrdenProduccion as [Fecha],

 0 as [Obra],
 Clientes.Codigo as [Codigo],
 Clientes.RazonSocial as [Cliente],
 0 as [Item],
 Articulos.Descripcion as [Articulo],

 Colores.Descripcion AS [Color],
 op.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 '' as [Mon.],
 0 as [Precio],

 0 as [Importe OC],
 0 as [Pend.facturar],
 0 as [Imp.pend.fact.],
 '' AS Observaciones,
 0 as [% Bon],

 OP.IdColor,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProduccionOrdenes OP
--LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN ProduccionFichas ON ProduccionFichas.IdArticuloAsociado=OP.IdArticuloGenerado
left outer join DetalleProduccionFichas DETFICH on DETFICH.IdProduccionFicha=ProduccionFichas.IdProduccionFicha
LEFT OUTER JOIN Clientes ON OP.Cliente = Clientes.IdCliente
LEFT OUTER JOIN Articulos ON OP.IdArticuloGenerado = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON OP.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON OP.IdColor = Colores.IdColor
--LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
--LEFT OUTER JOIN Monedas ON OrdenesCompra.IdMoneda = Monedas.IdMoneda
--LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=OP.IdProduccionProceso
WHERE (OP.IdArticuloGenerado=@IdArticuloFiltro OR @IdArticuloFiltro=0) AND
	(DETFICH.IdArticulo=@IdArticuloMaterial OR @IdArticuloMaterial=0)
		and (not OP.aprobo is null) --está aprobada
		AND (OP.Anulada<>'SI' OR OP.anulada IS NULL)	

--(OrdenesCompra.Anulada is null or OrdenesCompra.Anulada<>'SI') 
ORDER by IdProduccionOrden
