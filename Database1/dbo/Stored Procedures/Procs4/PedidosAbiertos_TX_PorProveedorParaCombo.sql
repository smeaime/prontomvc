




CREATE Procedure [dbo].[PedidosAbiertos_TX_PorProveedorParaCombo]
@IdProveedor int
AS 
SELECT 
 IdPedidoAbierto,
 NumeroPedidoAbierto as [Titulo]
FROM PedidosAbiertos
WHERE IdProveedor=@IdProveedor
ORDER BY NumeroPedidoAbierto




