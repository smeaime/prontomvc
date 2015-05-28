CREATE  Procedure [dbo].[Requerimientos_TX_Desliberados]

@FechaDesde datetime,
@FechaHasta datetime,
@IdObra int 

AS 

DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='011111111111111111111133'
SET @vector_T='0314F222E0442E4322E04400'

SELECT 
 DetReq.IdDetalleRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero RM],
 DetReq.NumeroItem as [Item RM],
 Requerimientos.FechaRequerimiento as [Fecha RM],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 DetReq.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Articulo],
 E1.Nombre as [Deslibero],
 Requerimientos.FechaDesliberacion as [Fecha deslibero],
 Requerimientos.NumeradorDesliberaciones as [Veces desliberado],
 Requerimientos.Observaciones as [Observaciones],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido], 
 Pedidos.FechaPedido as [Fecha pedido], 
 DetPed.NumeroItem as [Item pedido],
 DetPed.Cantidad as [Cant.pedido],
 A2.Codigo as [Codigo.],
 A2.Descripcion as [Articulo.],
 E2.Nombre as [Elimino firmas],
 Requerimientos.FechaEliminacionFirmas as [Fecha elimicacion firmas],
 Requerimientos.NumeradorEliminacionesFirmas as [Veces eliminacion firmas],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
LEFT OUTER JOIN Obras ON Obras.IdObra = Requerimientos.IdObra
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = DetReq.IdUnidad
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Requerimientos.IdUsuarioDeslibero
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdUsuarioEliminoFirmas
LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento and IsNull(DetPed.Cumplido,'NO')<>'AN' 
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetPed.IdPedido
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetReq.IdArticulo
LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetPed.IdArticulo
WHERE (IsNull(Requerimientos.NumeradorDesliberaciones,0)>0 or IsNull(Requerimientos.NumeradorEliminacionesFirmas,0)>0) and 
	(Requerimientos.FechaRequerimiento Between @FechaDesde and @FechaHasta) and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) 
ORDER BY Requerimientos.NumeroRequerimiento, DetReq.NumeroItem, [Pedido]