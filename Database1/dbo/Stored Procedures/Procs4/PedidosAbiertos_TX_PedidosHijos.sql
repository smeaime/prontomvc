
CREATE PROCEDURE [dbo].[PedidosAbiertos_TX_PedidosHijos]

@IdPedidoAbierto int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111666661111111111133'
set @vector_T='05515555550555575910300'

SELECT 
 Pedidos.IdPedido,
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
 End as [Pedido],
 Pedidos.FechaPedido [Fecha],
 Pedidos.Cumplido as [Cump.],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When TotalIva2 is null
	 Then TotalPedido-TotalIva1+Bonificacion
	 Else TotalPedido-TotalIva1-TotalIva2+Bonificacion
 End as [Neto gravado],
 Case 	When Bonificacion=0
	 Then Null
	 Else Bonificacion
 End as [Bonificacion], 
 Case 	When TotalIva1=0
	 Then Null
	 Else TotalIva1
 End as [Total Iva],
 Case 	When TotalIva2=0
	 Then Null
	 Else TotalIva2
 End as [Total Iva Ad.],
 Pedidos.TotalPedido as [Total pedido],
 Monedas.Nombre as [Moneda],
 (Select Top 1 Empleados.Nombre
  from Empleados
  Where Empleados.IdEmpleado=Pedidos.IdComprador) as [Comprador],
 (Select Top 1 Empleados.Nombre
  from Empleados
  Where Empleados.IdEmpleado=Pedidos.Aprobo) as [Liberado por],
 (Select Count(*) From DetallePedidos 
  Where DetallePedidos.IdPedido=Pedidos.IdPedido) as [Cant.Items],
 Pedidos.NumeroComparativa as [Comparativa],
 Case 	When Pedidos.TipoCompra=1 Then 'Gestion por compras'
	When Pedidos.TipoCompra=2 Then 'Gestion por terceros'
	Else Null
 End as [Tipo compra],
 Pedidos.Consorcial,
 Pedidos.IdPedido,
 Pedidos.Observaciones,
 DetalleCondicionCompra as [Aclaracion s/condicion de compra],
 Case When IsNull(PedidoExterior,'NO')='SI'
	Then 'SI'
	Else Null
 End as [Ext.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
WHERE ISNull(Pedidos.IdPedidoAbierto,0)=@IdPedidoAbierto
ORDER BY NumeroPedido,SubNumero
