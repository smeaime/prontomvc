




CREATE PROCEDURE [dbo].[Obras_TX_EstadoObras_DetallePedidosDesdeAcopio]

@IdDetalleAcopios as int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111100033'
set @vector_T='01904104100300000'

SELECT
 DetallePedidos.IdDetallePedido,
 Pedidos.NumeroPedido as [Pedido],
 DetallePedidos.IdPedido,
 DetallePedidos.NumeroItem as [Item],
 Pedidos.FechaPedido as [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 Empleados.Nombre as [Comprador],
 DetallePedidos.FechaEntrega as [F.entrega],
 DetallePedidos.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unid.],
 Monedas.Abreviatura as [Mon.],
 Case 	When Pedidos.TotalIva1 is not null Then Pedidos.TotalPedido-Pedidos.TotalIva1
	Else Pedidos.TotalPedido
 End as [Importe s/iva],
 DetallePedidos.Precio,
 DetallePedidos.Cumplido,
 (DetallePedidos.Cantidad*DetallePedidos.Precio) as [ImporteItem],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Empleados ON Pedidos.IdComprador = Empleados.IdEmpleado
LEFT OUTER JOIN Unidades ON DetallePedidos.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
WHERE DetallePedidos.IdDetalleAcopios=@IdDetalleAcopios and 
	(Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and 
	(DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')  
ORDER By Pedidos.NumeroPedido




