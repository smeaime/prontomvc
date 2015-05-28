
CREATE Procedure [dbo].[Pedidos_TX_CuentasContablesPorIdPedido]

@IdPedido int

AS 

SELECT  
 Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+
	Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+
	Convert(varchar,IsNull(Pedidos.SubNumero,0)) as [Pedido],
 Convert(varchar,IsNull(Cuentas.codigo,''))+' '+Cuentas.Descripcion as [Cuenta]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
WHERE DetPed.IdPedido=@IdPedido
GROUP BY Pedidos.NumeroPedido,Pedidos.SubNumero,Cuentas.codigo,Cuentas.Descripcion
ORDER BY Pedidos.NumeroPedido,Pedidos.SubNumero,Cuentas.codigo
