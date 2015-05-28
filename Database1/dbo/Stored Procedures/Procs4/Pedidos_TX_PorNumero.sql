CREATE Procedure [dbo].[Pedidos_TX_PorNumero]

@NumeroPedido int,
@SubNumero int,
@IdPuntoVenta int = Null,
@Exterior int = Null,
@IdProveedor int = Null

AS 

SET @IdPuntoVenta=IsNull(@IdPuntoVenta,-1)
SET @Exterior=IsNull(@Exterior,-1)
--SET @IdProveedor=IsNull(@IdProveedor,-1)
SET @IdProveedor=-1

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111133'
SET @vector_T='0E9942900'

SELECT 
 Pedidos.IdPedido as [IdPedido],
 Case When IsNull(Pedidos.PuntoVenta,0)<>0 
	Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
 End as [Pedido],
 Pedidos.IdPedido as [IdAux],
 Pedidos.IdProveedor as [IdProveedor],
 FechaPedido [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 Pedidos.CircuitoFirmasCompleto as [CircuitoFirmasCompleto],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
WHERE NumeroPedido=@NumeroPedido and SubNumero=@SubNumero and 
	(@IdPuntoVenta=-1 or IdPuntoVenta=@IdPuntoVenta) and 
	(@Exterior=-1 or (@Exterior=0 and IsNull(PedidoExterior,'NO')='NO') or (@Exterior=1 and IsNull(PedidoExterior,'NO')='SI')) and 
	(@IdProveedor=-1 or Pedidos.IdProveedor=@IdProveedor)