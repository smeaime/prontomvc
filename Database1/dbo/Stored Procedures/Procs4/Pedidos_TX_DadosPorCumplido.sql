
CREATE PROCEDURE [dbo].[Pedidos_TX_DadosPorCumplido]

@FechaDesde datetime, 
@FechaHasta datetime

AS

DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='011111111111133'
SET @vector_T='0D4404E22114400'

SELECT 
 DetPed.IdDetallePedido,
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 Pedidos.FechaPedido as [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 DetPed.NumeroItem as [Item],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetPed.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 E1.Nombre as [Autorizo cumplido],
 E1.Nombre as [Dio por cumplido],
 DetPed.FechaDadoPorCumplido as [Fecha dado x cumplido],
 DetPed.ObservacionesCumplido as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetPed.IdPedido
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Pedidos.IdProveedor
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetPed.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=DetPed.IdUnidad
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=DetPed.IdAutorizoCumplido
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=DetPed.IdDioPorCumplido
WHERE DetPed.IdDioPorCumplido is not null and Pedidos.FechaPedido Between @FechaDesde And @FechaHasta
ORDER BY Pedidos.NumeroPedido, Pedidos.FechaPedido
