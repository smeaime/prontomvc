
















CREATE  Procedure [dbo].[Pedidos_TX_TodosConCodigoSAP]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111111111111133'
set @vector_T='055555555555557900'
SELECT 
IdPedido,
Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
End as [Pedido],
FechaPedido [Fecha],
Pedidos.Cumplido as [Cump.],
Proveedores.CodigoEmpresa [Cod.SAP],
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
End as [Tipo compra],
IdPedido,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
WHERE Pedidos.Cumplido is null or Pedidos.Cumplido='NO'
ORDER BY NumeroPedido,SubNumero

















