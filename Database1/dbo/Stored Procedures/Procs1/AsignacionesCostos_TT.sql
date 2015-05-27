






CREATE Procedure [dbo].[AsignacionesCostos_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='025555500'
SELECT 
 AsignacionesCostos.IdAsignacionCosto,
 Convert(varchar,FechaAsignacion,103) as [Fecha asig.],
 Pedidos.NumeroPedido as [Pedido],
 Pedidos.FechaPedido as [Fecha pedido],
 Proveedores.RazonSocial as [Proveedor],
 DetallePedidos.Cantidad as [Cantidad],
 CostosImportacion.PrecioTotal as [Costo asig.$],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AsignacionesCostos
LEFT OUTER JOIN CostosImportacion ON CostosImportacion.IdCostoImportacion=AsignacionesCostos.IdCostoImportacion
LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido=AsignacionesCostos.IdDetallePedido
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetallePedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Pedidos.IdProveedor






