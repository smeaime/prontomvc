CREATE PROCEDURE [dbo].[Pedidos_TX_DetallesPorParametros]

@FechaDesde datetime, 
@FechaHasta datetime, 
@IdProveedor int = Null,
@IdObra int = Null,
@IdArticulo int = Null,
@NumeroPedido int = Null

AS

SET NOCOUNT ON

SET @IdProveedor=IsNull(@IdProveedor,-1)
SET @IdObra=IsNull(@IdObra,-1)
SET @IdArticulo=IsNull(@IdArticulo,-1)
SET @NumeroPedido=IsNull(@NumeroPedido,-1)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='0111111111111133'
SET @vector_T='0D02E43442044000'

SELECT
 DetPed.IdDetallePedido,
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 DetPed.NumeroItem as [Item],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Articulo],
 DetPed.Observaciones as [Observacion item],
 Proveedores.RazonSocial as [Proveedor],
 Obras.NumeroObra as [Obra],
 Pedidos.FechaPedido as [Fecha],
 DetPed.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 DetPed.Precio as [Precio Un.],
 (DetPed.Cantidad*DetPed.Precio) - IsNull(ImporteBonificacion,0) as [Importe],
 Monedas.Abreviatura as [Mon.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetPed.IdArticulo
LEFT OUTER JOIN Obras ON Obras.IdObra = Requerimientos.IdObra
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = DetPed.IdUnidad
LEFT OUTER JOIN Empleados ON Pedidos.IdComprador = Empleados.IdEmpleado
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
WHERE Pedidos.FechaPedido Between @FechaDesde and @FechaHasta and IsNull(DetPed.Cumplido,'')<>'AN' and 
	(@IdProveedor<=0 or Pedidos.IdProveedor=@IdProveedor) and 
	(@IdObra<=0 or Requerimientos.IdObra=@IdObra) and 
	(@IdArticulo<=0 or DetPed.IdArticulo=@IdArticulo) and 
	(@NumeroPedido<=0 or Pedidos.NumeroPedido=@NumeroPedido) 
ORDER BY Pedidos.NumeroPedido, DetPed.NumeroItem