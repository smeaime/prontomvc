
















CREATE  Procedure [dbo].[Pedidos_TX_Cumplidos]
AS 
SELECT 
IdPedido,
Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
End as [Pedido],
FechaPedido [Fecha],
Pedidos.Cumplido as [Cump.],
Proveedores.RazonSocial as [Proveedor],
Bonificacion,
TotalIva1,
TotalIva2,
TotalPedido as [Total pedido],
(Select Top 1 Empleados.Nombre
 from Empleados
 Where Empleados.IdEmpleado=Pedidos.IdComprador) as [Comprador],
(Select Top 1 Empleados.Nombre
 from Empleados
 Where Empleados.IdEmpleado=Pedidos.Aprobo) as [Liberado por],
(Select Count(*) From DetallePedidos 
 Where DetallePedidos.IdPedido=Pedidos.IdPedido) as [Cant.Items],
NumeroComparativa as [Comparativa],
Case 	When Pedidos.TipoCompra=1 Then 'Gestion por compras'
	When Pedidos.TipoCompra=2 Then 'Gestion por terceros'
	Else Null
End as [Tipo compra]
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
WHERE Pedidos.Cumplido='SI' or Pedidos.Cumplido='AN'
ORDER BY NumeroPedido

















