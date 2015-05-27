




CREATE PROCEDURE [dbo].[Pedidos_TX_ParaComboAsignacionImportacion]

@IdArticulo int

AS

SELECT
 DetPed.IdDetallePedido,
 'Pedido : ' + Convert(varchar(8),Pedidos.NumeroPedido) + ' del  ' + 
	Convert(varchar,Pedidos.FechaPedido,103) + '  -  Cant. : ' + 
	Convert(varchar,DetPed.Cantidad) + '  [ ' + 
	Proveedores.RazonSocial + ' ]' as [Titulo]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetPed.IdPedido
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Pedidos.IdProveedor
WHERE DetPed.IdArticulo = @IdArticulo And DetPed.IdAsignacionCosto is null
ORDER By Pedidos.FechaPedido,Pedidos.NumeroPedido





