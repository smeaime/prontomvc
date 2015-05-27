




CREATE Procedure [dbo].[PedidosAbiertos_TX_TT]
@IdPedidoAbierto int
AS 
SELECT 
 IdPedidoAbierto,
 NumeroPedidoAbierto as [Nro.Pedido],
 FechaPedidoAbierto as [Fecha pedido],
 Proveedores.RazonSocial as [Proveedor],
 FechaLimite as [Fecha limite],
 ImporteLimite as [Importe limite]
FROM PedidosAbiertos
LEFT OUTER JOIN Proveedores ON PedidosAbiertos.IdProveedor=Proveedores.IdProveedor
WHERE (IdPedidoAbierto=@IdPedidoAbierto)




