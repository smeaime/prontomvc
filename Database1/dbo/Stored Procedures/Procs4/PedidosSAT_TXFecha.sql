
CREATE PROCEDURE [dbo].[PedidosSAT_TXFecha]

@Desde datetime,
@Hasta datetime

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111666661111111133'
SET @vector_T='055555555055551E200'

SELECT 
 Ped.IdPedido,
 Case 	When Ped.SubNumero is not null 
	Then str(Ped.NumeroPedido,8)+' / '+str(Ped.SubNumero,4)
	Else str(Ped.NumeroPedido,8)
 End as [Pedido],
 Ped.FechaPedido [Fecha],
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
  Where Empleados.IdEmpleado=Ped.IdComprador) as [Comprador],
 (Select Top 1 Empleados.Nombre
  from Empleados
  Where Empleados.IdEmpleado=Ped.Aprobo) as [Liberado por],
 (Select Count(*) From DetallePedidos 
  Where DetallePedidos.IdPedido=Ped.IdPedido) as [Cant.Items],
 NumeroComparativa as [Comparativa],
 Ped.Observaciones,
 DetalleCondicionCompra as [Aclaracion s/condicion de compra],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM PedidosSAT Ped
LEFT OUTER JOIN Proveedores ON Ped.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON Ped.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Ped.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
WHERE Ped.FechaPedido Between @Desde And @Hasta
ORDER BY NumeroPedido,SubNumero
