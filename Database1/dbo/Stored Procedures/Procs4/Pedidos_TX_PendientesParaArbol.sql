
CREATE  Procedure [dbo].[Pedidos_TX_PendientesParaArbol]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011116666611111111111133'
SET @vector_T='0E5155555505555759103100'

SELECT 
 IdPedido,
 Case When IsNull(Pedidos.PuntoVenta,0)<>0 
	Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
 End as [Pedido],
 FechaPedido [Fecha],
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
 TotalPedido as [Total pedido],
 Monedas.Nombre as [Moneda],
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
 Consorcial,
 IdPedido,
 Pedidos.Observaciones,
 DetalleCondicionCompra as [Aclaracion s/condicion de compra],
 Case When IsNull(PedidoExterior,'NO')='SI'
	Then 'SI'
	Else Null
 End as [Ext.],
 Pedidos.Impresa as [Impresa],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
WHERE (Pedidos.Cumplido<>'SI' and Pedidos.Cumplido<>'AN') or Pedidos.Cumplido is null
ORDER BY NumeroPedido,SubNumero
