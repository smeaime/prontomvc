CREATE PROCEDURE [dbo].[Pedidos_TX_Pendientes]

@IdProveedor int = Null,
@IdLugarEntrega int = Null

AS 

SET @IdProveedor=IsNull(@IdProveedor,0)
SET @IdLugarEntrega=IsNull(@IdLugarEntrega,0)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01101133'
SET @vector_T='05505900'

SELECT
 DetPed.IdPedido,
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
 End as [Pedido],
 Pedidos.FechaPedido as [Fecha],
 Pedidos.IdProveedor,
 Proveedores.RazonSocial as [Proveedor],
 DetPed.IdPedido,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
WHERE ((DetPed.Cumplido<>'SI' and DetPed.Cumplido<>'AN') or DetPed.Cumplido is null) and
	((Pedidos.Cumplido<>'SI' and Pedidos.Cumplido<>'AN') or Pedidos.Cumplido is null) and 
	(@IdProveedor<=0 or Pedidos.IdProveedor=@IdProveedor) and 
	(@IdLugarEntrega<=0 or Pedidos.IdLugarEntrega=@IdLugarEntrega)
GROUP BY DetPed.IdPedido,Pedidos.NumeroPedido,Pedidos.FechaPedido,Pedidos.IdProveedor,Proveedores.RazonSocial,Pedidos.SubNumero
ORDER BY Proveedores.RazonSocial