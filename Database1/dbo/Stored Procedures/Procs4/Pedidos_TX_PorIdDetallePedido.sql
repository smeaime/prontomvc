




CREATE Procedure [dbo].[Pedidos_TX_PorIdDetallePedido]
@IdDetallePedido int,
@IdCostoImportacion int
AS 
SELECT 
 IdDetallePedido,
 Pedidos.NumeroPedido,
 Pedidos.FechaPedido,
 Proveedores.RazonSocial as [Proveedor],
 DetallePedidos.Cantidad,
 (Select CostosImportacion.PrecioTotal 
  From CostosImportacion
  Where CostosImportacion.IdCostoImportacion=@IdCostoImportacion) as [Costo]
FROM DetallePedidos
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetallePedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Pedidos.IdProveedor
WHERE DetallePedidos.IdDetallePedido=@IdDetallePedido




